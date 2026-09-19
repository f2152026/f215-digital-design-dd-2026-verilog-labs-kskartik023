module and_beh_intra #(parameter integer DELAY = 3) (
  input a,
  input b,
  output reg y
);
  always @(*) begin
    y = #DELAY a & b;
  end
endmodule
