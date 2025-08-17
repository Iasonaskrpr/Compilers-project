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
rm -f "$IR_DIR"/*.out "$IR_DIR"/*.tmpout "$TEST_DIR"/*.tmpout "$TEST_DIR"/*.class
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

    # Compile IR -> executable
    if ! clang -o "$exe_file" "$ir_file" 2>/dev/null; then
        echo "❌ LLVM compile failed"
        continue
    fi

    # Run LLVM executable
    "$exe_file" >"$IR_DIR/$base.llvm.tmpout" 2>&1

    # Compare outputs
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
    rm -rf "$IR_DIR"
fi
