PImage transform(PImage img ,int filter[][],float mult){
  PImage img2;
  img2=img.copy();
  img2.loadPixels(); 
  color p; 
  int pg; 
  int pr; 
  int pb; 
  int px;
  for(int i=1;i<(img2.width-1);i++){ 
    for(int j=1;j<(img2.height-1);j++){ 
      pr=0;pg=0;pb=0; 
      for(int fi=0;fi<(filter.length);fi++){ 
        for(int fj=0;fj<(filter[0].length);fj++){
          px=(i-1+fi)*img2.height+(j-1+fj);
          p = img2.pixels[px]; 
          pr = pr + int(red(p)*filter[fi][fj] ); 
          pg = pg + int(green(p)*filter[fi][fj] ); 
          pb = pb + int(blue(p)*filter[fi][fj] ); 
        } 
      } 
      pr=int(pr*mult);
      pg=int(pg*mult);
      pb=int(pb*mult);
      img2.pixels[i*img2.height+j]=color(pr,pg,pb); 
    } 
  }
  img2.updatePixels();
  return(img2);
}
