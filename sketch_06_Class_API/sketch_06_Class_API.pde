String site="https://dog.ceo/api/breeds/image/random";
PImage myImage;
JSONObject myObject;

void settings(){
 myObject = loadJSONObject(site);
 String imageURL=myObject.getString("message");
 myImage = loadImage(imageURL);
 size(myImage.width, myImage.height);
}

void draw(){
  image(myImage,0,0);
}
