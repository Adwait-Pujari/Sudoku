import javax.swing.JOptionPane;

char[] cells=new char[81];
int[] display=new int[81];
boolean[] fill=new boolean[81];
float grid_distance;
//---------------------------------------------------------------------------//
void setup()
{
  size(500, 500);
  grid_distance=width/9.0;
  textAlign(CENTER, CENTER);
  Default();
  println("Click on the top of the screen to enter your first digit and press the key hard on your keyboard.");
}
//---------------------------------------------------------------------------//
void mousePressed() //----------------------------------// The mouseClick funtion
{
  erase();
  int x=int(mouseX/grid_distance);
  int y=int(mouseY/grid_distance);
  valid = false;
  numdisplay(x, y);
  println("Typed Character: " + key);
  if(!valid ){
    if (!fill[x+y*9] && key>='1' && key<='9' )
    {   
      cells[x+y*9]=key;
      display[x+y*9]=key;
      fill[x+y*9]= true;
    }
  }
  println("Please click on the screen to continue.");
}
//---------------------------------------------------------------------------//
void erase()
{
  int x=int(mouseX/grid_distance);
  int y=int(mouseY/grid_distance); 
  if(fill[x+y*9] && key=='c')
  {
    cells[x+y*9]=' ';
    background(200);
    fill[x+y*9]=false;
    text(cells[x+y*9], x*grid_distance+grid_distance/2, y*grid_distance+grid_distance/2);
    drawGrid();
    random_display();
    Default();
    
  }
}
//---------------------------------------------------------------------------//
void draw()
{  
  drawGrid();
  random_display();
}
//---------------------------------------------------------------------------//
void drawGrid() //----------------------------------// Grid Outline
{ 
  float gridx=0, gridy=0;
  for (int i=1; i<=10; i++)
  {   
    if ((i-1)%3==0)
    {
      strokeWeight(5);
    } else
    {
      strokeWeight(2);
    }
    line(gridx, 0, gridx, height);
    gridx=gridx+grid_distance;

    line(0, gridy, width, gridy);
    gridy=gridy+grid_distance;
  }
}
//---------------------------------------------------------------------------//
int startnumR, startnumC, startnumS, startSubGrid, choice;
boolean valid;
void numdisplay(int x, int y) //----------------------------------// To detect repeated numbers in a row column or subgrid
{
  choice=x+y*9;
  int temp=key;
  startnumR=choice-choice%9;
  for (int i=startnumR; i<startnumR+9; i++)
  {
    if (cells[i]==temp){
      valid=true;
    }    
  }
  startnumC= choice-(int(choice/9)*9);
  for (int i=startnumC; i<startnumC+81; i+=9)
  {
    if (cells[i]==temp){
      valid=true;   
    }
  } 
  startSubGrid=int((choice%9)/3) + 3*int(choice/27);  
  startnumS= subgrid_solver(startSubGrid);
  for(int i=startnumS;i<=startnumS+18;i+=9)
  {  
    if(cells[i]==temp || cells[i+1]==temp || cells[i+2]==temp)
      valid=true;
  }
  if(valid)
    JOptionPane.showMessageDialog(null,"Sorry you cannot enter the number here","Repeated numbers",JOptionPane.WARNING_MESSAGE);
}
//---------------------------------------------------------------------------//
void random_display()//----------------------------------// To dispay the numbers on the screen 
{
  for (int i=0; i<81; i++)
  {
    
    if (fill[i] && (cells[i]<='9' ||cells[i]==0) )      // To print default values
    {
      fill(#00B1DB);
      textSize(width/20);
      text(cells[i], int(i%9)*grid_distance+grid_distance/2, int(i/9)*grid_distance+grid_distance/2);     
    }    
    if (fill[i] && (display[i]>=32 ||cells[i]==0) )     // To print user entered values
    {
      fill(0);
      textSize(width/20);
      text(cells[i], int(i%9)*grid_distance+grid_distance/2, int(i/9)*grid_distance+grid_distance/2);     
    }  
  }
}
//---------------------------------------------------------------------------//
void Default()//----------------------------------------------// To store the default values of the grid
{
  cells[49]=cells[61]=cells[74]='1';
  fill[49]=fill[61]=fill[74]=true;

  cells[19]=cells[45]=cells[69]='2';
  fill[19]=fill[45]=fill[69]=true;

  cells[16]=cells[35]=cells[50]=cells[67]='3';
  fill[16]=fill[35]=fill[50]=fill[67]=true;

  cells[1]=cells[13]=cells[30]=cells[43]=cells[54]=cells[71]='4';
  fill[1]=fill[13]=fill[30]=fill[43]=fill[54]=fill[71]=true;

  cells[64]=cells[75]='5';
  fill[64]=fill[75]=true;

  cells[6]=cells[11]=cells[41]=cells[79]='6';
  fill[6]=fill[11]=fill[41]=fill[79]=true;

  cells[5]=cells[20]=cells[39]='7';
  fill[5]=fill[20]=fill[39]=true;

  cells[9]=cells[26]=cells[31]=cells[60]='8';
  fill[9]=fill[26]=fill[31]=fill[60]=true;

  cells[37]='9';
  fill[37]=true;
}
//---------------------------------------------------------------------------//
int subgrid_solver(int subgrid)
{
  int firstnum=0;
  if(subgrid==0)
    firstnum=0;
  else if(subgrid==1)
    firstnum=3;
  else if(subgrid==2)
    firstnum=6;
  else if(subgrid==3)
    firstnum=27;
  else if(subgrid==4)
    firstnum=30;
  else if(subgrid==5)
    firstnum=33;
  else if(subgrid==6)
    firstnum=54;
  else if(subgrid==7)
    firstnum=57;
  else if(subgrid==8)
    firstnum=60;
  return firstnum;
}
//---------------------------------------------------------------------------//
