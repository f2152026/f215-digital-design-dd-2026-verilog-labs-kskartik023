module tb;
  reg t_i0, t_i1, t_s;
  wire t_y;
  integer n;
  integer errors;
  string vcd_file;

  DUT U_DUT (
    .I0(t_i0),
    .I1(t_i1),
    .S(t_s),
    .Y(t_y)
  );

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    errors = 0;
    for (n = 0; n < 8; n = n + 1) begin
      {t_i0, t_i1, t_s} = n[2:0];
      #5;
      if (t_y !== (t_s ? t_i1 : t_i0)) begin
        $display("FAIL: I0=%b I1=%b S=%b Y=%b", t_i0, t_i1, t_s, t_y);
        errors = errors + 1;
      end
    end
    $display("MUX: %0d/8 passed", 8 - errors);
    if (errors != 0) $fatal(1, "MUX failures");
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);
endmodule
