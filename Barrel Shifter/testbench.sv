module BARREL_SHIFTER16_TB;
  //Inputs
  reg [15:0] D;
  reg [3:0] S;
  reg LnR;
  
  //Output of design described in architecture model
  wire [15:0] Y_ARCH;
  
  //Output of design described in behaviour model
  wire [15:0] Y_BEH;
  
  wire two_model_out_equal;
  
  assign two_model_out_equal = (Y_ARCH == Y_BEH);


  integer i;

  BARREL_SHIFTER16_ARCH_MODEL barrel_shift_arch_inst(.Y(Y_ARCH), .D(D), .S(S), .LnR(LnR));
  
  BARREL_SHIFTER16_BEH_MODEL  barrel_shift_beh_inst (.Y(Y_BEH), .D(D), .S(S), .LnR(LnR));

  initial begin
    D=32'ha5a5;
    S=4'h00;
    LnR=1'b1; // left shift

    for(i=0; i<16; i=i+1) begin
      #5 
      S=i; 
    end 

    #5 LnR=1'b0; // right shift

    for(i=0; i<16; i=i+1) begin
      #5 
      S=i; 
    end 

    $stop;
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(D or S or LnR) begin
//     assert (two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule