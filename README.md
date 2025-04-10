# Compilers Project


## Part1


## Overview
In this part I implemented a simple calculator using a recursive descent parser. The calculator can evaluate arithmetic expressions that include addition, subtraction and exponentiation.

It reads from standard input and evaluates the expression according to the rules defined in the grammar. The parser is implemented in Java, and the program is capable of handling errors gracefully with custom exception handling.

## Features
- **Basic Arithmetic**: Supports `+`, `-`, and `**` operators.
- **Parentheses**: Allows grouping of expressions using parentheses for correct order of operations.
- **Error Handling**: If the expression is malformed, a `ParseError` is thrown.
- **Recursive Descent Parsing**: Implements a recursive descent parser to handle the input expression.

## How It Works

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
   The parser recursively calls various methods to break down and evaluate the expression according to the defined grammar.

4. **Error Handling**:  
   If the expression does not follow the grammar's rules, a `ParseError` is thrown to notify the user about the malformed expression.

## Part 2 

## Overview

In this part, I implemented a **lexer** and **two parsers** for an expression-only language that supports:

- **Concatenation (`+`)** and **reverse operations** on strings.
- **Function definitions** and **calls**.
- **If-else statements** (with the restriction that every `if` must be followed by an `else`).

### Features:
- **Input Translation**: The input file is translated into an **Intermediate Representation (IR)**, which is a simplified subset of the original language. The IR excludes `=` (assignment) and suffix operations inside `if-else` blocks.
- **Two Parsers**: 
  1. **IR Parser**: Parses the simplified subset of the language (IR).
  2. **Java Parser**: Translates the IR into executable Java code.
  
- **Main Function**: Coordinates the process by calling the necessary parsers and performing the translation.

### Testing & Automation:
- **Test Cases**: A set of test cases was created to validate the lexer and parsers.
- **Shell Script**: A script was written to run the test cases automatically.
- **MAKEFILE**: A `Makefile` was included to streamline the build and execution process.

### Implementation Details

#### Lexer
I started by creating a **lexer** based on the tutorial from class. I only made one lexer because I felt a second one wasn’t necessary; the second lexer would essentially be the same as the IR lexer but without the `EQ` and `SUFFIX` operations.

#### IR Parser
The key challenge was developing the **IR parser**, which removes the `equal` and `suffix` operations while maintaining the same functionality. Here's how I approached it:

- **Equal Operation**: The `equal` operation was implemented using two `if-else` blocks. The idea behind this is that if `expr1 prefix expr2` and `expr2 prefix expr1` both evaluate to true, then the two expressions are considered equal. So, I tested this condition with two `if` statements, and if they weren't equal, the `else` part was executed.
  
- **Suffix Operation**: For the `e1 suffix e2` operation, I transformed it into `reverse e1 prefix reverse e2`. At first, this seemed straightforward, but I encountered an issue with operator precedence. Specifically, when we had an expression like `e1+e2 suffix e3` (which is valid in our language), `reverse` has higher precedence, meaning it would only apply to `e1` and not to the entire concatenation expression.
  
  To fix this, I realized that **reverse** had to have lower precedence than concatenation in this specific scenario. Since parentheses aren't used in this language to manage precedence, I implemented a function that takes an entire expression and reverses it. This way, the function applies the reverse operation to the whole expression (e.g., `e1+e2`), ensuring that the comparison works correctly after the full evaluation of the expression and the correct precedence is kept for all other instances.

### Conclusion:
This approach allowed me to remove the `equal` and `suffix` operations from the IR while still preserving the intended functionality of the language, including proper precedence handling.

#### Java Parser
The **Java parser** closely follows the same grammar as the **IR parser**, but the primary challenge here was translating the IR into valid Java code. Here's how I tackled it:

1. **Class and Function Definitions**: 
   I began by adding the `class` declaration and then converted the function definitions into their correct Java equivalents. The conversion process was relatively straightforward, as the language's structure is similar to Java in terms of function syntax.

2. **If-Else Statements**:
   In our language, **if-else statements** are considered expressions, meaning they can appear anywhere — in function calls, inside other if statements, etc. This made translating them a bit tricky.

   I observed that because every `if` must be followed by an `else` and only one expression can appear inside either the `if` or `else` block, the functionality of the `if-else` statement is essentially equivalent to the **ternary operator** in Java. Since the ternary operator is also an expression in Java and can be used anywhere, I decided to translate **if-else statements** into **ternary expressions**.

### Grammar and Precedence
- **Expression Grammar**: The parser follows a specific grammar to handle different expression types, function calls, and if-else statements. Key components include:
  - `PREFIX` and `SUFFIX` operations.
  - String concatenation (`+`).
  - Reversal operation (`reverse`).
  - Function definitions and calls with a single expression inside the function body.
  - Conditional `if-else` expressions converted into ternary expressions for easy translation into Java.
- **Operator Precedence**:
  - `REVERSE` has the highest precedence, ensuring it applies first.
  - `CONCAT` and `PREFIX` operations have left-associative precedence, ensuring the correct order of operations in expressions.

### Handling of If-Else Statements
- In the language, `if-else` statements are expressions, meaning they can appear within other expressions, including inside functions or as part of a larger expression. 
- The parser transforms `if-else` expressions into Java's ternary conditional operator (`condition ? expr1 : expr2`). This ensures that the functionality of the `if-else` structure is preserved in the Java translation.

### Special Considerations for Reverse and Concatenation
- **Reverse Precedence**: Initially, the `reverse` operation was applied only to individual expressions. However, to maintain correct precedence, `reverse` was made to apply to the entire concatenation expression. For example, `e1 + e2 reverse e3` was transformed into `reverse (e1 + e2)`, ensuring that `reverse` affects the entire expression rather than just one part of it.
- **Concatenation**: The concatenation operation (`+`) is wrapped in parentheses to ensure that the correct order of operations is maintained during evaluation.

### Error Handling
- The parser is equipped with basic error handling. Syntax errors are thrown when invalid expressions are encountered, such as unmatched parentheses or malformed `if-else` statements.
- Future improvements could include more detailed error reporting to help diagnose specific issues in the input.

### Java Code Generation
- After parsing the input and converting it into an intermediate representation, the Java parser generates the corresponding Java code. This includes:
  - Java class and method definitions.
  - Function calls are converted into Java method calls.
  - `if-else` expressions are translated into Java’s ternary operator.
  - String manipulations (concatenation and reversal) are translated into appropriate Java methods (e.g., `StringBuilder.reverse()`).
