
void printText(String text, float x, float y, float wt,float ht,String align){
    textSize(12);
    if(wt<0){x=x-(wt*2);wt=-wt;}
    
    if(ht<0){y=y-(ht*2);ht=-ht;}
    float ts=0;
    float tsw=wt*.95/textWidth(text)*12;
    float tsh=ht*.98/textAscent()*12;
    if(tsh>tsw) ts=tsw; else ts=tsh;
    if(ts>80) ts=80;
    textSize(ts);
    if(align=="" || align=="C") text(text,x+(wt-textWidth(text))/2,y+ht/2-textAscent()/99);
    if(align=="R") text(text,x+(wt-textWidth(text)),y+textAscent()/2);
    if(align=="L") text(text,x,y+textAscent()/2);
  }
  
  public int getListLength(StringList array){
    int num=0;
     for(String e : array){num = num+1;}
     return(num);
  }
  
  
  public StringList addElement(StringList  array, String element){
    int found=0;
    for(String e : array){
      if(e.equals(element)) found=1;
    }
    if(found==0) array.append(element);
    return(array);
  }
   
