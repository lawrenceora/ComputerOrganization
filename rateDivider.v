module rateDivider(clk, reset_n, sel, out);
    input clk, reset_n;
    input [1:0] sel;
    output out;
    reg [27:0] maxcount, count;

    always @(sel)
    begin
        case(sel[1:0])
            2'b00: maxcount <= 1;
            2'b01: maxcount <= 28'd50000000; // 5*10^7
            2'b10: maxcount <= 28'd100000000; // 1*10^8
            2'b11: maxcount <= 28'd200000000; // 2*10^8
            default: maxcount <= 1;
        endcase
    end

    always @(posedge clk)
    begin
        if (reset_n == 1'b0)
            count <= 0;
        else if (count == 0)
            count <= maxcount;
        else
            count <= count - 1'b1;
    end

    assign out = ~|count[27:0];

endmodule