module AND_XOR(A3,A2,A1,A0,B3,B2,B1,B0,R3,R2,R1,R0,Op);
	input A3,A2,A1,A0,B3,B2,B1,B0,Op;
	output R3,R2,R1,R0;
	wire AB3,_AB3,AB2,_AB2,AB1,_AB1,AB0,_AB0;
	
	and(AB0,A0,B0);
	and(AB1,A1,B1);
	and(AB2,A2,B2);
	and(AB3,A3,B3);
	
	xor(_AB0,A0,B0);
	xor(_AB1,A1,B1);
	xor(_AB2,A2,B2);
	xor(_AB3,A3,B3);
	
	assign R0 = (~Op & AB0) | (Op & _AB0);
	assign R1 = (~Op & AB1) | (Op & _AB1);
	assign R2 = (~Op & AB2) | (Op & _AB2);
	assign R3 = (~Op & AB3) | (Op & _AB3);
	
endmodule
