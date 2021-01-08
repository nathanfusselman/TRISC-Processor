module Adder_Subtractor(R3, R2, R1, R0, C, V, A3, A2, A1, A0, B3, B2, B1, B0, Op);
   output R3,R2,R1,R0;   // The 4-bit sum/difference..
	wire Cout;
	output C;
   output V;   // The 1-bit overflow status.
   input A3,A2,A1,A0;   // The 4-bit augend/minuend.
   input B3,B2,B1,B0;   // The 4-bit addend/subtrahend.
   input Op;  // The operation: 0 => Add, 1=>Subtract.
   
   wire 	C0; // The carry out bit of fa0, the carry in bit of fa1.
   wire 	C1; // The carry out bit of fa1, the carry in bit of fa2.
   wire 	C2; // The carry out bit of fa2, the carry in bit of fa3.
   wire 	C3; // The carry out bit of fa2, used to generate final carry/borrrow.
   
   wire 	S0; // The xor'd result of B[0] and Op
   wire 	S1; // The xor'd result of B[1] and Op
   wire 	S2; // The xor'd result of B[2] and Op
   wire 	S3; // The xor'd result of B[3] and Op


	   
   xor(S0, B0, Op);
   xor(S1, B1, Op);
   xor(S2, B2, Op);
   xor(S3, B3, Op);
   xor(Cout, C3, Op);     // Carry = C3 for addition, Carry = not(C3) for subtraction.
   xor(V, C3, C2);     // If the two most significant carry output bits differ, then we have an overflow.
	
	xor(C, Op, Cout);
	
   
   full_adder fa0(R0, C0, A0, S0, Op);    // Least significant bit.
   full_adder fa1(R1, C1, A1, S1, C0);
   full_adder fa2(R2, C2, A2, S2, C1);
   full_adder fa3(R3, C3, A3, S3, C2);    // Most significant bit.
endmodule // ripple_carry_adder_subtractor


module full_adder(S, Cout, A, B, Cin);
   output S;
   output Cout;
   input  A;
   input  B;
   input  Cin;
   
   wire   w1;
   wire   w2;
   wire   w3;
   wire   w4;
   
   xor(w1, A, B);
   xor(S, Cin, w1);
   and(w2, A, B);   
   and(w3, A, Cin);
   and(w4, B, Cin);   
   or(Cout, w2, w3, w4);
endmodule
