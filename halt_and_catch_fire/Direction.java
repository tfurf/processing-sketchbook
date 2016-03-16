enum Direction {
  DOWN, UP , LEFT , RIGHT;
}

class Point {
  int x , y ;
  Point ( int x , int y ) {
    x = x ;
    y = y ;
  }
  Point add ( int X , int Y ){
    return Point ( X + x , Y + Y );
  }
}
