import pathfinder.*;
import java.util.LinkedList;

class RoadNetwork {

  Graph g = new Graph();
  Map map;
  
public RoadNode AddNode(float _x, float _y) {
    int id=nodes.size();
    RoadNode rn=new RoadNode(_x, _y, id);
    nodes.add(rn);
    GraphNode aNode= new GraphNode(id, _x, _y);
    g.addNode(aNode);
    return rn;
  }
  
 public Road AddRoad(RoadNode n0, RoadNode n1) {
    int id=roads.size();
    float cost=totalRoadCost(n0, n1);
    
    //float cost=1.0;
    Road r=new Road(n0, n1, id);
    roads.add(r);
    g.addEdge(n0.ID, n1.ID, cost);
    g.addEdge(n1.ID, n0.ID, cost);
    return r;
  }
  
public ArrayList RoadtoPoints(RoadNode n0, RoadNode n1) {
  float x1=n0.p.x;
  float y1=n0.p.y;
  
  float x2=n1.p.x;
  float y2=n1.p.y;
  
  //println("" + x1 + " " + y1 + " " + x2 + " " + y2);
  
  float dx=Math.abs(x2-x1);
  float dy=Math.abs(y2-y1);
  
  float err = dx-dy;
  float sx = 0;
  float sy = 0;
  
  if (x1<x2) {
    sx = .01;
  }
  else {
    sx = -.01;
  }
  if (y1<y2) {
    sy = .01;
  }
  else {
    sy = -.01;
  }
  ArrayList<PVector> roadpoints = new ArrayList<PVector>(); 
  
  while (true) {
    PVector point = new PVector(x1, y1);
    roadpoints.add(point);
    
    if (Math.abs(x1-x2) < .04 && Math.abs(y1-y2) < .02) break;
    //if (x1 == x2 && y1 == y2) break;
    
    float e2 = 2*err;
    if (e2 > -dy) {
      err -= dy;
      x1 +=sx;
    }
    
    //if (x1 == x2 && y1 == y2) {
    if (Math.abs(x1-x2) < .04 && Math.abs(y1-y2) < .02) {
      point = new PVector(x1, y1);
      roadpoints.add(point);
      break;
    }
    
    if (e2 <dx) {
      err += dx;
      y1 += sy;
    }
  }
  return roadpoints;  
}

  public Cell RptToCells(PVector RP) {
    float shortestDist = Integer.MAX_VALUE;
    Cell minCell=null;
    
    for (int i=0; i<this.map.numCellRows;i++) {
      for (int j = 0; j < this.map.numCellCols; j++) {
        Cell cell = this.map.cells[i][j];    
        float dx2 = (RP.x - cell.g.x)*(RP.x - cell.g.x);
        float dy2 = (RP.y - cell.g.y)*(RP.y - cell.g.y);   
        float d2 = dx2+dy2;
        
        if (d2<shortestDist) {
          shortestDist=d2;
          minCell = cell;
        }
      }
    }
    return minCell;
  }
  
  public float getRoadCost(ArrayList<Cell> RoadCells) {
    float cost = 0.0;
    for (int a=0; a<RoadCells.size();a++) {
      Cell RCell=RoadCells.get(a);
      if (RCell != null)
        cost += RCell.cost;
    }
    return cost;
  }
  
  public float totalRoadCost(RoadNode n0, RoadNode n1) {
    ArrayList<PVector> roadpoints = RoadtoPoints(n0,n1);
    //println("roadpoints.size = " + roadpoints.size());
    float rcost = 0.0;
    ArrayList<Cell> RoadCells = new ArrayList<Cell>();
    
    for (int c=0; c<roadpoints.size(); c++) {
      PVector RPT = roadpoints.get(c);
      RoadCells.add(RptToCells(RPT));
    }
    
  rcost = getRoadCost(RoadCells);
    
  return rcost;  
  }  
  
public void ClosestNode(Cell _cell) {
   cell = _cell;
   for (int i=0; i<nodes.size();i++) {
      RoadNode RN = nodes.get(i);        
      float dx2 = (RN.p.x - cell.g.x)*(RN.p.x - cell.g.x);
      float dy2 = (RN.p.y - cell.g.y)*(RN.p.y - cell.g.y);
      float d2 = dx2+dy2;
    if (d2<MAXDIST) {
      NearRN.add(nodes.get(i));
    }
    else {
      return;
    }
   }
  }

  public Cell cell;
  public float MAXDIST=50.0;
  public ArrayList<RoadNode> NearRN =new ArrayList<RoadNode>();  
  
  LinkedList<GraphNode> path;
  IGraphSearch pathFinder;
  public void BuildGraph() {
    g.compact();
    pathFinder=new GraphSearch_Dijkstra(g);
    
    path=pathFinder.search(0, 10, false);
    print(path);
 // path = pf.getRoute();
  }
  
   void ReadRoadFile(Map m, String fname) 
  {
     this.map = m;
      BufferedReader reader=createReader(fname);  
      
      try 
      {
        
        String line;
        String [] tokens;
        
        line=reader.readLine();
        tokens=line.split(",");
        int nodecount=Integer.parseInt(tokens[0]);
        int edgecount=Integer.parseInt(tokens[1]);
        
        print(nodecount);
        
        float x=0.0;
        float y=0.0;
        
        int n0=0;
        int n1=0;
        
        
        for(int i=0; i<nodecount; ++i) {
          line=reader.readLine();
          tokens=line.split(",");
          x=Float.parseFloat(tokens[0]);
          y=Float.parseFloat(tokens[1]);
          AddNode(x,y);
        }
        
        for(int i=0; i<edgecount; ++i) {
          line=reader.readLine();
          tokens=line.split(",");
          n0=Integer.parseInt(tokens[0]);
          n1=Integer.parseInt(tokens[1]);
          println("road " + i);
          AddRoad(nodes.get(n0), nodes.get(n1));
        }
      reader.close();
      
      BuildGraph();
      } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }
  
  public void draw() {
    noFill();
    strokeWeight(1);
    beginShape(LINES);
    Road r;
    stroke(0, 0, 255);       
    for(int j=0; j<roads.size(); j++) {
       r=roads.get(j);
        vertex(r.n0.p.x, r.n0.p.y, r.n0.p.z);
        vertex(r.n1.p.x, r.n1.p.y, r.n1.p.z);
    }
    
    
    endShape();
    
    
    if (path!=null) {
       strokeWeight(1);
       stroke(255, 0, 0);  
    beginShape(LINES);
    
    for (GraphNode g : path) {
      int id=g.id();
      RoadNode rn=nodes.get(id);
      vertex(rn.p.x, rn.p.y, rn.p.z);
    }
    endShape(CLOSE);
    }
    
  }
  
  public ArrayList<RoadNode> nodes=new ArrayList<RoadNode>();
  public ArrayList<Road> roads=new ArrayList<Road>();
}

class RoadNode {
  public RoadNode(float x, float y, int _ID) {
    p=new PVector(x, y, 0.0);
    ID=_ID;
  }
  
  public PVector p;
  public int ID;
  public RoadNode RN;

}

class Road {
  public Road(RoadNode _r0, RoadNode _r1, int _ID) {
    n0=_r0;
    n1=_r1;
    ID=_ID;
  }
  
  public int ID=0;
  public RoadNode n0;
  public RoadNode n1;
}


