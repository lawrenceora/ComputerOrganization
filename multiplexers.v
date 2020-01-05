//SW[2:0] data inputs
//SW[9] select signal
//LEDR[0] output display

module mux7to1(in, sel, out);
    input [6:0]in;
    input [2:0]sel;
    output out;
    reg out;

    always@(*)
    begin
	case(sel[2:0])
	    3'b000: out = in[0];
	    3'b001: out = in[1];
	    3'b010: out = in[2];
	    3'b011: out = in[3];
	    3'b100: out = in[4];
	    3'b101: out = in[5];
	    3'b110: out = in[6];
	    default: out = 1'b0;
	endcase
    end 
endmodule


module mux4to1(LEDR, SW);
    input [9:0] SW;
    output [9:0] LEDR;
    wire Connection1, Connection2;

    mux2to1 u1( 	
        .x(SW[0]),
        .y(SW[1]),
        .s(SW[9]),
        .m(Connection1)
        );
		  
    mux2to1 u2(
	.x(SW[2]),
	.y(SW[3]),
	.s(SW[9]),
	.m(Connection2),
	);
			
     mux2to1 u3(
	.x(Connection1),
	.y(Connection2),
	.s(SW[8]),
	.m(LEDR[0])
	);		
endmodule


module mux2to1(x, y, s, m);
    input x; //selected when s is 0
    input y; //selected when s is 1
    input s; //select signal
    output m; //output
  
    assign m = s & y | ~s & x;
    // OR
    // assign m = s ? y : x;
endmodule