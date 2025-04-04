class Point{
  float x,y,px,py;
  boolean locked;
  Point(float x,float y,boolean locked){
    this.x = x;
    this.y = y;
    this.locked = locked;
    px = x;
    py = y;
  }
  void move(){
    if (!locked){
      float bx = x;
      float by = y;
      x += x-px;
      y += y-py;
      y += gravity*deltatime;
      px = bx;
      py = by;
    }
  }
  void show(){
    fill(255);
    if (locked)fill(255,0,0);
    strokeWeight(0);
    circle(x,y,radius);
  }
}

class Stick{
  Point p1,p2;
  float len;
  boolean isRuptured = false;
  Stick(Point p1,Point p2){
    this.p1 = p1;
    this.p2 = p2;
    len = dist(p1.x,p1.y,p2.x,p2.y);
  }
  Stick(Point p1,Point p2,float len){
    this.p1 = p1;
    this.p2 = p2;
    this.len = len;
  }
  void check(){
    float distance = sqrt((p2.x-p1.x)*(p2.x-p1.x)+(p2.y-p1.y)*(p2.y-p1.y));
    if (distance/len>=2){
      isRuptured = true;
      return;
    }
    float cx = (p1.x+p2.x)/2;
    float cy = (p1.y+p2.y)/2;
    PVector d = normalize(p1.x,p1.y,p2.x,p2.y);
    float dx = d.x;
    float dy = d.y;
    if (!p1.locked){
      p1.x = cx-dx*(len/2);
      p1.y = cy-dy*(len/2);
    }
    if (!p2.locked){
      p2.x = cx+dx*(len/2);
      p2.y = cy+dy*(len/2);
    }
  }
  void show(){
    stroke(235, 52, 82);
    strokeWeight((width-100)/col);
    line(p1.x,p1.y,p2.x,p2.y);
  }
}

PVector normalize(float x1,float y1,float x2,float y2){
  float r = dist(0,0,x2-x1,y2-y1);
  PVector dir = new PVector((x2-x1)/r,(y2-y1)/r);
  return dir;
}

void simulate(){
  for (Point p : points){
    p.move();
  }
  for (int i=0;i<iter;i++){
    for (Stick s : sticks){
      if (!s.isRuptured)s.check();
    }
  }
}

boolean collision(float x1,float y1,float x2,float y2,float x3,float y3,float x4,float y4){
  float D = (x1-x2)*(y3-y4)-(y1-y2)*(x3-x4);
  float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/D;
  if (t<0 || t>1)return false;
  float u = ((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/D;
  if (u<0 || u>1)return false;
  return true;
}
