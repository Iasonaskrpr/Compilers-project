#!/bin/bash

TEST_DIR="TestFiles"
OFFSET_DIR="$TEST_DIR/offset-examples"
IR_DIR="IRFiles"
CORRECT=0
TOTAL=0
KEEP=false

# Έλεγχος για --keep
if [[ "$1" == "--keep" ]]; then
    KEEP=true
fi

# Καθαρισμός παλιών
rm -f "$IR_DIR"/*.out "$IR_DIR"/*.tmpout" "$TEST_DIR"/*.tmpout" "$TEST_DIR"/*.class
mkdir -p "$IR_DIR"
# Compile the CompilerManager
javac CompilerManager.java || exit 1

for java_file in "$TEST_DIR"/*.java; do
    filename=$(basename "$java_file")
    base="${filename%.java}"
    expected_file="$OFFSET_DIR/$base.txt"
    ir_file="$IR_DIR/$base.ll"
    exe_file="$IR_DIR/$base.out"

    echo -n "Testing $filename ... "
    TOTAL=$((TOTAL + 1))

    # Run CompilerManager (generate IR)
    java CompilerManager "$java_file" >/dev/null 2>&1
    status=$?

    if [[ -f "$expected_file" ]]; then
        if [[ $status -ne 0 ]]; then
            echo "❌ Failed (expected success)"
            continue
        fi
    else
        if [[ $status -eq 0 ]]; then
            echo "❌ Unexpected success"
        else
            echo "✅ Correctly failed"
            CORRECT=$((CORRECT + 1))
        fi
        continue
    fi

    # Compile & run original Java program
    javac "$java_file" || { echo "❌ javac failed"; continue; }
    java -cp "$TEST_DIR" "$base" >"$TEST_DIR/$base.java.tmpout" 2>&1
    java_exit=$?

    # Compile IR -> executable
    if ! clang -o "$exe_file" "$ir_file" 2>/dev/null; then
        echo "❌ LLVM compile failed"
        continue
    fi

    # Run LLVM executable
    "$exe_file" >"$IR_DIR/$base.llvm.tmpout" 2>&1
    llvm_exit=$?

    # Detect Java OOB/crash (or other runtime exceptions)
    if grep -q "ArrayIndexOutOfBoundsException" "$TEST_DIR/$base.java.tmpout" || grep -q "Exception in thread" "$TEST_DIR/$base.java.tmpout"; then
        # Java crashed (likely OOB). Expect LLVM to also abort/print OOB.
        if grep -q "Out of bounds" "$IR_DIR/$base.llvm.tmpout" || [[ $llvm_exit -ne 0 ]]; then
            echo "✅ Passed (Java crashed with OOB and LLVM aborted/printed OOB)"
            CORRECT=$((CORRECT + 1))
            # If you want to stop the whole test-suite at the first OOB, uncomment:
            # echo "Stopping test suite due to OOB (fail fast)."
            # exit 1
            continue
        else
            echo "❌ Output mismatch on OOB case (Java crashed but LLVM did not abort/print OOB)"
            echo "  Java output:"
            sed -n '1,12p' "$TEST_DIR/$base.java.tmpout"
            echo "  LLVM output:"
            sed -n '1,12p' "$IR_DIR/$base.llvm.tmpout"
            # stop immediately so make/CI sees the failure
            exit 1
        fi
    fi

    # Compare outputs for the normal (non-OOB) case
    if diff -q "$TEST_DIR/$base.java.tmpout" "$IR_DIR/$base.llvm.tmpout" >/dev/null; then
        echo "✅ Passed"
        CORRECT=$((CORRECT + 1))
    else
        echo "❌ Output mismatch"
        echo "  Differences:"
        diff "$TEST_DIR/$base.java.tmpout" "$IR_DIR/$base.llvm.tmpout"
    fi
done

echo
echo "Correct: $CORRECT / $TOTAL"

# Clean up unless --keep
if ! $KEEP; then
    rm -f "$TEST_DIR"/*.tmpout "$TEST_DIR"/*.class
    rm -rf "$IR_DIR"/*
fi
