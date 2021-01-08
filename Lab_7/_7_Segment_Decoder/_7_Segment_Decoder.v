module _7_Segment_Decoder (
	input w,x,y,z,
	output reg a0,b0,c0,d0,e0,f0,g0,a1,b1,c1,d1,e1,f1,g1);
	always @ (w,x,y,z) begin
		case ({w,x,y,z})
			4'b0000: {a0,b0,c0,d0,e0,f0,g0} = 7'b0000001; //0
			4'b0001: {a0,b0,c0,d0,e0,f0,g0} = 7'b1001111; //1
			4'b0010: {a0,b0,c0,d0,e0,f0,g0} = 7'b0010010; //2
			4'b0011: {a0,b0,c0,d0,e0,f0,g0} = 7'b0000110; //3
			4'b0100: {a0,b0,c0,d0,e0,f0,g0} = 7'b1001100; //4
			4'b0101: {a0,b0,c0,d0,e0,f0,g0} = 7'b0100100; //5
			4'b0110: {a0,b0,c0,d0,e0,f0,g0} = 7'b0100000; //6
			4'b0111: {a0,b0,c0,d0,e0,f0,g0} = 7'b0001111; //7
			4'b1000: {a0,b0,c0,d0,e0,f0,g0} = 7'b0000000; //8
			4'b1001: {a0,b0,c0,d0,e0,f0,g0} = 7'b0001111; //7
			4'b1010: {a0,b0,c0,d0,e0,f0,g0} = 7'b0100000; //6
			4'b1011: {a0,b0,c0,d0,e0,f0,g0} = 7'b0100100; //5
			4'b1100: {a0,b0,c0,d0,e0,f0,g0} = 7'b1001100; //4
			4'b1101: {a0,b0,c0,d0,e0,f0,g0} = 7'b0000110; //3
			4'b1110: {a0,b0,c0,d0,e0,f0,g0} = 7'b0010010; //2
			4'b1111: {a0,b0,c0,d0,e0,f0,g0} = 7'b1001111; //1
		endcase
		case (w)
			1'b0: {a1,b1,c1,d1,e1,f1,g1} = 7'b1111111; //BLANK
			1'b1: {a1,b1,c1,d1,e1,f1,g1} = 7'b1111110; //-
		endcase
	end
endmodule