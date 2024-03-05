module fixed_priority_arbiter_test;
  reg clk;
  reg rst_n;
  reg [3:0] REG;
  wire [3:0] GNT;

  fixed_priority_arbiter DUT(.clk(clk),.rst_n(rst_n),.REQ(REQ),.GNT(GNT));

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    rst_n = 0;
    REQ = 4'b0000;

    #5 rst_n = 1;

    @(negedge clk) REQ = 4'b1000;

    @(negedge clk) REQ = 4'b1010;

    @(negedge clk) REQ = 4'b0010;

    @(negedge clk) REQ = 4'b0110;

    @(negedge clk) REQ = 4'b1110;

    @(negedge clk) REQ = 4'b1111;

    @(negedge clk) REQ = 4'b0100;

    @(negedge clk) REQ = 4'b0010;

    #5 rst_n = 0;
    #100 $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule
