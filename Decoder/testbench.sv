module DECODER_5x32_TB;
  //Inputs
  reg [4:0] I;
  
  //Output of design described in architecture model
  wire [31:0] D_ARCH;
  
  //Output of design described in behaviour model
  wire [31:0] D_BEH;
  
  wire two_model_out_equal;
  
  integer idx;
  
  assign two_model_out_equal = (D_ARCH == D_BEH);

  DECODER_5x32_ARCH_MODEL    decoder_5x32_arch_inst0(.D(D_ARCH),.I(I));
  
  DECODER_5x32_BEH_MODEL     decoder_5x32_beh_inst0(.D(D_BEH),.I(I));

  initial begin
    for (idx=0; idx<32; idx = idx + 1) begin
      I = idx;
      #10;
    end
    
    #10;
    $stop;
  end

  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(I) begin
    assert (two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule