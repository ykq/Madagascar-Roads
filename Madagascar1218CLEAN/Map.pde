import java.util.Scanner;

// create the base map
class Map 
{

  int ncol=0;
  int nrow=0;
  public int numCellRows, numCellCols;
  float xllcorner=-180.0;
  float yllcorner=-90.0;
  float cellsize=0.0;

  // READ IN DATA FOR SUITABILITY ANALYSIS
  // read in land suitable for wheat production in current climate conditions     
  void ParseFile(String fname) 
  {

    // create a BufferedReader to read files line by line as individual String objects
    BufferedReader reader=createReader(fname);  

    // recognize all cells with 0 as having no data
    float NDATA=0;

    // create a two-dimensional array to hold data
    float[][] data = null;

    // start executing reader
    try 
    {

      // go line by line 
      String line;
      String [] tokens;

      // go to the first line and find the number of columns from csv header
      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      // go to next line and find the number of rows from csv header        
      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      // find the max x, max y coordinates, cellsize and no data values from csv header    
      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      // call this function first at start
      if (cells==null) 
      {
        // start creating the grid of cells according to csv parameters
        cells = new Cell[nrow][ncol];
        this.numCellRows = nrow;
        this.numCellCols = ncol;
        // iterate over the rows
        for (int j=0; j<nrow; ++j) 
        {
          float latitude=yllcorner+(nrow-1-j)*cellsize;            
          // and the columns, one by one
          for (int i=0; i<ncol; ++i) 
          {
            // to calculate the latitude and longitude
            float longitude=xllcorner+i*cellsize;
            // create a new cell in the backend array & a point on screen at each lat/long as indicating suitability for growing maize
            cells[j][i]=new Cell(new PVector(longitude, latitude, 0.0));
            cells[j][i].p=new PVector(width*i/(float)(ncol-1.0), height*j/(float)(nrow-1.0), 0.0);
          }
        }
      }

      int row=0;
      int col=0;
      Scanner s;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) 
      {     
        s = new Scanner(line);
        col=0;
        while (s.hasNextFloat ()) 
        {
          st=s.nextFloat();            
          cells[row][col].suitableindexM[0]=st;
          col++;
        } 
        line=reader.readLine();
        row++;
      }
      reader.close();
    } 
    catch (IOException e) 
    {
      e.printStackTrace();
    }
  }

  // read in land suitable for maize production in +2C       
  void ReadFileM2(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      int i=0;
      int j=0;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].suitableindexM[1]=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in land suitable for maize production in +3C & +10% rainfall       
  void ReadFileM3(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      int i=0;
      int j=0;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].suitableindexM[2]=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in land suitable for wheat production now      
  void ReadFileW1(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      int i=0;
      int j=0;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].suitableindexW[0]=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in land suitable for wheat production +2C      
  void ReadFileW2(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      int i=0;
      int j=0;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].suitableindexW[1]=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in land suitable for wheat production +3C & +10% rainfall      
  void ReadFileW3(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      int i=0;
      int j=0;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].suitableindexW[2]=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // READ IN DATA FOR AVAILABILITY ANALYSIS
  // read in existing cropland data      
  void ReadFile(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      int i=0;
      int j=0;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].cropland=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in urban areas
  void ReadFileU(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();

      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          if (st==2.0) {
            cells[j][i].urbanareas=st;
          }     
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in percent forest
  void ReadFileF(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      int i=0;
      int j=0;        
      float st=0.0;
      line=reader.readLine();
      while (line!=null) 
      {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) 
        {
          st=s.nextFloat();           
          cells[j][i].percentforest=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in inland water bodies
  void ReadFileW(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      int i=0;
      int j=0;        
      Scanner s;
      float st=0.0;
      line=reader.readLine();
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) 
        {
          st=s.nextFloat();           
          cells[j][i].inlandwater=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in protected areas
  void ReadFileP(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].protectedareas=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in irrigated areas
  void ReadFileI(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].percentirrigated=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in population data
  void ReadFilePop(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].population=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in conflict data
  void ReadFileC(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].conflict=(int)st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in slope data
  void ReadFileS(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].slope=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in potential wheat yield data
  void ReadFilePW(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].Wpotyield=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in potential maize yield data
  void ReadFilePM(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].Mpotyield=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in soil type data
  void ReadFileST(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].soiltype=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in soil bulk density data
  void ReadFileSBD(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].sbulkdensity=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  // read in provinces data
  void ReadFileProv(String fname) 
  {
    BufferedReader reader=createReader(fname);  

    float NDATA=0;
    float[][] data = null;
    try 
    {

      String line;
      String [] tokens;

      line=reader.readLine();
      tokens=line.split(" +");
      ncol=Integer.parseInt(tokens[1]);

      line=reader.readLine();
      tokens=line.split(" +");
      nrow=Integer.parseInt(tokens[1]);

      xllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      yllcorner=Float.parseFloat(reader.readLine().split(" +")[1]);
      cellsize=Float.parseFloat(reader.readLine().split(" +")[1]);
      NDATA=Float.parseFloat(reader.readLine().split(" +")[1]);

      Scanner s;
      float st=0.0;
      line=reader.readLine();
      int i=0;
      int j=0;
      while (line!=null) {     
        s = new Scanner(line);
        i=0;
        while (s.hasNextFloat ()) {
          st=s.nextFloat();           
          cells[j][i].province=st;
          i++;
        }
        line=reader.readLine();
        j++;
      }
      reader.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  }

  public Cell [][]cells;
}

