
class test {
	public static void main(String[] a){
		Greeter b;
		Greeter y;
		int x;
		b = new Greeter();
		if(true){
			x = b.sayHello(y);
		}
		else{
			x= 4;
		}
	}	
}
class Greeter {
    int x;
	int y;
	Greeter m;
	int z;
    public int sayHello(Greeter h) {
		y = 8;
		h = new Greeter();
		if(true){
			x = h.update(y);
		}
		else{
			y = 4;
		}
        System.out.println(y);
		return 0;
    }
	public int update(int j){
		y = 3;
		return y;
	}
}

