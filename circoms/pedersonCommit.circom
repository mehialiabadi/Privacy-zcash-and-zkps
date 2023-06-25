
pragma circom 2.1.5;
include "../node_modules/circomlib/circuits/pedersen.circom";

/* pederson commitment takes some input mesage and outputs the committed value out.
 Here we would like to provide a proof showing that for a given commited values such (cm1, cm2)
we know a  such m such that pedersen(m)= (cm1, cm2)
Here we would like to prove that */

template PedersonHelper() {
    signal  input m; // signal input message;

    signal output cm[2]; //signal output commited values

    component pederson = Pedersen(1);
    pederson.in[0] <== m;

    cm[0] <== pederson.out[0];
    cm[1] <== pederson.out[1];
        log("commitment:  ", cm[0],cm[1]);


}

component main = PedersonHelper();

