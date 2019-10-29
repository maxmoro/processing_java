import java.util.Map;
class Data{
  private ArrayList<Datum> dataset ;
  private StringList  countries;
  private StringList  years;
  private StringList  jobs;
  private Table table;
  private Datum datum;
  private String filtYear, filtCountry, filtJob;
  
  public void read(){
    dataset  = new ArrayList<Datum>();
    countries = new StringList();
    jobs = new StringList();
    years = new StringList();
    
    table = loadTable("data.csv","header");
    float count = 0;
    for (TableRow trow : table.rows()) {
      datum =  new Datum();
      datum.country = trow.getString("Country");
      datum.year = trow.getString("Year");
      datum.job = trow.getString("Job");
      datum.attrition = trow.getFloat("Attrition");
      datum.col = color(trow.getInt("R"),trow.getInt("G"),trow.getInt("B"));
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
}
