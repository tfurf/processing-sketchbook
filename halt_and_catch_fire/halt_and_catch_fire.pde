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

class Brush {
  Brush() {}
  void draw( Point p ) {
  }
}

class EllipseBrush extends Brush {
  void draw( Point p , color c ) {
    noStroke();
    fill(c);
    ellipse( p.x , p.y , 10 , 10 );  
  }
}

class Streaker {
  color base_color;
  Direction direction;
  int datum;
  int position , position_;
  float speed;
  int e_h = 5;
  int e_w = 5;
  Point[] track;
  Streaker ( Canvas canvas , color base_color , Direction dir , int dat , float s ) {
    base_color = base_color ;  // Base color
    direction = dir;           // Direction
    datum = dat ;              // Base row or column.
    speed = s;
     if (( direction == Direction.UP ) || ( direction == Direction.RIGHT )) {
       position = 0;
     }
     else if ( direction == Direction.LEFT ) {
       position = canvas.width ;
     }
     else if ( direction == Direction.DOWN ) {
       position = canvas.height ;       
     }
     position_ = position;
  }
  void iterate ( int ctr , Brush br ) {
    int X = track[track.length-1].x;
    int Y = track[track.length-1].y;
    switch ( direction ) {
      case Direction.UP:
        Y++;
        break;
      case Direction.RIGHT:
        X++;
        break;
      case Direction.DOWN:
        Y--;
        break;
      case Direction.LEFT:
        Y++;
        break;
    }
    track = append( track , track[track.length-1].add( 1 , 0 ) );
    for ( Point p : track ) {
      br.draw(p , base_color );
    }
  }
}


int width = 1280;
int height = 720;

Canvas canvas;
Streaker str;

int y = 50;
float x;
int red= 200;
int r;
int diam = 1;
int jitter = 1;
int a = 640;
int b = height;
int c = 640;

void setup() {
   canvas = new Canvas ( width , height , 0 , 60 );
   canvas.setup();
   str = new Streaker( canvas , color( 100 , 100 , 100 , 0 ) , Direction.RIGHT , height/2 , 10 );
}

void draw() {
  // red dripping ellipse
  noStroke();
  fill(red, 20, 22, 196);
  diam = int(random(2,10));
  jitter = int(random(-4,4));
  red = red + 1;
  if (red > 255) {
    red =200;
  }
  ellipse(x, y + jitter, diam, diam);
  // bright ellipse
  noStroke();
  fill(255, 0, 91,20);
  ellipse(x,y,12 +diam*4,12+diam*4);
   // blue rect
   rectMode(CENTER);
   fill(#C7FAF4,111);
   rect(a+jitter/2,b,2,14);
   fill(#1C6CE8,188);
   //rect(c,b,6,6);
   rect(a,b,4,6);
  b= b-2;
  c = c-3;
  if (b<1){
    b=height;
    a= a -7 + jitter*7;}
  if (r>17) {
    r=0;
  }
  x=x+2;
  if (x > width) {
    x = 0;
    y= y +35;
  }
  //  y++;
  if (y > height) {
    y = 0; 
  }
}


