import java.util.ArrayList; // import different types of data storage structures

public class Cell {
  
public ArrayList<Cell> cells =new ArrayList<Cell>(); // store all cells (~120K!)
public ArrayList<Cell> Wresilientcells=new ArrayList<Cell>(); // create shorter list of resilient cells 
public ArrayList<Cell> Mresilientcells=new ArrayList<Cell>(); // create shorter list of resilient cells 
public ArrayList<Cell> cities=new ArrayList<Cell>(); // create shorter list of cities (cells w/ pop>100K) 
  
public Cell(PVector location) // declare basic cell prototype
  {
    g = location;
  }
  
  /*
 public float ResilienceM() { // calculate resilience index for growing maize
   float resindexM=0.0;
   maxresindexM=0.0;
   if(FavorabilityM(0) > 0.0) { // if cell is favorable for growing maize in current time period
     if(FavorabilityM(1)<=0.0) { // but not in the next climate change period (+ 2C)
       if (FavorabilityM(2) <=0.0) { // or in the final climate change period (+ 3C & 10% rainfall)
         return 0; // then return 0, marking cell as not resilient (and shouldn't be developed!)
       }
       else { // otherwise if cell is favorable also in the last time period
         resindexM+=1.5*FavorabilityM(2); // then multiply that favorability index by 1.5
       }
     }
     else { // otherwise if cell favorable in second time period 
       if (FavorabilityM(2) <=0.0) { // but not in the last time period
         resindexM+=1.0*FavorabilityM(1); // then multiply that favorability index by just 1
       }
       else { // otherwise if cell favorable in all time periods
       }
     }
   }
else { // if cell isn't favorable for growing now, 
     return 0;
   }
    if (resindexM > 0.0) {
       Mresilientcells.add(this);
       return resindexM;
     }
     //if (maxresindexM < resindexM) maxresindexM=resindexM;
     //println(maxresindexM);
     return resindexM;
 }
  
 public float ResilienceW() {
   float resindexW=0.0;
   maxresindexW=0.0;
   if(FavorabilityW(0) > 0.0) {
     if(FavorabilityW(1)<=0.0) {
       if (FavorabilityW(2) <=0.0) {
         return 0;
       }
       else {
         resindexW+=1.5*FavorabilityW(2);       }
     }
     else {
       if (FavorabilityW(2) <=0.0) {
         resindexW+=1.0*FavorabilityW(1);       }
       else {
         resindexW+=2.0*(FavorabilityW(1)*FavorabilityW(2)*0.5);
       }
     }
   }
  else {
     return 0;
   }
    if (resindexW > 0.0) {
     Wresilientcells.add(this);
   }
   //if (maxresindexW < resindexW) maxresindexW=resindexW;   
   //println(maxresindexW);   
   return resindexW;
 }
 */
 
  public float ResilienceM()
 {
   float resindexM=0.0;
   float maxresM=0.0;
   if(FavorabilityM(0) > 0.0) {
     if(FavorabilityM(1)<=0.0) {
       if (FavorabilityM(2) <=0.0) {
         return 0;
       }
       else {
         resindexM+=1.5*FavorabilityM(2);
       }
     }
     else {
       if (FavorabilityM(2) <=0.0) {
         resindexM+=1.0*FavorabilityM(1);
       }
       else {
         resindexM+=2.0*(FavorabilityM(1)*FavorabilityM(2)*0.5);
       }
     }
   }
   else {
     return 0;
   }
   return resindexM;
 }
  
   public float ResilienceW()
 {
   float resindexW=0.0;
   float maxresW=0.0;
   if(FavorabilityW(0) > 0.0) {
     if(FavorabilityW(1)<=0.0) {
       if (FavorabilityW(2) <=0.0) {
         return 0;
       }
       else {
         resindexW+=1.5*FavorabilityW(2);
       }
     }
     else {
       if (FavorabilityW(2) <=0.0) {
         resindexW+=1.0*FavorabilityW(1);
       }
       else {
         resindexW+=2.0*(FavorabilityW(1)*FavorabilityW(2)*0.5);
       }
     }
   }
   else {
     return 0;
   }
   return resindexW;
 }
 
 public float FavorabilityM(int climatec) {
    float sclass=0.0;
    if (suitableindexM[climatec] < 5.0) {
      return 0.0;
    }
    else if (suitableindexM[climatec] == 5.0) {
      sclass=1.0;
    }
    else if (suitableindexM[climatec] == 6.0) {
      sclass=2.0;
    }
    else if (suitableindexM[climatec] == 7.0) {
      sclass=3.0;
    }
    else if (suitableindexM[climatec] == 8.0) {
      sclass=4.0;
    }
    else {
      sclass=5.0;
    }
    float favorabilityindexM = (sclass*2 + Availability())/2;
    return favorabilityindexM;        
  }
  
 public float FavorabilityW(int climatec) {
    float sclass=0.0;
    if (suitableindexW[climatec] < 5.0) {
      return 0.0;
    }
    else if (suitableindexW[climatec] == 5.0) {
      sclass=1.0;
    }
    else if (suitableindexW[climatec] == 6.0) {
      sclass=2.0;
    }
    else if (suitableindexW[climatec] == 7.0) {
      sclass=3.0;
    }
    else if (suitableindexW[climatec] == 8.0) {
      sclass=4.0;
    }
    else {
      sclass=5.0;
    }
    float favorabilityindexW = (sclass*2 + Availability())/2;
    return favorabilityindexW;        
  }
  
  public float Availability() {
    if (urbanareas=true) return 0;
    if (protectedareas=true) return 0;
    if (inlandwater=true) return 0;
    float availabilityindex=0.0;
    float index=(percentforest+percentirrigated+cropland)/3;
    if (index < 10.0) {
      availabilityindex=9.0; 
    }
    else if (index >= 10.0 && index < 20.0) {
      availabilityindex=8.0;
    }
    else if (index >= 20.0 && index < 30.0) {
      availabilityindex=7.0;
    }
    else if (index >= 30.0 && index < 40.0) {
      availabilityindex=6.0;
    }
    else if (index >= 40.0 && index < 50.0) {
      availabilityindex=5.0;
    }
    else if (index >= 50.0 && index < 60.0) {
      availabilityindex=4.0;
    }
    else if (index >= 60.0 && index < 70.0) {
      availabilityindex=3.0;
    }
    else if (index >= 70.0 && index < 80.0) {
      availabilityindex=2.0;
    }
    else if (index >= 80.0 && index < 90.0) {
      availabilityindex=1.0;
    }    
    else {
      availabilityindex=0.0;
    }
    return availabilityindex;
  }
  
 public float CostPerKM() { // calculate average cost of constructing road in this area 
  float scost = 0.0;
  float ccost = 0.0;
  float soilcost=0.0;
  cost = 0.0;
  if (sbulkdensity > 1.5) {
    soilcost+=0.0;
  }
  else if (sbulkdensity > 1.0) {
    soilcost+=3.0;
  }
  else if (sbulkdensity > 0.5) {
    soilcost+=6.0;
  }
  else {
    soilcost+=9.0;
  }
  if (soiltype < 3 || soiltype == 3) {
    soilcost+=10.0;
  }
  else if (soiltype == 2) {
    soilcost+=3.0;
  }
  else if (soiltype == 6) {
    soilcost+=6.0;
  }
  else {
    soilcost+=10.0;
  }      
  if (conflict > 0 ) ccost=5.0;
  if (slope > 80.0) {
    scost=10.0; 
  }
   else if (slope > 70.0) {
      scost=9.0;
   }   
   else if (slope > 60.0) {
      scost=8.0;
   }   
   else if (slope > 50.0) {
      scost=7.0;
   }      
   else if (slope > 40.0) {
      scost=5.0;
   }      
   else if (slope > 30.0) {
      scost=3.0;
   }      
   else if (slope > 20.0) {
      scost=1.0;
   }      
   else {
      scost=0.0;
   }     
     cost = (minCost + (((soilcost/2)+(scost+ccost))/10.0)*diff)*gridlength;
     return cost;
  }
     
  float minCost = 193085;                    // minimum cost of constructing paved road ($/km), adjusted for inflation ($142K in 2000)
  float maxCost = 2491063;                   // maximum cost of constructing paved road ($/km), adjusted for inflation ($1.832 million in 2000)
  float diff = 2297978;                      // difference between max and min cost
  float gridlength = 3.804058792;            // average length in km of road through gridcell (accounting for the min diagonal and max purely perpendicular possibilities)
  float gridareasqk = 4.96561524602;         // area of a gridcell in square km
  float gridareah = 496.561524602;           // area of a gridcell in hectares (ha)  
  float gridareaa = 1227.030249586944;       // area of a gridcell in acres
  float c2wyieldchange = -0.0026;            // predicted change in wheat yield for Madagascar from baseline under SRES A2c 2050 scenario (Columbia U CIESIN/SEDAC)
  float c2myieldchange = -0.0886;            // predicted change in maize yield for Madagascar from baseline under SRES A2c 2050 scenario (Columbia U CIESIN/SEDAC)
  float mcalories = 3650602.40963855;        // calories per metric ton of maize (according to USDA, 606 calories per cup - 166 grams - of maize, 1,000,000 grams in a metric ton)
  float wcalories = 3340000;                 // calories per metric ton of wheat  (according to USDA, 329 calories/100 g of hard red wheat, 339 cal/100g of durum wheat)
  double totalcalories2050 = 46652580412000.0;  // total annual calories required by population of Madagascar in 2050, as projected by the UN World Population Prospects, the 2012 Revision
  
  public ArrayList ClosestCell(RoadNode _RN) {
    RN=_RN;
    for (int i=0; i<cells.size();i++) {
      Cell cell = cells.get(i);    
      float dx2 = (RN.p.x - cell.g.x)*(RN.p.x - cell.g.x);
      float dy2 = (RN.p.y - cell.g.y)*(RN.p.y - cell.g.y);
      float dz2 = (RN.p.z - cell.g.z)*(RN.p.z - cell.g.z);   
      float d2 = dx2+dy2+dz2;
    if (d2<MAXDIST) {
      NearCells.add(this);
    }
  }
  return NearCells;
  }
    
  public RoadNode RN;
  public float MAXDIST=100.0;
  public ArrayList<Cell> NearCells =new ArrayList<Cell>();  
  public ArrayList<RoadNode> nodes;

  public float WProduction() {  // calculate wheat production in calories per gridcell
    float maxWCal=0.0;
    for (int a=0; a<Wresilientcells.size();a++) {
      if(Wpotyield > maxresindexW-2.0) {
        Wprod = (Wpotyield+c2wyieldchange*Wpotyield)*gridareah; // calculate wheat production in tons per ha
        WTotalCal = WTotalCal + Wprod*wcalories;  // convert tons to calories
        if (maxWCal < WTotalCal) maxWCal=WTotalCal;
        return WTotalCal;
      }
      else if(Wpotyield > 0.0) {
        Wprod = (Wpotyield+c2wyieldchange*Wpotyield)*gridareah*0.75*c2wyieldchange;
        WTotalCal = WTotalCal + Wprod*wcalories;
        if (maxWCal < WTotalCal) maxWCal=WTotalCal;     
        return WTotalCal;
      }
      else {
        return 0;
      }
    }
    return 0;
  }

  public float MProduction() {  // calculate maize production in tons per hectare
    float maxMCal=0.0;
    for (int a=0; a<Mresilientcells.size();a++) {
      if(Mpotyield > maxresindexM-2) {
        Mprod = (Mpotyield+Mpotyield*c2myieldchange)*gridareah;
        MTotalCal = MTotalCal+Mprod*mcalories;       
        if (maxMCal < MTotalCal) maxMCal=MTotalCal;
        return MTotalCal;
      }
      else if(Mpotyield > 0.0) {
        Mprod = (Mpotyield+Mpotyield*c2myieldchange)*gridareah*0.75;
        MTotalCal = MTotalCal + Mprod*mcalories;       
        if (maxMCal < MTotalCal) maxMCal=MTotalCal;
        return MTotalCal;
      }
      else {
        return 0;
      }
    }
    return 0;
  }
  
public boolean isCity() {
  if (population > 100000) {
    cities.add(this);
    return true;
  }
  else {
      return false;
  }
}
  
public float distCity() {
  float minD = 10.0;
  for (int b=0; b<cities.size();b++) {
    Cell city = cities.get(b);
    float d=dist(city.g.x, city.g.y, this.g.x, this.g.y);
    if(d < minD) 
      minD = d;
  }
  println(minD);
  return minD;
}
  
  // PRODUCTION FUNCTION
  // layer on + interpolate if necessary existing yield data for maize + wheat
  // apply to the resilient gridcells, adjusting for level of resilience
  // adjust production based on 1) distance to nearest city, 2) population of that city and 3) existence of a paved road
  // using World Bank figures relating transportation costs to ag price elasticity and production
 
  PVector p; //screen position
  PVector g; // latitude & longitude position
  float[] suitableindexW = new float[3];
  float favorabilityindexW = 0.0;
  float Wpotyield = 0.0;
  float Mpotyield = 0.0;
  int conflict = 0;
  float maxresindexW=0.0;
  float maxresindexM=0.0;
  float resilienceW = 0.0;
  boolean city = false;
  float population = 0.0;
  float favorabilityindexM = 0.0;
  float cost = 0.0;
  float resilienceM = 0.0;
  float[] suitableindexM = new float[3];
  int climatec = 0;
  float cropland = 0.0;
  float Wprod = 0.0;
  float Mprod = 0.0;
  boolean urbanareas = false;
  float percentforest = 0.0;
  boolean inlandwater = false;
  float percentirrigated = 0.0;
  boolean protectedareas = false; 
  float slope = 0.0;
  float WTotalCal = 0.0;
  float MTotalCal = 0.0;
  float maxWCal=0.0;
  float maxMCal=0.0;
  float soiltype=0.0;
  float sbulkdensity=0.0;
  float province=0.0;
  int ID=0;
}
