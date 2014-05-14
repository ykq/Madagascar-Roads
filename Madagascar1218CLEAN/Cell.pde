 // import different types of data storage structures from Java
import java.util.ArrayList;
import java.util.HashSet;
import java.util.*;

// declare the class "Cell"
public static class Cell {

  // reference the RoadNetwork rnet
  RoadNetwork rnet;

  // declare basic cell prototype
  public Cell(PVector location) 
  {
    // with variable location
    g = location;
  }

  // impute resilience index for growing maize
  public float ResilienceM()
  {
    // record max resilience index achieved
    float resindexM=0.0;
    float maxresM=0.0;
    // if favorable under current climate conditions
    if (FavorabilityM(0) > 0.0) {
      // then check if not favorable under the second climate condition
      if (FavorabilityM(1)<=0.0) {
        and finally, if not favorable under the last climate condition
        if (FavorabilityM(2) <=0.0) {
          // if not favorable in either of the next climate change conditions, then impute index of 0
          return 0;
        }
        // otherwise if favorable in the 3rd but not 2nd condition
        else {
          // then impute resilience as the average of the current and 3rd climate conditions (divided by total number of climate scenarios)
          resindexM=(FavorabilityM(0)+FavorabilityM(2))/3;
        }
      }
      // if favorable under the 2nd climate condition
      else {
        // then check if not favorable in the 3rd climate condition
        if (FavorabilityM(2) <=0.0) {
          // if so, then impute resilience index as the weighted average of the current and 2nd climate conditions
          resindexM=(FavorabilityM(0)+1.25*FavorabilityM(1))/3;
        }
        // if favorable under all climate conditions, then compute the weighted average of all (weighting scenario 2 as the most temporally proximate)
        else {
          resindexM=((FavorabilityM(0)+FavorabilityM(1)+1.25*FavorabilityM(2))/3);
        }
      }
    }
    // ootherwise if not favorable under current conditions, then impute as 0 - these are all projections anyway and don't want to build a road to nowhere!
    else {
      return 0;
    }
    // if resilience index is higher than average (6), then add it to the list of resilient cells
    if (resindexM > 6.0) {
      Mresilientcells.add(this);
    }
    return resindexM;
  }

  // impute resilience index for growing maize
  public float ResilienceW()
  {
        // record max resilience index achieved
    float resindexW=0.0;
    float maxresW=0.0;
    if (FavorabilityW(0) > 0.0) {
      if (FavorabilityW(1)<=0.0) {
        if (FavorabilityW(2) <=0.0) {
          return 0;
        }
        else {
          resindexW=(FavorabilityW(0)+FavorabilityW(2))/3;
        }
      }
      else {
        if (FavorabilityW(2) <=0.0) {
          resindexW=(FavorabilityW(0)+1.25*FavorabilityW(1))/3;
        }
        else {
          resindexW=((FavorabilityW(0)+FavorabilityW(1)+1.25*FavorabilityW(2))/3);
        }
      }
    }
    else {
      return 0;
    }
    if (resindexW > 6.0) {
      Wresilientcells.add(this);
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
    else if (suitableindexM[climatec] == 9.0) {
      sclass=5.0;
    }
    else {
      sclass=0.0;
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
    else if (suitableindexW[climatec] == 9.0) {
      sclass=5.0;
    }
    else {
      sclass=0.0;
    }
    float favorabilityindexW = (sclass*2 + Availability())/2;
    return favorabilityindexW;
  }

  public float Availability() {
    if (urbanareas == 2) return 0;
    if (protectedareas >= 1.0) return 0;
    if (inlandwater == -997) return 0;
    float availabilityindex = 0.0;
    if (percentforest < 0.0 ) percentforest = 0.0;
    if (percentirrigated < 0.0) percentirrigated = 0.0;
    if (cropland < 0.0) cropland = 0.0;    
    float index=(percentforest+percentirrigated+cropland)/3;
    if (index < 10.0) {
      availabilityindex=9.0;
    }
    if (index >= 10.0 && index < 20.0) {
      availabilityindex=8.0;
    }
    if (index >= 20.0 && index < 30.0) {
      availabilityindex=7.0;
    }
    if (index >= 30.0 && index < 40.0) {
      availabilityindex=6.0;
    }
    if (index >= 40.0 && index < 50.0) {
      availabilityindex=5.0;
    }
    if (index >= 50.0 && index < 60.0) {
      availabilityindex=4.0;
    }
    if (index >= 60.0 && index < 70.0) {
      availabilityindex=3.0;
    }
    if (index >= 70.0 && index < 80.0) {
      availabilityindex=2.0;
    }
    if (index >= 80.0 && index < 90.0) {
      availabilityindex=1.0;
    }    
    if (index>90.0) {
      availabilityindex=0.0;
    }
    return availabilityindex;
  }

  public float CostPerKM() { // calculate average cost of constructing road in this area 
    maxrealcost = 0.0;
    float scost = 0.0;
    float ccost = 0.0;
    float soilcost=0.0;
    float cost = 0.0;
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
    //cost = (minCost + (((soilcost/2)+(scost+ccost))/100.0)*diff)*gridlength;
    cost = (minCost + (((soilcost/2)+(scost+ccost))/40.0)*diff);
    if (maxrealcost<cost) maxrealcost=cost;
    return cost;
  }

  public float distadj() {
    float distadj = 0.0;
    if (distCity() > 120) { // given World Bank analysis (2010) that actual production will be half of potential if farm is more than 4 hours away from a city of 100K people, given that the best average speed on road in Madagascar is 30 km/h
      distadj = 0.5;
    }
    else if (distCity() > 60) {
      distadj = 0.65;
    }
    else if (distCity() > 30) {
      distadj = 0.75;
    }
    else if (distCity() > 15 ) {
      distadj = 0.80;
    }
    else if (distCity() > 6) {
      distadj = 0.85;
    }
    else if (distCity() > 3) {
      distadj = 0.9;
    }
    else {
      distadj = 0.95;
    }
    return distadj;
  }

  public float CurrentProd() {
    if (((cropland+percentirrigated)/2) > 50.0) {
      if (Wpotyield > 0.0) {
        float NowWProd = (Wpotyield+c2wyieldchange*Wpotyield)*gridareah*distadj();
        TotalWCal = TotalWCal + NowWProd*wcalories;
      }
      if (Mpotyield > 0.0) {
        float NowMProd = (Mpotyield+Mpotyield*c2myieldchange)*gridareah*distadj();
        TotalMCal = TotalMCal + NowMProd*mcalories;
      }
    }
    TotalCurProd = TotalWCal;
    if (TotalCurProd < TotalMCal) TotalCurProd = TotalMCal;
    return TotalCurProd;
  } 

  public float PotWProduction() {  // calculate wheat production in calories per gridcell
    float maxWCal = 0.0;
    if (Wpotyield > 0.0) { 
      if (resindexW > maxresindexW-2) {
        float Wprod = (Wpotyield+c2wyieldchange*Wpotyield)*gridareah*distadj(); // calculate wheat production in tons per ha
        float WCal = Wprod*wcalories;  // convert tons to calories
        if (maxWCal < WCal) maxWCal=WCal;
        return WCal;
      }
      else if (resindexW > 0.0) {
        float Wprod = (Wpotyield+c2wyieldchange*Wpotyield)*gridareah*distadj()*0.75*c2wyieldchange;
        float WCal = Wprod*wcalories;
        if (maxWCal < WCal) maxWCal=WCal;   
        return WCal;
      }
      else {
        return 0;
      }
    }
    else {
      return 0;
    }
  }

  public float PotMProduction() {  // calculate maize production in tons per hectare
    float maxMCal=0.0;
    if (Mpotyield > 0.0) {
      if (resindexM > maxresindexM-2) {
        float Mprod = (Mpotyield+Mpotyield*c2myieldchange)*gridareah*distadj();
        float MCal = Mprod*mcalories;  
        if (maxMCal < MCal) maxMCal = MCal;
        return MCal;
      }
      else if (resindexM > 0.0) {
        float Mprod = (Mpotyield+Mpotyield*c2myieldchange)*gridareah*distadj()*0.75;
        float MCal = Mprod*mcalories;      
        if (maxMCal < MCal) maxMCal = MCal;
        return MCal;
      }
      else {
        return 0;
      }
    }
    else {
      return 0;
    }
  }

  public float TotPotProd() {
    maxPotProd = 0.0;
    if (PotWProduction() > 0.0 && PotMProduction() > 0.0) {
      if (PotWProduction() > PotMProduction()) {
        float TotPotProd = PotWProduction();
      }
      else {
        TotPotProd = PotMProduction();
      }
      Allresilientcells.add(this);  
      if (maxPotProd<TotPotProd) maxPotProd=TotPotProd;   
     println(maxPotProd); 
      return TotPotProd;
    }
    else {
      return 0;
    }
  }  
  /*
  public float ActivatedResCells(ArrayList<Cell> rescells) {
   Road.roads
   this.cell = c;
   this.cell.Allresilientcells2 = rescells;
   ArrayList<Cell> Activated = new ArrayList<Cell>();
   float MINDIST = 1.0;
   float actiprod = 0.0;
   for (int i=0; i<rescells.size(); i++) {
   Cell cell = rescells.get(i) {
   for (int j=0; j<nodes.size(); j++) {
   RoadNode RN = nodes.get(i);
   float dx2 = (RN.x - cell.g.x)*(RP.x - cell.g.x);
   float dy2 = (RP.y - cell.g.y)*(RP.y - cell.g.y);   
   float d2 = dx2+dy2;   
   if (d2 < MINDIST) {
   Activated.add(cell);
   actiprod = actiprod + cell.TotPotProd;
   }
   
   }
   return actiprod;
   }
   }  
   */
  public float maxPotProd = 0.0; 
  public static float maxrealcost = 0.0;  
  public float minCost = 193085;                    // minimum cost of constructing paved road ($/km), adjusted for inflation ($142K in 2000)
  public static float maxCost = 2491063;                   // maximum cost of constructing paved road ($/km), adjusted for inflation ($1.832 million in 2000)
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
  float TotalMCal = 0.0;
  float TotalWCal = 0.0;
  float TotalCurProd = 0.0;
  //float actiprod = ActivatedResCells(rnet, Allresilientcells);
  //public double caloriedeficit = totalcalories2050 - (double) TotalCurProd - (double) actiprod;

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
    float minD = Integer.MAX_VALUE;
    for (int b=0; b<cities.size();b++) {
      Cell city = cities.get(b);
      float d=dist(city.g.x, city.g.y, this.g.x, this.g.y);
      if (d < minD) 
        minD = d;
    }
    return minD;
  }
  /*
public Cell distCity() {
   float minD = Integer.MAX_VALUE;
   Cell minCity = null;
   for (int b=0; b<cities.size();b++) {
   Cell city = cities.get(b);
   float d=dist(city.g.x, city.g.y, this.g.x, this.g.y);
   if(d < minD) 
   minD = d;
   minCity = city;
   }
   return minCity;
   }*/


  // PRODUCTION FUNCTION
  // layer on + interpolate if necessary existing yield data for maize + wheat
  // apply to the resilient gridcells, adjusting for level of resilience
  // adjust production based on 1) distance to nearest city, 2) population of that city and 3) existence of a paved road
  // using World Bank figures relating transportation costs to ag price elasticity and production

  public ArrayList<Cell> cells = new ArrayList<Cell>(); // store all cells (~120K!)
  public ArrayList<Cell> Wresilientcells = new ArrayList<Cell>(); // create shorter list of wheat-producing resilient cells
  public ArrayList<Cell> Mresilientcells = new ArrayList<Cell>(); // create shorter list of maize-producing resilient cells 
  public static ArrayList<Cell> cities = new ArrayList<Cell>(); // create shorter list of cities (cells w/ pop>100K) 
  public static ArrayList<Cell> Allresilientcells = new ArrayList<Cell>(); // create list of all resilient cells

  PVector p; //screen position
  PVector g; // latitude & longitude position
  float[] suitableindexW = new float[3];
  float favorabilityindexW;
  float Wpotyield = 0.0;
  float Mpotyield = 0.0;
  int conflict = 0;
  float maxresindexW=0.0;
  float maxresindexM=0.0;
  float resindexW;
  float resindexM;
  float resilienceW = 0.0;
  boolean city = false;
  float population = 0.0;
  float favorabilityindexM = 0.0;
  float resilienceM = 0.0;
  float[] suitableindexM = new float[3];
  int climatec = 0;
  float cropland = 0.0;
  float Wprod = 0.0;
  float Mprod = 0.0;
  float cost;
  float urbanareas = 0.0;
  float percentforest = 0.0;
  float inlandwater = 0.0;
  float percentirrigated = 0.0;
  float protectedareas; 
  float slope = 0.0;
  float WTotalCal = 0.0;
  float MTotalCal = 0.0;
  float TotPotProd;
  float maxWCal=0.0;
  float maxMCal=0.0;
  float soiltype=0.0;
  float sbulkdensity=0.0;
  float province=0.0;
  int ID=0;
}

