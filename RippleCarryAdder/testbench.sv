module RC_ADD_SUB_32_TB;
  //Inputs
  reg [31:0] A;
  reg [31:0] B;
  reg SnA;
  
  //Output of design described in architecture model
  wire CO_ARCH;
  wire [31:0] Y_ARCH;
  
  //Output of design described in behaviour model
  wire CO_BEH;
  wire [31:0] Y_BEH;
  
  wire two_model_out_equal;
  
  assign two_model_out_equal = (CO_ARCH == CO_BEH) & (Y_ARCH == Y_BEH);
  
  RC_ADD_SUB_32_ARCH_MODEL rc_add_sub_arch_inst(.Y(Y_ARCH), .CO(CO_ARCH), .A(A), .B(B), .SnA(SnA));
  
  RC_ADD_SUB_32_BEH_MODEL  rc_add_sub_beh_inst (.Y(Y_BEH), .CO(CO_BEH), .A(A), .B(B), .SnA(SnA));
  
  initial begin
    A=10; B=20; SnA=1'b0; // Y = 10 + 20 = 30
    #1;
    #1 A=10; B=20; SnA=1'b1; // Y = 10 - 20 = -10
    #1;
    #1 A=15; B=12; SnA=1'b1; // Y = 15 - 12 = 3
    #1;
    #1 A=0; B=4; SnA=1'b0; // Y = 0 + 4 = 4
    #1;
    #1 A=32'h80001234; B=32'h80004321; SnA=1'b0;
    #1;
    #1 
    $stop;
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(A or B or SnA) begin
    assert (two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
endmodule