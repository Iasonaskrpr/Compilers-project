// File: ErrorTest.java

class Main {
    public static void main(String[] args) {
        // double declaration in local scope
        int a;
        boolean b;
        b = true;
        System.out.println(b);
    }
}

class Base {
    int x;

    public int foo(int n) {
        return n + 1;
    }

    public boolean bar() {
        return true;
    }
}

class Derived extends Base {
    int y;
    
    // invalid override: wrong return type
    public int foo(int n) {  // ✗ foo(int) already returns int
        return 0;
    }

    // invalid override: wrong parameter list
    public boolean bar(int n) {  // ✗ bar() in Base takes no args
        return n < 0;
    }

    // double declaration of method in same class
    public int baz() {
        return 42;
    }
}
