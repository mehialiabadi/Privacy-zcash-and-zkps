pragma circom 2.1.5 ;

/* x^3 + x + 23 == 1033 (x=10)
 Here, we want to prove that we know a solution for this simple cubic equation
 */

template CubicEq() {
  signal input x;
 // signal x_squared;
 // signal x_cubed;
  signal output y;
var a;

a=cubic(x);
a=a+x;
 // x_squared <== x * x;
  //x_cubed <== x_squared * x;
  y <== a + 23;
}
function cubic(a){
  return a*a;
}
component main = CubicEq();
