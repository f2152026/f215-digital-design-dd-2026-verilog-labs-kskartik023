module and_df #(parameter integer DELAY = 3) (
  input a,
  input b,
  output y
);
  assign #DELAY y = a & b;
endmodule
