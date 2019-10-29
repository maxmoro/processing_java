float x;
// array structure are immutable
float[] vals;
vals = new float[1000];
vals[0] = 34.567;
vals[vals.length-1] = 100.0;
// illegal
vals[vals.length] = 79.0;

// ArrayList<float>

for(int i=0; i<vals.length; i++){
  vals[i] = random(10.0);
}

