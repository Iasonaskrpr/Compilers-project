# Compilers Project

## Project 2 
## Overview
I was tasked with creating a parser that performs semantic analysis for MiniJava. For this I made two visitors, one which creates the symbol table and one which performs type checking.

## Implementation

# Symbol Table
I seperated the symbol table implementation in three files, Scopes which has a map with all symbol tables linked with the function name or class name, ST which implements the symbol table with a map that connects variable and method names with information about itself and Info which has all the information used to perform type checking.

# Scopes
Manages scoped symbol tables for a MiniJava-like compiler. Tracks class-level scopes, handles variable/method declarations, and supports inheritance-aware type and method checks.

## Features
- Create/switch scopes (`enter`, `exit`, `enterScopeByName`)
- Insert variables and methods (`insert`)
- Lookup symbols (`lookup`, `getDeclaredType`)
- Type checks (`isInt`, `isBool`, etc.)
- Method validation (`methodExists`, `isValidOverride`)
- Inheritance support (`isSubtype`)
- Offset tracking for code generation (`PrintOffset`)

# Info

Stores metadata for symbols (variables or methods) within a scope.

## Features
- Differentiates methods from variables
- Holds:
  - `type`: data type or "method"
  - `retType`: method return type
  - `paramTypes`: list of parameter types for methods
  - `offset`: memory layout offset

# ST

Represents a symbol table (`ST`) for a class or method in MiniJava, storing variable and method declarations with type and offset info.

## Features
- Stores:
  - Variables with type and offset
  - Methods with return type, parameter types, and offset
- Supports hierarchical scopes via parent linkage
- Tracks offsets separately for variables and methods
- Can print memory layout (offsets) per class

## Key Methods
- `insert(name, type)` – Add a variable
- `insertMethod(name, retType, paramTypes)` – Add a method
- `lookup(name)` – Recursive symbol lookup
- `PrintOffsets(className)` – Displays memory layout for variables/methods
- `addPointer()`, `addBool()`, `addInt()`, `addMethod()` – Offset updates by type

## Usage
Used in semantic analysis to:
- Track variable/method declarations
- Resolve names
- Manage class/method inheritance and offsets

## Visitors

# SymbolTableVisitor

Builds the symbol table and performs some semantic checks.

## ✅ Features
- Handles `MainClass`, `ClassDeclaration`, and `ClassExtendsDeclaration`
- Supports method declarations, parameters, local variables
- Adds `this` in class/method scopes
- Validates method overrides
- Prevents duplicate declarations in scope

## 🔄 Key Behaviors
- Uses `Scopes` to manage scope stack
- Method entries stored as `Class_Function_Name`
- Parameters parsed into type lists for comparison
- Method override rules: same name, return type, and parameter types

## 🔧 Dependencies
- `Scopes`, `ST`, `Info`: symbol table structure
- `syntaxtree.*`: JTB-generated AST classes

## 📌 Notes
- This visitor is mainly used to populate the symbol table. It only checks for duplicate declarations and ensures that method overrides are valid.

# TypeCheckingVisitor

Performs type checking using the Symbol table provided by the last visitor.

## ✅ Features
- Verifies return types in methods
- Checks boolean conditions in `if`/`while`
- Validates types in:
  - Print statements (`int`)
  - Assignments (including subtyping)
  - Array operations (indexing, allocation, lookup, length)
  - Arithmetic (`+`, `-`, `*` → `int`)
  - Comparisons (`<` → `boolean`)
  - Logical AND (`&&` → `boolean`)
  - `!` (logical NOT → `boolean`)
  - Method calls (existence, parameter types, return type)
- Ensures class allocation targets valid classes

## 🔄 How It Works
- Uses `Scopes` to enter existing scopes (`enterScopeByName`)
- Resolves identifiers via `Table.lookup(...)`
- Replaces variable names with their declared types before comparisons
- Throws exceptions on mismatches

# Main

# Run semantic analysis on one or more MiniJava source files:
java SemanticAnalyzer <MiniJavaSourceFile1> <MiniJavaSourceFile2> ...

# Output:
- Success or failure per file
- Prints semantic errors if any
- Prints offset info
# Usage

```bash```
  java SemanticAnalyzer <MiniJavaSourceFile1> <MiniJavaSourceFile2> ...

# Test Script Usage

I have included bass script which runs all tests provided and returns if it succeded or failed the test.

- **Purpose:** Runs `SemanticAnalyzer` on `.java` files in `TestFiles`  
- **Checks:**  
  - If matching `.txt` file exists in `TestFiles/offset-examples`, expects success (exit code 0)  
  - Otherwise, expects failure (non-zero exit)  
- **Output:** Shows pass/fail per test and summary count  

---

**Run:**  
```bash```
./test_script.sh

# Usage

- **Compile:**  
  `make` or `make compile`  
  Runs JTB, JavaCC, and compiles Java files.

- **Clean:**  
  `make clean`  
  Removes generated files and `.class` files.

---


## Project 1
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
