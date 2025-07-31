package IRGeneration;
public class IRData{
    private final String data; //Data passed through visitors
    private final String type; //Repressents type of data, id or num or bool
    //WILL ADD ANYTHING ELSE I MIGHT NEED HERE
    public IRData(String data,String type){
        this.data = data;
        this.type = type;
    }
    public String getData(){
        return this.data;
    }
    public String getType(){
        return this.type;
    }
    public boolean isId(){
        return this.data.equals("id");
    }
    public boolean isNum(){
        return this.data.equals("num");
    }
}