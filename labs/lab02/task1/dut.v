module DUT (
  input I0,
  input I1,
  input S,
  output Y
);
  mux_df U1 (
    .I0(I0),
    .I1(I1),
    .S(S),
    .Y(Y)
  );
endmodule
