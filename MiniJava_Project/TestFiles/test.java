class test {
	public static void main(String[] a){
		int x;
		int y;
		int[] i;
		boolean z;
		boolean t;
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
			System.out.println(i[3]);
	}	
}
class Greeter {
    int[] x;
	int y;
	int z;
    public int sayHello() {
		y = 8;
        System.out.println(y);
		return 0;
    }
}
class broaderGreeter extends Greeter{
	int k;
	public int dontsayHello() {
		x = new int[15];
		x[5] = 8;
        System.out.println(x[5]);
		return 0;
    }
}

