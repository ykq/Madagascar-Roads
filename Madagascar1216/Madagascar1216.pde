RoadNetwork rnet=new RoadNetwork(); // draw new road network (graph) called rnet

boolean loading=true; // start loading data
void setup() { // setup screen
 size(600, 900, P3D); // set size of the screen
 translate(800, 500); // move screen to center the map 
 smooth(); // draw geometry with smooth edges 


// load suitability data 
  m.ParseFile("DATA/maizesuitnow.txt");
  m.ReadFileM2("DATA/maizesuitp.txt");
  m.ReadFileM3("DATA/maizsuitp3c.txt");  
  m.ReadFileW1("DATA/wheatsuitn.txt");
  m.ReadFileW2("DATA/wheatsuitp.txt");
  m.ReadFileW3("DATA/whsuitp3c1.txt");
// load availability data  
  m.ReadFile("DATA/cropland.txt");
  m.ReadFileU("DATA/urbanareas.txt");
  m.ReadFileF("DATA/forest.txt");
  m.ReadFileW("DATA/inlandwater.txt");
  m.ReadFileI("DATA/irrigate.txt");
  m.ReadFileP("DATA/protected.txt");
  m.ReadFilePop("DATA/afpop.txt");
// load production data
  m.ReadFilePM("DATA/maizepotyiel.txt");
  m.ReadFilePW("DATA/wheatpotyield.txt");
// load road construction cost data
  m.ReadFileST("DATA/finallysoils.txt");
  m.ReadFileC("DATA/acledconf.txt");
  m.ReadFileS("DATA/sloperightz.txt");
  m.ReadFileSBD("DATA/soilbulkdensity1215.txt");  
  m.ReadFileProv("DATA/provinces.txt");
  
// import road network as csv  
  rnet.ReadRoadFile(m, "DATA/roads.csv");
  
 loading=false; // stop loading 
}

Map m=new Map(); // draw new map called m

void draw() { // start drawing

  if (loading) return;  // if still loading, go back to setup
 
  background(255,255,255); // set background to white
  strokeWeight(10); // set stroke weight
  stroke(0, 0, 0);
  float mlat=20.0;
  float mlong=47.0;

  camera(mlong, -mlat, -14.0, mlong, -mlat, 0.0, 0.0, -1.0, 0.0); // set camera so you can see whole screen
  perspective(PI/3.0, width/(float)height, 0.1, 1000.0); // center camera perspective
  rnet.draw(); // draw the road network
  Cell c; // initialize cells
  float cs;
  float ys;
    
  beginShape(POINTS);
  stroke(255, 0, 0); 
  strokeWeight(3);    
    vertex(30.0, 16.0, 0.0);
      
  for(int j=0; j<m.nrow; j+=5) {
    for(int i=0; i<m.ncol; i+=5) {
      c=m.cells[j][i];
        if (c.ResilienceM()<=0 || c.ResilienceW()<=0) continue;
        cs=255.0*(c.ResilienceM()*0.5);
        ys=255.0*(c.ResilienceW()*0.5);
        stroke(cs*0.5, (cs*ys)*0.75, ys*0.5);       
      vertex(c.g.x, c.g.y, 0.0);
    }
  }
  endShape();
}
