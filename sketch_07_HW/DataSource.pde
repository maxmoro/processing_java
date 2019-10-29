import java.util.Map;
class DataSource { 
  private HashMap<String, OrgData> myData;
  private static final String DATA_URL = "https://raw.githubusercontent.com/maxmoro/processing/master/org.csv";
  private static final String DATA_LOCAL = "org.csv";
  private String DataLink;
  private Table table;
  private String updateDate;
  private float maxValue;
  private String head;
  private OrgData data;
  private int totLayers;
  
  public DataSource(int useInternet){
    if(useInternet==1) DataLink=DATA_URL; else DataLink=DATA_LOCAL;
    table = loadTable(DataLink,"header");
    int rows=0;
    
    myData = new HashMap<String, OrgData>();
    for (TableRow trow : table.rows()) {
      data = new OrgData();
      data.id =trow.getString("id");
      data.name=trow.getString("name") ;
      data.parentId = trow.getString("parent_id");
      data.value = trow.getFloat("value");
      myData.put(data.id,data);
      if(rows==0) {
          updateDate = trow.getString("update");
          head = data.id;
      }
      if(data.value > maxValue) maxValue = data.value;
      rows++;
    }
    
    totLayers = getNumLayers(head);
  }
  
 public HashMap<String, OrgData> getData(){return myData;}
  
 public String getUpdateDate(){return updateDate;}  
 
 public String getHead(){return head;}
 
 public int getTotLayers(){return totLayers;}
  
 public float getMaxValue(){return maxValue;}
  
 public int getNumChilds(String parentId){
    int num_childs=0;
    String t="";
    for(Map.Entry me : myData.entrySet()){
      data=(OrgData)me.getValue();
      if(int(data.parentId) ==  int(parentId)) {
       num_childs++;
      }
    }
    return num_childs;
  }
  
   public int getNumLayers(String parentId){
    int childs = getNumChilds(parentId);
    int layer=0;
    int childsMax=0;
    int childsCount=0;
    if(childs!=0){
      layer=1;
      for(Map.Entry me : myData.entrySet()){
        data=(OrgData)me.getValue();
        if(int(data.parentId)==int(parentId)){
          childsCount=getNumLayers(data.id);
          if(childsCount>childsMax) childsMax= childsCount;
        }
      }
      layer = layer +childsMax;
    }
    return(layer);
  }
  
}
  
