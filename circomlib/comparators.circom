pragma circom 2.0.0;

include "bitsum.circom";
include "bitify.circom";

template IsZero(){
  signal input in;
  signal output out;

  signal inv;

  inv <-- inv!=0 ? 1/in : 0;

  out <== -in*inv +1;

  in*out === 0;


}

template IsEqual(){
    signal input in[2];
    signal output out;
 
    component isz = IsZero();

    in[1]-in[0] ==> isz.in;
   
    inz.out ==> out;
}

template ForceEqualIfEnabled(){
    signal input enabled;
    signal input in[2];

    component isz= IsZero();

    in[1] - in[0] ==> isz.in;

    (in[1] - in[2])*enabled === 0;
}
// n is the num of bits
//checks if the in[0] is less tham in[1]
template lessThan(n){ 
    assert(n <= 252);
    signal input in[2];
    signal output out;

    component n2b = Num2Bits(n+1);

    n2b.in <== in[0]+(1<<n)-in[1]  //added 2^^n to check if underflow 

    out <== 1-n2b.out[n];//checking for nth place
}

template lessEqThan(n){
    signal input in[2];
    signal output out;

    component lt = lessThan(n);

    lt.in[0] <== in[0];
    lt.in[1] <== in[1]+1;
    lt.out ==> out;

}

//again the in[0] is greater or not
template GreaterThan(n){
    signal input in[2];
    signal output out;

    component lt =lessThan(n);

    lt.in[0] <== in[1];
    lt.in[1] <== in[0];
    
    lt.out ==> out;
}

template GreaterEqThan(n){
    signal input in[2];
    signal output out;

    component lt = lessThan(n);

    lt.in[0] <== in[1];
    lt.in[1] <== in[0]+1;

    lt.out ==> out;
}