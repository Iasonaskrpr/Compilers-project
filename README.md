# Part 1

## Overview
This project implements a simple calculator using a recursive descent parser. The calculator can evaluate arithmetic expressions that include addition, subtraction, multiplication (exponentiation), and parentheses.

It reads from an input stream (e.g., standard input or a file) and evaluates the expression according to the rules defined in the grammar. The parser is implemented in Java, and the program is capable of handling errors gracefully with custom exception handling.

## Features
- **Basic Arithmetic**: Supports `+`, `-`, and `*` (as exponentiation) operators.
- **Parentheses**: Allows grouping of expressions using parentheses for correct order of operations.
- **Error Handling**: If the expression is malformed, a `ParseError` is thrown.
- **Recursive Descent Parsing**: Implements a recursive descent parser to handle the input expression.

## How It Works

### Expression Grammar
The calculator parses and evaluates the following arithmetic expressions:
- **Addition**: `expr → expr + power`
- **Subtraction**: `expr → expr - power`
- **Exponentiation**: `power → number * number`
- **Parentheses**: Supports nested expressions like `( expr )`.

### Grammar Rules
expr -> power exprTail 
exprTail -> + power exprTail 
            | - power exprTail 
            | ε
power -> number powerTail
powerTail -> ** number powerTail 
            | ε
number -> digit numberTail 
        | ( expr )
numberTail -> digit numberTail 
            | ε
digit -> 0 - 9


### Evaluation Flow
1. **Main Function**:  
   The program begins by calling the `eval()` method, which starts the evaluation process by parsing the expression using the `expr()` method.

2. **Tokenization**:  
   The program processes characters from the input stream using a lookahead approach, consuming tokens one by one.

3. **Recursive Parsing**:  
   The parser recursively calls various methods (`expr()`, `exprTail()`, `power()`, etc.) to break down and evaluate the expression according to the defined grammar.

4. **Error Handling**:  
   If the expression does not follow the grammar's rules, a `ParseError` is thrown to notify the user about the malformed expression.