module Shifter(LoadVal, Load_n, ShiftRight, ASR, clk, reset_n, Q);
    input [7:0] LoadVal;
    input Load_n, ShiftRight, ASR, clk, reset_n;
    output [7:0] Q;

    ShifterBit s7(LoadVal[7], 1'b0, ~ASR,       Load_n, clk, reset_n, Q[7]);
    ShifterBit s6(LoadVal[6], Q[7], ShiftRight, Load_n, clk, reset_n, Q[6]);
    ShifterBit s5(LoadVal[5], Q[6], ShiftRight, Load_n, clk, reset_n, Q[5]);
    ShifterBit s4(LoadVal[4], Q[5], ShiftRight, Load_n, clk, reset_n, Q[4]);
    ShifterBit s3(LoadVal[3], Q[4], ShiftRight, Load_n, clk, reset_n, Q[3]);
    ShifterBit s2(LoadVal[2], Q[3], ShiftRight, Load_n, clk, reset_n, Q[2]);
    ShifterBit s1(LoadVal[1], Q[2], ShiftRight, Load_n, clk, reset_n, Q[1]);
    ShifterBit s0(LoadVal[0], Q[1], ShiftRight, Load_n, clk, reset_n, Q[0]);
endmodule


module ShifterBit(load_val, in, shift, load_n, clk, reset_n, out);
    input load_val, in, shift, load_n, clk, reset_n;
    output out;
    wire wire1, wire2;

    mux m1(out, in, shift, wire1);
    mux m2(load_val, wire1, load_n, wire2);
    register r1(wire2, clk, reset_n, out);
endmodule


module register(d, clock, reset_n, q);
    input d, clock, reset_n;
    output q;
    reg q;
    always @(posedge clock)
    begin
        if (reset_n == 1'b0)
            q <= 0;
        else
            q <= d;
    end
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
