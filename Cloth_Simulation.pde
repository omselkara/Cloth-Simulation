ArrayList<Point> points = new ArrayList<Point>();
ArrayList<Stick> sticks = new ArrayList<Stick>();

float gravity = 8F;
float fps = 100;
float deltatime = 1./fps;
int col = 100;
int row = 100;
float radius = 0;
int iter = 10;
Point[][] ps = new Point[row][col];

void setup(){
  size(600, 600,P3D);
  frameRate(fps);
  for (int y=0;y<row;y++){
    for (int x=0;x<col;x++){
      Point p = new Point(x*((width-100)/col)+75,y*((height-100)/row)+75,y==0);
      points.add(p);
      ps[y][x] = p;
      if (y>0){
        sticks.add(new Stick(ps[y-1][x],p));
      }
      if (x>0){
        sticks.add(new Stick(ps[y][x-1],p));
      }
    }
  }
}
void draw(){
  background(0);
  simulate();
  for (Stick s : sticks){
    if (!s.isRuptured)s.show();
  }
  for (Point p : points){
    p.show();
  }
  if (mousePressed){
    for (int i=sticks.size()-1;i>=0;i--){
      Stick s = sticks.get(i);
      if (s.isRuptured)continue;
      if (collision(s.p1.x,s.p1.y,s.p2.x,s.p2.y,pmouseX,pmouseY,mouseX,mouseY)){
        sticks.remove(i);
      }
    }
  }
}
