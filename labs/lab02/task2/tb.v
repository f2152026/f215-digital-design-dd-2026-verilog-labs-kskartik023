module tb;
  reg [2:0] t_sel;
  wire [7:0] t_dout;
  reg [7:0] expected;
  integer i;
  integer errors;
  string vcd_file;

  lut #(.WIDTH(8), .DEPTH(8)) U1 (
    .sel(t_sel),
    .dout(t_dout)
  );

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    errors = 0;
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i[2:0];
      expected = i * i;
      #1;
      if (t_dout !== expected) begin
        $display("FAIL: sel=%0d dout=%0d expected=%0d", t_sel, t_dout, expected);
        errors = errors + 1;
      end
    end
    $display("ROM: %0d/8 passed", 8 - errors);
    if (errors != 0) $fatal(1, "ROM failures");
    $finish;
  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout);
endmodule
