module ID(
	input [3:0] IR,
	output reg [10:0] ID);
	parameter LDA = 4'b0000, STA = 4'b0001, ADD = 4'b0010, SUB = 4'b0011, XOR = 4'b0100, INC = 4'b0110,
				 CLR = 4'b0111, JMP = 4'b1000, JPZ = 4'b1100, JPN = 4'b1001, HLT = 4'b1111;
	parameter _LDA = 2 ** 0, _STA = 2 ** 1, _ADD = 2 ** 2, _SUB = 2 ** 3, _XOR = 2 ** 4, _INC = 2 ** 5,
				 _CLR = 2 ** 6, _JMP = 2 ** 7, _JPZ = 2 ** 8, _JPN = 2 ** 9, _HLT = 2 ** 10;
	always @ (IR)
	begin
		case (IR)
			LDA: ID = _LDA;
			STA: ID = _STA;
			ADD: ID = _ADD;
			SUB: ID = _SUB;
			XOR: ID = _XOR;
			INC: ID = _INC;
			CLR: ID = _CLR;
			JMP: ID = _JMP;
			JPZ: ID = _JPZ;
			JPN: ID = _JPN;
			HLT: ID = _HLT;
			default: ID = 0;
		endcase
	end
endmodule
