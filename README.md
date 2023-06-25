# Privacy-Preserving-in-Blockchain

This repo is dedicated to implementing a simplified version of the Zcash protocol. More precisely, we are interested in the spend(sprout) protocol and how zkps were used. To do this, just start with a few basic circuits to defuse the development flow, and become more familiar with the Circom language. 
## Pre-requirements: 
Install snarkjs, circom, and circomlib

## Development flow:
1- Develop  circuits in circom 

2- Compile circom cubicEq.circom to get r1cs and witness generator as follows:
 circom  "circom file" --r1cs --wasm -o ../build/...
         --r1cs       outputs the constraints in r1cs format in binary format
         --wasm       Compiles the circuit to wasm

In this case, we create an R1CS  file, along with a folder with the files generate_witness.js, cubicEq.wasm and witness_calculator.j. The R1CS format is used to represent all the wires in the circuit, and so that they can be checked for the proof — this is known as a Quadratic Arithmetic Program (QAP).

3- Computing our witness to create the actual proofs.
We need to create a file named input.json containing the inputs of the circuit written in the standard json format.
node generate_witness.js poseidonWitness.wasm input.json witness.wtns

4- Generate Trusted setup (CrS) including proof key and verification key.
We are going to use the Groth16 zk-SNARK protocol. To use this protocol, you will need to generate a trusted setup. Groth16 requires a per circuit trusted setup. In more detail, the trusted setup consists of 2 parts:

Phase 1 called the powers of tau, which is independent of the circuit.
The phase 2, which depends on the circuit.

<!-- The phase 2 is circuit-specific. Execute the following command to start the generation of this phase: -->

<!-- snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v

Next, we generate a .zkey file that will contain the proving and verification keys together with all phase 2 contributions. Execute the following command to start a new zkey:

Powers of Tau
First, we start a new "powers of tau" ceremony:

snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
Then, we contribute to the ceremony:

snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v -->
<!-- Now, we have the contributions to the powers of tau in the file pot12_0001.ptau and we can proceed with the Phase 2.
snarkjs groth16 setup cubicEq.r1cs pot12_final.ptau cubicEq_0000.zkey
Contribute to the phase 2 of the ceremony:

snarkjs zkey contribute cubicEq_0000.zkey cubicEq_0001.zkey --name="1st Contributor Name" -v
Export the verification key:

snarkjs zkey export verificationkey cubicEq_0001.zkey verification_key.json -->

5- Generate proof: takes circuit in c1rs format, proofing key and witness, and then creates a proof 

snarkjs groth16 prove cubicEq_0001.zkey witness.wtns proof.json public1.json

6- verification: takes circuit in r1cs format, proof and public inputs, and verification key and outputs the verification result. 

7- Also it is possible to create a smart contract verifier.sol and deploy it on the blockchain. Then we can send the proof and see the results.





