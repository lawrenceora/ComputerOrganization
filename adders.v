module ripplecarryadder(a, b, cin, s, cout);
    input [7:4] a;
    input [3:0] b;
    input cin;
    output [3:0]s;
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
