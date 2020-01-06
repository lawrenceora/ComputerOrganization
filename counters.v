module fourbitcounter(d, clk, reset_n, par_load, enable, q);
    input [3:0] d;
    input clk, reset_n, par_load, enable;
    output reg [3:0] q;

    always @(posedge clk)
    begin
        if (reset_n == 1'b0)
             q <= 0;
        else if (par_load == 1'b1)
            q <= d;
        else if (enable == 1'b1)
            begin
                if (q == 4'b1111) //unnecessary if you want to count up to 2^n. But useful if you want to count up to below that.
		    q <= 0;
		else
		    q <= q + 1'b1;
	    end
    end
endmodule


module eightbitcounter(en, clk, clear_b, q);
    input en, clk, clear_b;
    output [7:0] q;
    
    Tflipflop t0(           en, clk, clear_b, q[0]);
    Tflipflop t1( q[0]   && en, clk, clear_b, q[1]);
    Tflipflop t2(&q[1:0] && en, clk, clear_b, q[2]);
    Tflipflop t3(&q[2:0] && en, clk, clear_b, q[3]);
    Tflipflop t4(&q[3:0] && en, clk, clear_b, q[4]);
    Tflipflop t5(&q[4:0] && en, clk, clear_b, q[5]);
    Tflipflop t6(&q[5:0] && en, clk, clear_b, q[6]);
    Tflipflop t7(&q[6:0] && en, clk, clear_b, q[7]);

endmodule


module Tflipflop(t, clock, clear_b, q);
    input t, clock, clear_b;
    output q;
    reg q;
    always @(posedge clock, negedge clear_b)
    begin
        if (clear_b == 1'b0)
            q <= 0;
        else if (t == 1'b1)
            q <= ~q;
    end
endmodule