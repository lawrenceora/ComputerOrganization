module ALU(LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    input [7:0] SW; //SW[7:4] is A, SW[3:0] is B
    input [2:0] KEY; //function inputs (switch)
    output [7:0] LEDR; //ALUout
    output [6:0] HEX0; //Displays B in Hexadecimal
    output [6:0] HEX1; //always 0
    output [6:0] HEX2; //Displays A in Hexadecimal
    output [6:0] HEX3; //always 0
    output [6:0] HEX4; //displays ALUout[3:0]
    output [6:0] HEX5; //displays ALUout[7:4]

    reg [7:0] ALUout;

    wire[7:0] wire0; //A + 1 using the part II adder
    wire[7:0] wire1; //A + B using the part II adder
    wire[7:0] wire2; //A + B using verilog built-in "+"
    wire[7:0] wire3; //A OR B concatenated with A XOR B
    wire[7:0] wire4; //0 if A = 0 and B = 0, 1 otherwise
    wire[7:0] wire5; //A concatenated with B

    //function0
    ripplecarryadder f0(SW[7:4], 4'b0001, 1'b0, wire0[3:0], wire0[4]);
    assign wire0[7:5] = 3'b000;

    //function1
    ripplecarryadder f1(SW[7:4], SW[3:0], 1'b0, wire1[3:0], wire1[4]);
    assign wire1[7:5] = 3'b000;

    //function2
    assign wire2[4:0] = SW[7:4] + SW[3:0];
    assign wire2[7:5] = 3'b000;

    //function3
    or_xor f3(SW[7:4], SW[3:0], wire3[7:0]);

    //function4
    assign wire4[0] = |SW[7:4] || |SW[3:0]; //verify correct operator
    assign wire4[7:1] = 7'b0000000;

    //function5
    assign wire5[3:0] = SW[3:0];
    assign wire5[7:4] = SW[7:4];


    always@(*)
    begin
	case(KEY[2:0])
	    3'b000: ALUout = wire0;
	    3'b001: ALUout = wire1;
	    3'b010: ALUout = wire2;
	    3'b011: ALUout = wire3;
	    3'b100: ALUout = wire4;
	    3'b101: ALUout = wire5;
	    default: ALUout = 8'b0000000;
	endcase
    end

    seven h0(HEX0[6:0], SW[3:0]); //B
    seven h2(HEX2[6:0], SW[7:4]); //A
    seven h4(HEX4[6:0], ALUout[3:0]);
    seven h5(HEX5[6:0], ALUout[7:4]);
    assign HEX1[6:0] = 7'b1000000;
    assign HEX3[6:0] = 7'b1000000;
    assign LEDR[7:0] = ALUout[7:0];

endmodule


module seven(HEX, SW);
	input[3:0] SW;
	output[6:0] HEX;

	assign HEX[0] =  ~SW[3] & ~SW[2] & ~SW[1] &  SW[0] | //1
			 ~SW[3] &  SW[2] & ~SW[1] & ~SW[0] | //4
			  SW[3] & ~SW[2] &  SW[1] &  SW[0] | //B
			  SW[3] &  SW[2] & ~SW[1] &  SW[0] ; //D

	assign HEX[1] =  ~SW[3] &  SW[2] & ~SW[1] &  SW[0] | //5
			  SW[3] &  SW[2] &          ~SW[0] | //C, E
			  SW[3] &           SW[1] &  SW[0] | //B, F
			           SW[2] &  SW[1] & ~SW[0] ; //6, E

	assign HEX[2] =  ~SW[3] & ~SW[2] &  SW[1] & ~SW[0] | //2
			  SW[3] &  SW[2] &          ~SW[0] | //C, E
			  SW[3] &  SW[2] &  SW[1]          ; //E, F

	assign HEX[3] =  ~SW[3] &  SW[2] & ~SW[1] & ~SW[0] | //4
			  SW[3] & ~SW[2] &  SW[1] & ~SW[0] | //A
			          ~SW[2] & ~SW[1] &  SW[0] | //1,9
			           SW[2] &  SW[1] &  SW[0] ; //7,F

	assign HEX[4] =           ~SW[2] & ~SW[1] &  SW[0] | //1,9
			 ~SW[3] &  SW[2] & ~SW[1]          | //4,5
			 ~SW[3] &                    SW[0] ; //1,3,5,7

	assign HEX[5] =   SW[3] &  SW[2] & ~SW[1] &  SW[0] | //D
			 ~SW[3] & ~SW[2]          &  SW[0] | //1,3
			 ~SW[3] & ~SW[2] &  SW[1]          | //2,3
			 ~SW[3] &           SW[1] &  SW[0] ; //3,7

	assign HEX[6] =  ~SW[3] &  SW[2] &  SW[1] &  SW[0] | //7
			  SW[3] &  SW[2] & ~SW[1] & ~SW[0] | //C
			 ~SW[3] & ~SW[2]  & ~SW[1]         ; //1,0
endmodule

module or_xor(a, b, out);
    input[7:4] a;
    input[3:0] b;
    output[7:0] out;

    or(out[7], a[7], b[3]);
    or(out[6], a[6], b[2]);
    or(out[5], a[5], b[1]);
    or(out[4], a[4], b[0]);
    xor(out[3], a[7], b[3]);
    xor(out[2], a[6], b[2]);
    xor(out[1], a[5], b[1]);
    xor(out[0], a[4], b[0]);
endmodule

module ripplecarryadder(a, b, cin, s, cout);
    input [7:4] a;
    input [3:0] b;
    input cin;
    output [3:0] s;
    output cout;
    wire c1, c2, c3;

    fulladder FA1(a[4], b[0], cin, s[0], c1);
    fulladder FA2(a[5], b[1], c1, s[1], c2);
    fulladder FA3(a[6], b[2], c2, s[2], c3);
    fulladder FA4(a[7], b[3], c3, s[3], cout);
endmodule

module fulladder(a, b, ci, s, co);
    input a, b; //two bits to add
    input ci; //carry value
    output s; //sum output
    output co; //carry output
    wire a_xor_b;

    xor(a_xor_b, a, b);
    xor(s, a_xor_b, ci);
    mux m1(b, ci, a_xor_b, co);
endmodule

module mux(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;
endmodule
