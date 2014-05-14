// intantiate a new road network (graph) called rnet
RoadNetwork rnet = new RoadNetwork(); 
// reference the instance of cell class c
Cell c;

// start loading in geo-referenced CSV data, so set bool of loading to true
boolean loading=true; 

// set up screen
void setup() { 
  // set screen size
  size(600, 900, P3D); 
  // draw geometry with smooth edges
  smooth();  

  // load FAO / IIASA on land suitability for ag, including
  // maize + wheat suitability under current climate conditions
  m.ParseFile("DATA/maizesuitnow.txt");
  m.ReadFileW1("DATA/wheatsuitn.txt");
  // maize + wheat suitability under +2 degress C
  m.ReadFileM2("DATA/maizesuitp.txt");
  m.ReadFileW2("DATA/wheatsuitp.txt");
  // maize + wheat suitability under +3 degrees C & 10% rainfall 
  m.ReadFileM3("DATA/maizsuitp3c.txt");  
  m.ReadFileW3("DATA/whsuitp3c1.txt");
  // load FAO / IIASA / CIESIN data on land availability for development, including land not available
  // because it is currently under use as cropland (continous variable adjustable in model)
  m.ReadFile("DATA/cropland.txt");
  // or developed as urban areas (boolean variable hardcoded into model)
  m.ReadFileU("DATA/urbanareas.txt");
  // or dense forest that we don't want to cut down (continous variable adjustable in model)
  m.ReadFileF("DATA/forest.txt");
  // or inland water bodies that we either can't (or don't want to drain) to develop (boolean variable hardcoded into model)
  m.ReadFileW("DATA/inlandwater.txt");
  // or irrigated land currently under use, potentially for ag (continous variable adjustable in model)
  m.ReadFileI("DATA/irrigate.txt");
  // or UNESCO protected biosphere where agriculture is not allowed (boolean variable hardcoded into model)
  m.ReadFileP("DATA/protected.txt");
  // load in Ramankutty, et. al. potential ag production data for each gridcell of land
  // for maize
  m.ReadFilePM("DATA/maizepotyiel.txt");
  // and for wheat
  m.ReadFilePW("DATA/wheatpotyield.txt");
  // load road construction cost data
  // including UN FAO soil type 
  m.ReadFileST("DATA/finallysoils.txt");
  // population data to determine "cities" where population > 100K
  m.ReadFilePop("DATA/afpop.txt");
  // ACLED conflict data
  m.ReadFileC("DATA/acledconf.txt");
  // slope generated from a 500 km global DEM 
  m.ReadFileS("DATA/sloperightz.txt");
  // soil bulk density data, from the world harmonized soil database
  m.ReadFileSBD("DATA/soilbulkdensity1215.txt");  
  // and political provinces data, from the UN
  m.ReadFileProv("DATA/provinces.txt");
  // import road network graph as csv  
  rnet.ReadRoadFile(m, "DATA/roads.csv");  

// stop loading, change boolean condition
  loading=false;

}

// draw new map called m
Map m=new Map(); 

// start drawing
void draw() { 

  // if still loading, go back to setup
  if (loading) return;  

  // set background to white
  background(255, 255, 255); 
  // set stroke weight
  strokeWeight(10); 
  // initialize strokes 
  stroke(0, 0, 0);
  // set lat + long to Madagascar's approxiamate location
  float mlat=20.0;
  float mlong=40.0;//47.0;

  // set camera so you can see whole screen
  camera(mlong, -mlat, -14.0, mlong, -mlat, 0.0, 0.0, -1.0, 0.0);
  // center camera perspective 
  perspective(PI/3.0, width/(float)height, 0.1, 1000.0);
  // draw the road network
  rnet.draw();  

  // start drawing the land grid cells as points
  beginShape(POINTS);
  // using given stroke characteristics
  stroke(255, 0, 0); 
  strokeWeight(3);    
  vertex(30.0, 16.0, 0.0);

  // draw only every 5th gridcell to save computing power
  for (int j=0; j<m.nrow; j+=5) {
    for (int i=0; i<m.ncol; i+=5) {
      // set the incidence of c to the two dimensional data array loaded in cells
      c=m.cells[j][i];

 // color the points according to resilience
 float index1 = (c.ResilienceW() + c.ResilienceM())/2;
      if (index1 < 0) index1 = 0.0;   
      if (index1 <= 8.0) stroke(255,255,255);
      if (index1 > 8.0) stroke(158,188,218);
      if (index1 > 8.5) stroke(140,150,198);
      if (index1 > 9.0) stroke(255,255,255);
      if (index1 > 9.5) stroke(136,65,157);
      if (index1 > 10.0) stroke(110,1,107);
      vertex(c.g.x, c.g.y, 0.0);
    }
  }
  // stop drawing
  endShape();
}


// save a frame if s is pressed (for animation purposes)
void keyPressed()
{
  if (key == 's' )
  {
    saveFrame();
    println("saved a frame");
  }
}

