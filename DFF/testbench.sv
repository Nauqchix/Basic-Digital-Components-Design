module D_FF_TB;
  //Inputs
  reg D, C;
  reg nP, nR;
  
  //Output of design described in architecture model
  wire Q_ARCH, Qbar_ARCH;
  
  //Output of design described in behaviour model
  wire Q_BEH, Qbar_BEH;
  
  wire two_model_out_equal;
  
  reg check_enable;
  
  assign two_model_out_equal = (Q_ARCH == Q_BEH);

  D_FF_ARCH_MODEL d_ff_arch_inst(.Q(Q_ARCH), .Qbar(Qbar_ARCH), .C(C), 
                           .D(D), .nP(nP), .nR(nR));
  
  D_FF_DATA_FLOW_MODEL  d_ff_dataflow_inst (.Q(Q_BEH), .Qbar(Qbar_BEH), .C(C), 
                           .D(D), .nP(nP), .nR(nR));

  initial begin
    C = 1'b1;  // Initialize the clock to 1 (high)
  end

  // Always block to toggle the clock signal with the specified period
  always begin
    #5 C = ~C;  // Toggle clock every SYS_CLK_HALF_PERIOD time units
  end
  
  initial begin
    nP=1; nR=1; D=0; check_enable = 0;
    
    // Preset
    #1  D=0; nP=0; nR=1;
    #1  check_enable = 1;
   
    // Hold
    #1  D=0; nP=1; nR=1;

    // Normal operation
    #10 D=1; nP=1; nR=1;
    #11 D=0; nP=1; nR=1;

    // Reset
    #6 D=1; nP=1; nR=0;

    // Normal operation
    #10 D=1; nP=1; nR=1;

    #15;
    $stop;
  end

  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(nP or nR or C or D) begin
    assert (~check_enable | two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule