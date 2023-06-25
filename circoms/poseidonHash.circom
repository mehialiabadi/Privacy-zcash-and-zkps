
pragma circom 2.1.5;
include "../node_modules/circomlib/circuits/poseidon.circom";

//In this case, we want to prove that for a given y we know a preimages such x1,x2 that posideon(xx,x2)= y.
//Poseidon is a ZK-friendly Hashing algorithm. Here hash computtaions are done over BN254  Barreto-Naehrig (BN) curve with 254-bit prime.


template PoseidonHash() {
    signal input x1; // signal input1 message;
    signal input x2; // signal input2 message;  poseidon (x1, x2)=outHash

    signal output outHash;

    component poseidon = Poseidon(2);
    poseidon.inputs[0] <== x1;
        poseidon.inputs[1] <== x2;

    outHash <== poseidon.out;

    log("Hash value of inputs: ", outHash);


}

component main = PoseidonHash();

