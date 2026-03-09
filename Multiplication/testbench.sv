module MULT_TB;
  //Inputs
  reg [31:0] A;
  reg [31:0] B;
  
  //Output of design described in architecture model
  wire [31:0] HI_ARCH, LO_ARCH;
  
  //Output of design described in behaviour model
  wire [31:0] HI_BEH, LO_BEH;
  
  wire two_model_out_equal;
  
  assign two_model_out_equal = (HI_ARCH == HI_BEH) & (LO_ARCH == LO_BEH);
  
  MULT32_ARCH_MODEL mult32_arch_inst_0(.HI(HI_ARCH), .LO(LO_ARCH), .A(A), .B(B));
  
  MULT32_BEH_MODEL  mult32_beh_inst_0 (.HI(HI_BEH), .LO(LO_BEH), .A(A), .B(B));

  initial begin
    A=10; B=20;     	// Y = 10 * 20 = 200
    #1;
    #1 A=-3; B=-15;  	// Y =  3 * 15 = 45
    #1;
    #1 A=-16; B=7;  	// Y = 16 *  7 = -112
    #1;
    #1 A=10; B=-19; 	// Y = 10 * 19 = -190
    #1;
    #1 A=32'h70000000; B=32'h70000000; 
    #1;
    #1 A=32'h90000000; B=32'h70000000; 
    #1;
    #1 A=32'h70000000; B=32'h90000000; 
    #1;
    #1 A=32'h90000000; B=32'h90000000; 
    #1;
    #1 
    $stop;
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(A or B) begin
    assert (two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
endmodule