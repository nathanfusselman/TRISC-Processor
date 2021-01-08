module FSM(
	input RESET, CLK, Z, N, V, C,
	input [10:0] ID,
	output reg [15:0] CONTROL);
	reg [5:0] state, nextstate;
	parameter START = 6'b000000, FETCH1 = 6'b000001, FETCH2 = 6'b000010, DECODE = 6'b000011,
				 LDA1 = 6'b000100, LDA2 = 6'b000101, LDA3 = 6'b000110,
				 STA1 = 6'b001000, STA2 = 6'b001001,
				 ADD1 = 6'b001100, ADD2 = 6'b001101, ADD3 = 6'b001110, ADD4 = 6'b001111,
				 SUB1 = 6'b010000, SUB2 = 6'b010001, SUB3 = 6'b010010, SUB4 = 6'b010011,
				 XOR1 = 6'b010100, XOR2 = 6'b010101, XOR3 = 6'b010110, XOR4 = 6'b010111,
				 INC1 = 6'b011000,
				 CLR1 = 6'b011100,
				 JMP1 = 6'b100000,
				 JPZ1 = 6'b100100,
				 JPN1 = 6'b101000;
	parameter C0 = 2 ** 0, C1 = 2 ** 1, C2 = 2 ** 2, C3 = 2 ** 3, C4 = 2 ** 4, C5 = 2 ** 5, C6 = 2 ** 6,
				 C7 = 2 ** 7, C8 = 2 ** 8, C9 = 2 ** 9, C10 = 2 ** 10, C11 = 2 ** 11, C12 = 2 ** 12,
				 C13 = 2 ** 13, C14 = 2 ** 14, C15 = 2 ** 15;
	parameter LDA = 2 ** 0, STA = 2 ** 1, ADD = 2 ** 2, SUB = 2 ** 3, XOR = 2 ** 4, INC = 2 ** 5,
				 CLR = 2 ** 6, JMP = 2 ** 7, JPZ = 2 ** 8, JPN = 2 ** 9, HLT = 2 ** 10;
	always @ (negedge RESET, negedge CLK)
	begin
		if (RESET == 0) state <= START; else state <= nextstate;
	end
	always @ (state)
	begin
		case (state)
		START: begin CONTROL = C0; nextstate <= FETCH1; end
		
		FETCH1: begin CONTROL = C4; nextstate <= FETCH2; end
		FETCH2: begin CONTROL = C4; nextstate <= DECODE; end
		
		DECODE: begin CONTROL = C2 | C7;
		if (ID == LDA) nextstate <= LDA1;
		if (ID == STA) nextstate <= STA1;
		if (ID == ADD) nextstate <= ADD1;
		if (ID == SUB) nextstate <= SUB1;
		if (ID == XOR) nextstate <= XOR1;
		if (ID == INC) nextstate <= INC1;
		if (ID == CLR) nextstate <= CLR1;
		if (ID == JMP) nextstate <= JMP1;
		if (ID == JPZ) nextstate <= JPZ1;
		if (ID == JPN) nextstate <= JPN1;
		if (ID == HLT) nextstate <= START;
		end
		
		LDA1: begin CONTROL = C3 | C4; nextstate <= LDA2; end
		LDA2: begin CONTROL = C3 | C4 | C10; nextstate <= LDA3; end
		LDA3: begin CONTROL = C10 | C11; nextstate <= FETCH1; end
		
		STA1: begin CONTROL = C3 | C4 | C5; nextstate <= STA2; end
		STA2: begin CONTROL = C3 | C4 | C5; nextstate <= FETCH1; end
		
		ADD1: begin CONTROL = C3 | C4; nextstate <= ADD2; end
		ADD2: begin CONTROL = C3 | C4; nextstate <= ADD3; end
		ADD3: begin CONTROL = C14 | C15; nextstate <= ADD4; end
		ADD4: begin CONTROL = C11; nextstate <= FETCH1; end
		
		SUB1: begin CONTROL = C3 | C4 | C13; nextstate <= SUB2; end
		SUB2: begin CONTROL = C3 | C4 | C13; nextstate <= SUB3; end
		SUB3: begin CONTROL = C12 | C14 | C15; nextstate <= SUB4; end
		SUB4: begin CONTROL = C11; nextstate <= FETCH1; end
		
		XOR1: begin CONTROL = C3 | C4 | C12 | C13; nextstate <= XOR2; end
		XOR2: begin CONTROL = C3 | C4 | C12 | C13; nextstate <= XOR3; end
		XOR3: begin CONTROL = C12 | C13 | C14 | C15; nextstate <= XOR4; end
		XOR4: begin CONTROL = C11; nextstate <= FETCH1; end
		
		INC1: begin CONTROL = C9; nextstate <= FETCH1; end
		
		CLR1: begin CONTROL = C8; nextstate <= FETCH1; end
		
		JMP1: begin CONTROL = C1; nextstate <= FETCH1; end
		
		JPZ1: begin if (Z) nextstate <= JMP1; else nextstate <= FETCH1; end
		
		JPN1: begin if (N) nextstate <= JMP1; else nextstate <= FETCH1; end
		endcase
	end
endmodule
