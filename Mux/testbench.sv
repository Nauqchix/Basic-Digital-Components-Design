module MUX32_16x1_TB;
  //Inputs
  reg [31:0] I [0:15];
  reg [3:0]  S;
  
  //Output of design described in architecture model
  wire [31:0] Y_ARCH;
  
  //Output of design described in behaviour model
  wire [31:0] Y_BEH;
   
  wire two_model_out_equal;
  
  integer i;
  
  assign two_model_out_equal = (Y_ARCH == Y_BEH);

  MUX32_16x1_ARCH_MODEL mux32_16x1_arch_inst (.Y(Y_ARCH),  .I0(I[0]),   .I1(I[1]),   .I2(I[2]),   .I3(I[3]),
		                         .I4(I[4]),   .I5(I[5]),   .I6(I[6]),   .I7(I[7]),
		                         .I8(I[8]),   .I9(I[9]),   .I10(I[10]), .I11(I[11]),
		                         .I12(I[12]), .I13(I[13]), .I14(I[14]), .I15(I[15]),
                                 .S(S));
  MUX32_16x1_BEH_MODEL mux32_16x1_beh_inst  (.Y(Y_BEH),  .I0(I[0]),   .I1(I[1]),   .I2(I[2]),   .I3(I[3]),
		                         .I4(I[4]),   .I5(I[5]),   .I6(I[6]),   .I7(I[7]),
		                         .I8(I[8]),   .I9(I[9]),   .I10(I[10]), .I11(I[11]),
		                         .I12(I[12]), .I13(I[13]), .I14(I[14]), .I15(I[15]),
                                 .S(S));

  initial begin
    for(i=0;i<16;i=i+1) begin
	  I[i]=i;
      S = 0;
    end

    for(i=0;i<16;i=i+1) begin
      #10    S = i; 
    end

    #10;
    $stop;
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(I or S) begin
    assert (two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule