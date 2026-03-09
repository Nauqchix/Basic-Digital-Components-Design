module FULL_ADDER_TB;
  //Inputs
  reg A, B, CI;
  
  //Output of design described in architecture model
  wire S_ARCH, CO_ARCH;
  
  //Output of design described in behaviour model
  wire S_BEH, CO_BEH;
  
  wire two_model_out_equal;
  
  integer i;
  
  assign two_model_out_equal = (S_ARCH == S_BEH) & (CO_ARCH == CO_BEH);

  FULL_ADDER_ARCH_MODEL fa_arch_inst (.S(S_ARCH), .CO(CO_ARCH), .A(A), .B(B), .CI(CI));
  FULL_ADDER_BEH_MODEL  fa_beh_inst  (.S(S_BEH), .CO(CO_BEH), .A(A), .B(B), .CI(CI));

  initial begin
    A=0; B=0; CI=0;

    for(i=1; i<8; i=i+1) 
      begin
      #1 CI=i[2]; A=i[1]; B=i[0];
    end

    #1 
    $stop;
  end
  
  always @(A or B or CI) begin
    assert (two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule