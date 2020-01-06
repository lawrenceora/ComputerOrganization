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