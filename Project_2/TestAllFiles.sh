#!/bin/bash

TEST_DIR="TestFiles"
OFFSET_DIR="$TEST_DIR/offset-examples"
CORRECT=0
TOTAL=0

# Compile the SemanticAnalyzer
javac SemanticAnalyzer.java || exit 1

for java_file in "$TEST_DIR"/*.java; do
    filename=$(basename "$java_file")
    base="${filename%.java}"
    expected_file="$OFFSET_DIR/$base.txt"

    echo -n "Testing $filename ... "
    TOTAL=$((TOTAL + 1))

    # Run and capture exit code
    java SemanticAnalyzer "$java_file" >/dev/null 2>&1
    status=$?

    if [[ -f "$expected_file" ]]; then
        if [[ $status -eq 0 ]]; then
            echo "✅ Passed"
            CORRECT=$((CORRECT + 1))
        else
            echo "❌ Failed (expected success)"
        fi
    else
        if [[ $status -ne 0 ]]; then
            echo "✅ Correctly failed"
            CORRECT=$((CORRECT + 1))
        else
            echo "❌ Unexpected success"
        fi
    fi
done

echo
echo "Correct: $CORRECT / $TOTAL"
