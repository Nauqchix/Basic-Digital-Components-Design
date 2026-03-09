module FULL_ADDER_ARCH_MODEL(S, CO, A, B, CI);
  output S, CO;
  input A, B, CI;
  wire sum_h1, ca_h1, ca_h2;

  //TBD
  HALF_ADDER h1 (.Y(sum_h1), .C(ca_h1), .A(A), .B(B));
  HALF_ADDER h2 (.Y(S), .C(ca_h2), .A(sum_h1), .B(CI));
  or(CO, ca_h1, ca_h2);
endmodule


module HALF_ADDER(Y, C, A, B);  
  output Y, C;
  input A, B;

  //TBD
  xor (Y, A, B);
  and (C, A, B);
  
endmodule