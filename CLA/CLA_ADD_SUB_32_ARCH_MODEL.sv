module CLA_ADD_SUB_32_ARCH_MODEL (Y, CO, A, B, SnA);
  output [31:0] Y;
  output CO;
    
  // Input list
  input [31:0] A;
  input [31:0] B;
  input SnA;
  
  //TBD
  wire [31:0] B_not;
  genvar x;
  generate 
    for (x = 0; x < 32; x++) begin: B_change_loop
      xor (B_not[x], B[x], SnA);
    end
  endgenerate
  
  wire [15:0] Y_1, Y_2;
  wire CO_1, CO_2;

  wire PG_1, GG_1, PG_2, GG_2;

  CLA_16_bit_adder inst_1 (.Y(Y_1), .CO (CO_1), .PG(PG_1), .GG(GG_1), .A(A[15:0]), .B(B_not[15:0]), .CI(SnA));
  
  wire C16;
  or (C16, GG_1, (PG_1 & SnA));

  CLA_16_bit_adder inst_2 (.Y(Y_2), .CO(CO_2), .PG(PG_2), .GG(GG_2), .A(A[31:16]), .B(B_not[31:16]), .CI(C16));

  buf SnA_m1[15:0] (Y[15:0],  Y_1);
  buf SnA_m2[15:0] (Y[31:16], Y_2);
  buf (CO, CO_2);

endmodule


module CLA_16_bit_adder (Y, CO, PG, GG, A, B, CI);
  output [15:0] Y;
  output CO;
  output PG, GG;
    
  // Input list
  input [15:0] A;
  input [15:0] B;
  input CI;

  //TBD
  wire [3:0] PG_line, GG_line;
  wire [4:0] c_2;
  buf (c_2[0], CI);
  CLA_4_bit_adder model_1 (.Y(Y[3:0]), .CO(), .PG(PG_line[0]), .GG(GG_line[0]), .A(A[3:0]), .B(B[3:0]), .CI(c_2[0]));
  CLA_4_bit_adder model_2 (.Y(Y[7:4]), .CO(), .PG(PG_line[1]), .GG(GG_line[1]), .A(A[7:4]), .B(B[7:4]), .CI(c_2[1]));
  CLA_4_bit_adder model_3 (.Y(Y[11:8]), .CO(), .PG(PG_line[2]), .GG(GG_line[2]), .A(A[11:8]), .B(B[11:8]), .CI(c_2[2]));
  CLA_4_bit_adder model_4 (.Y(Y[15:12]), .CO(), .PG(PG_line[3]), .GG(GG_line[3]), .A(A[15:12]), .B(B[15:12]), .CI(c_2[3]));
  
  CLA_4_bit inst_x (.CO(c_2), .PG(PG), .GG(GG), .P(PG_line), .G(GG_line), .CI(CI));
  buf (CO, c_2[4]);

endmodule


module CLA_4_bit_adder (Y, CO, PG, GG, A, B, CI);
  output [3:0] Y;
  output CO;
  output PG, GG;
    
  // Input list
  input [3:0] A;
  input [3:0] B;
  input CI;

  //TBD
  wire [3:0] P, G;
  wire [4:0] C;
  genvar i;
  generate 
    for(i = 0; i < 4; i++) begin: GP_loop
      and G_result (G[i], A[i], B[i]);
      xor P_result (P[i], A[i], B[i]);
    end
  endgenerate
  
  CLA_4_bit inst_1 (.CO(C), .PG(PG), .GG(GG), .P(P), .G(G), .CI(CI));
  
 xor S0_gate (Y[0], P[0], C[0]);  
 xor S1_gate (Y[1], P[1], C[1]);  
 xor S2_gate(Y[2], P[2], C[2]);  
 xor S3_gate (Y[3], P[3], C[3]);
 buf CO_gate (CO, C[4]); 
endmodule 


module CLA_4_bit (CO, PG, GG, P, G, CI);
  output [4:0] CO;
  output PG, GG;
    
  // Input list
  input [3:0] P;
  input [3:0] G;
  input CI;
  
  //TBD
  buf CLA_4_CI (CO[0], CI);
  wire p0_c0;
  and CO_0_ag ( p0_c0, P[0], CO[0]);
  or CO_0_og (CO[1], G[0], p0_c0);
  
  wire p1_c1, sub_line, post_line;
  and CO_1_ag ( sub_line, P[0], CO[0]);
  or CO_1_og (p1_c1, G[0], sub_line);
  and CO_1_ag_2 (post_line ,P[1], p1_c1);
  or CO_1_og_2 (CO[2], G[1], post_line);
  
  wire p2_c2, sub_line_1,  sub_line_2, post_line_1, post_line_1_e;
  and CO_2_ag ( sub_line_1, P[0], CO[0]);
  or CO_2_og (p2_c2, G[0], sub_line_1);
  and CO_2_ag_2 (sub_line_2 ,P[1], p2_c2);
  or CO_2_og_2 (post_line_1, G[1], sub_line_2);
  and CO_2_ag_3 (post_line_1_e, P[2], post_line_1);
  or CO_2_og_3 (CO[3], G[2], post_line_1_e);
  
  wire p3_c3, sub_line_3,  sub_line_4, sub_line_5, sub_line_6, post_line_2, post_line_2_e;
  and CO_3_ag ( sub_line_3, P[0], CO[0]);
  or CO_3_og (p3_c3, G[0], sub_line_3);
  and CO_3_ag_2 (sub_line_4 ,P[1], p3_c3);
  or CO_3_og_2 (sub_line_5, G[1], sub_line_4);
  and CO_3_ag_3 (sub_line_6, P[2], sub_line_5);
  or CO_3_og_3 (post_line_2, G[2], sub_line_6);
  and CO_3_ag_4 (post_line_2_e, P[3], post_line_2);
  or CO_3_og_4 (CO[4], G[3], post_line_2_e);
  
  wire p3p2, p1p0;
  and and_PG0 (p3p2, P[3], P[2]);
  and and_PG1 (p1p0, P[1], P[0]);
  and and_PG2 (PG, p3p2, p1p0);


  wire p3g2, p3p2_g1, p3p2p1, p3p2p1_g0;
  and and_GG0 (p3g2, P[3], G[2]);
  and and_GG1 (p3p2_g1, P[3], P[2], G[1]);
  and and_GG2 (p3p2p1, P[3], P[2], P[1]);
  and and_GG3 (p3p2p1_g0, p3p2p1, G[0]);
  or  or_GG   (GG, G[3], p3g2, p3p2_g1, p3p2p1_g0);

endmodule


module FULL_ADDER_CLA (S, P, G, A, B, CI);
  output S;
  output P, G;
  input A, B, CI;
    
  assign S = A ^ B ^ CI;
  assign P = A | B;
  assign G = A & B;
  
endmodule