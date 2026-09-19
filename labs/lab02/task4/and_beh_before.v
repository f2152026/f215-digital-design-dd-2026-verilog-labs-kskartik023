module and_beh_before #(parameter integer DELAY = 3) (
  input a,
  input b,
  output reg y
);
  always @(*) begin
    #DELAY y = a & b;
  end
endmodule
