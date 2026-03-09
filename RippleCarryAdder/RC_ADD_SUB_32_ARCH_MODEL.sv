module RC_ADD_SUB_32_ARCH_MODEL (Y, CO, A, B, SnA);
  output [31:0] Y;
  output CO;
    
  // Input list
  input [31:0] A;
  input [31:0] B;
  input SnA;
    
  //TBD
  wire [31:0] xo, org;
  genvar i;
  generate 
    for(i = 0; i < 32; i = i + 1) begin: xor32_bit
      xor xor_gate (xo[i], SnA, B[i]);
    end
  endgenerate   
  FULL_ADDER fa_32_inst_0 (.A(A[0]), .B(xo[0]), .CO(org[0]), .S(Y[0]), .CI(SnA));
  
  genvar u;
  generate 
    for(u = 1; u < 32; u = u + 1) begin: fa32_bit
      FULL_ADDER fa_32_inst (.A(A[u]), .B(xo[u]), .CO(org[u]), .S(Y[u]), .CI(org[u - 1]));
    end
  endgenerate      
  
   assign CO = org[31];

endmodule

module FULL_ADDER(S, CO, A, B, CI);
  output S, CO;
  input A, B, CI;

  // Internal signals
  wire sum1, c1, c2;


  HALF_ADDER HA1(sum1, c1, A, B);
  HALF_ADDER HA2(S, c2, sum1, CI);
  or (CO, c1, c2);  // Carry out calculation the ore i put can get for fianl carry out
endmodule

module HALF_ADDER(Y, C, A, B);  // Changed SUM → Y and COUT → C to match testbench
  output Y, C;
  input A, B;

  // Gate level modelng usig  
  xor (Y, A, B);   // SUM = A ⊕ B
  and (C, A, B);   // C = A & B
endmodule
