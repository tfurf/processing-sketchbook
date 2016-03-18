class Canvas {
  // Class for keeping track of the canvas.
  int height;
  int width;
  int background;
  int frame_rate;
  Canvas( int w , int h , int b , int fr) {
     height = h;
     width = w;
     background = b;
     frame_rate = fr ;
  }
  void setup () {
     size( width , height );
     background( background );
     frameRate( frame_rate );
  }
  void reset() {
      background( background ); 
  }
}

abstract class Brush {
  Brush() {}
  abstract void draw( PVector p , int diam , color c );
}

class EllipseBrush extends Brush {
  EllipseBrush () {}
  void draw( PVector p , int diam , color c ) {
    noStroke();
    fill(c);
    ellipse( p.x , p.y , diam , diam );  
  }
}

class Streaker {
  color base_color;
  PVector direction;
  PVector start;
  float speed;
  int e_h = 5;
  int e_w = 5;
  int diameter;
  ArrayList<PVector> track;
  Streaker ( Canvas canvas , color base_color , PVector dir , PVector start_  , int diam_ , float s ) {
    base_color = base_color ;  // Base color
    direction = dir;           // Direction
    start = start_ ;              // Base row or column.
    speed = s;
    diameter = diam_ ;
    track = new ArrayList<PVector>();
  }
  void iterate ( int ctr , Brush br ) {
    PVector step = PVector.mult( direction , speed*ctr ) ;
    PVector next = PVector.add( start , step );
    track.add( next );
    if ( track.size() > 2 ) {
      for ( PVector p : track.subList(0, track.size() - 2 ) ) {
        br.draw(p , diameter, base_color );
      }
    }
    br.draw( next , 3*diameter , base_color );
  }
}


int width = 1280;
int height = 720;

Canvas canvas;
Streaker str;

int y = 50;
int i = 0;
float x;
int red= 200;
int r;
int diam = 1;
int jitter = 1;
int a = 640;
int b = height;
int c = 640;
Brush brush ;
ArrayList<Streaker> streakers ;

void setup() {
   canvas = new Canvas ( width , height , 255 , 60 );
   canvas.setup();
   str = new Streaker( canvas , color( 100 , 0 , 0 , 0 ) , new PVector( 1 , 0 ) , new PVector( 0 , height/2  ) , 10 , 200.0/canvas.frame_rate );
   brush = new EllipseBrush();
   streakers = new ArrayList<Streaker>();
}
void draw() {
  canvas.reset();
  str.iterate( ++i , brush );
}


