
class test {
	public static void main(String[] a){
		int x;
		int y;
		int[] i;
		boolean z;
		boolean t;
		Greeter u;
		i = new int[15];
		y=3;
		x= y+3;
		t = x<10;
		z = y<4;
		i[4] = 25;
		i[3] = x;
		if((t && z))
			System.out.println(i[8]);
		else
			System.out.println(19);
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
class broaderGreeter extends Greeter{
	int k;
	public boolean dontsayHello() {
		boolean t;
		boolean y;
		broaderGreeter l;
		x[5] = 8;
        System.out.println(m.sayHello(m));
		return t&&y;
    }
}

