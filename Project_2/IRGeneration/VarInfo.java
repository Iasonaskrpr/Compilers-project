package IRGeneration;
public class VarInfo{
    private final int offset;
    private final String type;
    private final String parent;
    public VarInfo(int offset,String type,String parent){
        this.offset = offset;
        this.type = type;
        this.parent = parent;
    }
    public int getOffset(){
        return this.offset;
    }
    public String getType(){
        return this.type;
    }
    public String getParent(){
        return this.parent;
    }
}