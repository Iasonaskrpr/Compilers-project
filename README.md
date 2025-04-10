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

# Challenges

- **Equal Operation**: The `equal` operation was implemented using two `if-else` blocks. The idea behind this is that if `expr1 prefix expr2` and `expr2 prefix expr1` both evaluate to true, then the two expressions are considered equal. So, I tested this condition with two `if` statements, and if they weren't equal, the `else` part was executed.
  
- **Suffix Operation**: For the `e1 suffix e2` operation, I transformed it into `reverse e1 prefix reverse e2`. At first, this seemed straightforward, but I encountered an issue with operator precedence. Specifically, when we had an expression like `e1+e2 suffix e3` (which is valid in our language), `reverse` has higher precedence, meaning it would only apply to `e1` and not to the entire concatenation expression.
  
  To fix this, I realized that **reverse** had to have lower precedence than concatenation in this specific scenario. Since parentheses aren't used in this language to manage precedence, I implemented a function that takes an entire expression and reverses it. This way, the function applies the reverse operation to the whole expression (e.g., `e1+e2`), ensuring that the comparison works correctly after the full evaluation of the expression and the correct precedence is kept for all other instances.
 
For the rest I just ensured that no syntax errors would get accepted from the parser and left everything as is from the input language
### Conclusion:
This approach allowed me to remove the `equal` and `suffix` operations from the IR while still preserving the intended functionality of the language, including proper precedence handling.

#### Java Parser
## Java Parser Implementation

### Challenges

1. **Class and Function Definitions**:  
   The **Java parser** closely follows the same grammar as the **IR parser**, but the primary challenge here was translating the IR into valid Java code. I started by adding the `class` declaration and converting the function definitions into their correct Java equivalents. The conversion process was relatively straightforward, as the language’s structure is similar to Java in terms of function syntax.  
   The only adjustments needed were:
   - Adding the return type (`String` in our case).
   - Adding the `return` statement at the end of the function body.

2. **If-Else Statements**:  
   In our language, **if-else statements** are considered expressions, meaning they can appear anywhere — in function calls, inside other if statements, etc. This made translating them a bit tricky.  
   I observed that because every `if` must be followed by an `else` and only one expression can appear inside either the `if` or `else` block, the functionality of the `if-else` statement is essentially equivalent to the **ternary operator** in Java. Since the ternary operator is also an expression in Java and can be used anywhere, I decided to translate **if-else statements** into **ternary expressions**.

3. **Prefix Operation**:  
   In our language, **prefix** isn't a keyword and has no direct equivalent in Java. As a result, I had to translate the `prefix` operation into something Java understands.  
   I used the `startsWith()` method, which is a built-in Java function that applies directly to strings and returns a boolean. This boolean value is then used in the ternary expression to determine which part of the code should be executed, based on whether the condition evaluates to `true` or `false`.

4. **Other Operations**:  
   For the rest of the operations, I ensured the correct translation into Java. The syntax of the language was similar enough to Java that not many modifications were needed. Most changes involved adding the appropriate types in front of functions and modifying some operations to their correct Java equivalents.

### Conclusion

This process allowed me to successfully translate the language from the IR to Java, ensuring that the program could handle expressions correctly while maintaining functionality and precedence rules. The translation was straightforward for most parts due to the structural similarity between the two languages. With proper handling of edge cases like **if-else** expressions and **prefix** operations, I achieved a clean and functional Java implementation.
