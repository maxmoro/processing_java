import processing.core.*;
import java.util.ArrayList;
import processing.data.*;


import java.util.Map;
class Data{
  protected PApplet p;
  private ArrayList<Datum> dataset ;
  private StringList  countries;
  private StringList  years;
  private StringList  jobs;
  private Table table;
  private Datum datum;
  private String filtYear, filtCountry, filtJob;
  
  public Data(PApplet _p){
    p=_p;
  }
  
  public void read(){
    dataset  = new ArrayList<Datum>();
    countries = new StringList();
    jobs = new StringList();
    years = new StringList();
    
    table = p.loadTable("data.csv","header");
    float count = 0;
    for (TableRow trow : table.rows()) {
      datum =  new Datum();
      datum.country = trow.getString("Country");
      datum.year = trow.getString("Year");
      datum.job = trow.getString("Job");
      datum.attrition = trow.getFloat("Attrition");
      datum.col = p.color(trow.getInt("R"),trow.getInt("G"),trow.getInt("B"));
      dataset.add(datum);
      
      countries = addElement(countries,datum.country);
      years = addElement(years,datum.year);
      jobs = addElement(jobs,datum.job);
    }
  }
  
    
    
  public StringList  getCountries(){return(countries);}
  public StringList  getYears(){return(years);}
  public StringList  getJobs(){return(jobs);}
  
  public int getCountriesNum(){return(getListLength(countries));}
  public int getYearssNum(){return(getListLength(years));}
  public int getJobsNum(){return(getListLength(jobs));}

  
  public void setFilters(String year,String country,String job){
    this.filtYear= year;
    this.filtCountry= country;
    this.filtJob= job;
  }
  
  public ArrayList getFilt(){
   ArrayList<Datum> filtDS;
   filtDS = new ArrayList<Datum>();
   for(Datum d : dataset){  
     if((filtYear != "" && filtYear.equals(d.year)) &&
       (filtCountry != "" && filtCountry.equals(d.country)) &&
       (filtJob != "" && filtJob.equals(d.job))
       ) filtDS.add(d);
   }
   return(filtDS);
  }
  
  public Datum filt(String year,String country,String job){
   for(Datum d : dataset){  
     if((year != "" && year.equals(d.year)) &&
       (country != "" && country.equals(d.country)) &&
       (job != "" && job.equals(d.job))
       ) return(d);
   }
   return(null);
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
}
