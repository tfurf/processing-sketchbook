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
  abstract void draw( PVector p , color c );
}

class EllipseBrush extends Brush {
  EllipseBrush () {}
  void draw( PVector p , color c ) {
    noStroke();
    fill(c);
    ellipse( p.x , p.y , 10 , 10 );  
  }
}

class Streaker {
  color base_color;
  PVector direction;
  PVector start;
  float speed;
  int e_h = 5;
  int e_w = 5;
  PVector[] track;
  Streaker ( Canvas canvas , color base_color , PVector dir , PVector start  , float s ) {
    base_color = base_color ;  // Base color
    direction = dir;           // Direction
    start = start ;              // Base row or column.
    speed = s;
  }
  void iterate ( int ctr , Brush br ) {
    track = append( track, new PVector(track[track.length-1]).mult( s*ctr ) );
    for ( PVector p : track ) {
      println( p );
      br.draw(p , base_color );
    }
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

void setup() {
   canvas = new Canvas ( width , height , 0 , 60 );
   canvas.setup();
   str = new Streaker( canvas , color( 50 , 50 , 50 , 0 ) , new PVector( 1 , 0 ) , new PVector( height/2 , 0 ) , 10/canvas.frame_rate );
   brush = new EllipseBrush();
}
void draw() {
  str.iterate( ++i , brush );
}


