
class test {
	public static void main(String[] a){
		broaderGreeter b;
		int y;
		b = new broaderGreeter();
		y=3;
		System.out.println(y);
		b.dontsayHello(y);
		System.out.println(y);
	}	
}
class Greeter {
    int[] x;
	int y;
	Greeter m;
	int z;
    public int sayHello(Greeter h) {
		y = 8;
        System.out.println(y);
		return 0;
    }
}
class broaderGreeter{
	int k;
	public boolean dontsayHello(int j) {
		j=5;
		return false;
    }
}

