import pathfinder.*;
import java.util.LinkedList;

class RoadNetwork {

  Graph g = new Graph();
  //Graph h = new Graph();
  Map map;
  Cell c;

  public RoadNode AddNode(float _x, float _y) {
    int id=nodes.size();
    RoadNode rn=new RoadNode(_x, _y, id);
    nodes.add(rn);
    GraphNode aNode= new GraphNode(id, _x, _y);
    g.addNode(aNode);
    return rn;
  }

  public ArrayList<Road> newroads = new ArrayList<Road>();
  public ArrayList<RoadNode> ResCellRN = new ArrayList<RoadNode>();
  public ArrayList<RoadNode> nodes = new ArrayList<RoadNode>();
  public ArrayList<Road> roads = new ArrayList<Road>();
  public ArrayList<ArrayList<RoadNode>> AllNNRC = new ArrayList<ArrayList<RoadNode>>();

  /*
 public Road BuildRoad(RoadNode n0, RoadNode n1) {
   int id=newroads.size();
   float cost = totalRoadCost(n0, n1);
   Road r=new Road(n0, n1, id);
   newroads.add(r);
   h.addEdge(n0.ID, n1.ID, cost);
   h.addEdge(n1.ID, n0.ID, cost);
   return r;
   }
   
   public RoadNode CelltoNode(Cell rc) {
   int id = ResCellRN.size(); 
   RoadNode nrn = new RoadNode (rc.g.x, rc.g.y, id);
   ResCellRN.add(nrn);
   GraphNode aNode = new GraphNode(id, rc.g.x, rc.g.y);
   h.addNode(aNode);
   return nrn;
   }  
   */

  public Road AddRoad(RoadNode n0, RoadNode n1) {
    int id=roads.size();
    float cost=totalRoadCost(n0, n1);
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
    ArrayList<PVector> roadpoints = RoadtoPoints(n0, n1);
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

  /*
  public RoadNode getClosestCity(RoadNode RN) {
   float shortestDist = Integer.MAX_VALUE;
   Cell closestCity = null;
   RoadNode minNode = null;
   
   for (int i=0; i<Cell.cities.size();i++) {
   Cell city = Cell.cities.get(i);   
   float dx2 = (RN._x - city.g.x)*(RN._x - city.g.x);
   float dy2 = (RN._y - city.g.y)*(RN._y - city.g.y);   
   float d2 = dx2+dy2;
   
   if (d2<shortestDist) {
   shortestDist=d2;
   closestCity = city;
   }
   }
   
   minNode = ClosestNode(closestCity);
   return minNode;
   }
   
   public RoadNode ClosestNode(Cell cell) {
   for (int i=0; i<nodes.size();i++) {
   RoadNode RN = nodes.get(i);         
   float dx2 = (RN.x - cell.g.x)*(RN.x - cell.g.x);
   float dy2 = (RN.y - cell.g.y)*(RN.y - cell.g.y);   
   float d2 = dx2+dy2;
   float d2 = dx2+dy2;
   if (d2<MAXDIST) {
   NearRN.add(nodes.get(i));
   }
   else {
   return;
   }
   }
   }
   
   
   public ArrayList ClosestNodes(RoadNode NRN) {
   float MAXDIST = 50.0;
   ArrayList<RoadNode> NearRN = new ArrayList<RoadNode>();
   NearRN.add(NRN);
   for (int i=0; i<nodes.size(); i++) {
   RoadNode RN = nodes.get(i);
   float dx2 = (RN.p.x - NRN.p.x)*(RN.p.x - NRN.p.x);
   float dy2 = (RN.p.y - NRN.p.y)*(RN.p.y - NRN.p.y);
   float d2 = dx2+dy2;
   if (d2<MAXDIST) {
   NearRN.add(RN);
   }
   }
   return NearRN;
   }
   
   public ArrayList NodesNearResCells(ArrayList<RoadNode> rc) {
   ArrayList<RoadNode> NNRC = new ArrayList<RoadNode>();
   ArrayList<ArrayList<RoadNode>> AllNNRC = new ArrayList<ArrayList<RoadNode>>();
   for (int j = 0; j < rc.size(); j++) {
   RoadNode RN = rc.get(j);
   NNRC = ClosestNodes(RN);
   }
   AllNNRC.add(NNRC);
   return AllNNRC;
   }
   */
   
  LinkedList<GraphNode> path;
  IGraphSearch pathFinder;
  public void BuildGraph() {
    g.compact();
    pathFinder=new GraphSearch_Dijkstra(g);

    path=pathFinder.search(23, 78, true);
    print(path);

    /*
  public void Search() {
     for (int i = 0; i< Cell.Allresilientcells.size(); i++) {
     Cell cell = Cell.Allresilientcells.get(i);
     ArrayList<RoadNode> startrns = ClosestNodes(cell);
     for (int j=0; j<startrns.size(); j++) {
     RoadNode start = startrns.get(j);
     RoadNode end = getClosestCity(start);
     LinkedList<GraphNode> path;
     IGraphSearch pathFinder;
     BuildGraph();
     }
     }
     }
     public void BuildGraph(RoadNode start, RoadNode end) {
     g.compact();
     pathFinder=new GraphSearch_Dijkstra(g);
     
     path=pathFinder.search(start.id, end.id, false);*/
    //print(path);
    // path = pf.getRoute();
  }

  /* 
   
   while (c.caloriedeficit > 0.0) {
   LinkedList<LinkedList<GraphNode>> allnewpaths = new LinkedList<LinkedList<GraphNode>>();
   for(int i = 0; i< c.Activatednodes.size(); i++) {
   RoadNode start = c.Activatednodes.get(i);
   RoadNode end = getClosestCity(start);
   LinkedList<GraphNode> path;
   public void BuildGraph2() {
   h.compact;
   path = pathFinder.search(start, end, false;
   print(path);
   
   }
   LinkedList<GraphNode> path2;
   public void BuildGraph2() {
   h.compact(); 
   path2=pathFinder.search(0, 10, false);
   print(path2);
   // path = pf.getRoute();
   }
   */
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

      for (int i=0; i<nodecount; ++i) {
        line=reader.readLine();
        tokens=line.split(",");
        x=Float.parseFloat(tokens[0]);
        y=Float.parseFloat(tokens[1]);
        AddNode(x, y);
      }

      for (int i=0; i<edgecount; ++i) {
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
  /*
 public void BuildNewRoads(Map m, Cell c, ArrayList<Cell> rcells) {
   
   this.map = m;
   this.cell = c;
   
   for (int j = 0; j < rcells.size(); j++) {
   Cell cell=rcells.get(j); 
   RoadNode RCRN = CelltoNode(cell);
   }
   
   ArrayList<ArrayList<RoadNode>> AllNNRC = NodesNearResCells(ResCellRN);
   for (int i=0; i<AllNNRC.size(); i++) {
   ArrayList<RoadNode> ResCells = new ArrayList<RoadNode>();
   ResCells = AllNNRC.get(i);
   RoadNode start = ResCells.get(0);   
   for (int j=1; j<ResCells.size(); j++) {
   RoadNode end = ResCells.get(j);
   Road road = BuildRoad(start, end);
   }
   }   
   
   BuildGraph2();
   }
   */

  public void draw() {
    noFill();
    strokeWeight(1);
    beginShape(LINES);
    Road r;
    Road nr;
    stroke(189, 189, 189);       
    for (int j=0; j<roads.size(); j++) {
      r=roads.get(j);
      vertex(r.n0.p.x, r.n0.p.y, r.n0.p.z);
      vertex(r.n1.p.x, r.n1.p.y, r.n1.p.z);
    }
    /*
    stroke(0, 255, 0);       
     for (int i=0; i<newroads.size(); i++) {
     nr=newroads.get(i);
     vertex(nr.n0.p.x, nr.n0.p.y, nr.n0.p.z);
     vertex(nr.n1.p.x, nr.n1.p.y, nr.n1.p.z);
     }
     */
    endShape();

    if (path!=null) {
      strokeWeight(1);
      stroke(177, 0, 38);  
      beginShape(LINES);

      for (GraphNode g : path) {
        int id=g.id();
        RoadNode rn=nodes.get(id);
        vertex(rn.p.x, rn.p.y, rn.p.z);
      }
      /*
    for (GraphNode h : path2) {
       int id=h.id();
       RoadNode nrn=ResCellRN.get(id);
       vertex(nrn.p.x, nrn.p.y, nrn.p.z);
       }*/
      endShape(CLOSE);
    }
  }
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

