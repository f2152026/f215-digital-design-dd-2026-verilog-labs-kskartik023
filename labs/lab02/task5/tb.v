module tb;
  reg [3:0] t_a, t_b;
  reg t_op;
  wire [3:0] t_result;
  reg [3:0] expected;
  integer a, b, operation;
  integer errors;
  string vcd_file;

  alu U1 (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    errors = 0;
    for (a = 0; a < 16; a = a + 1) begin
      for (b = 0; b < 16; b = b + 1) begin
        for (operation = 0; operation < 2; operation = operation + 1) begin
          t_a = a[3:0];
          t_b = b[3:0];
          t_op = operation[0];
          if (operation == 0)
            expected = a + b;
          else
            expected = a - b;
          #1;
          if (t_result !== expected) begin
            $display("FAIL: a=%0d b=%0d op=%0d result=%0d expected=%0d",
                     a, b, operation, t_result, expected);
            errors = errors + 1;
          end
        end
      end
    end
    $display("ALU: %0d/512 passed", 512 - errors);
    if (errors != 0) $fatal(1, "ALU failures");
    $finish;
  end
endmodule
