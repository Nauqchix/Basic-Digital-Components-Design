module REG32_TB;
  //Input
  reg CLK, LOAD;
  reg [31:0] D;
  reg RESET;

  //Output of design described in architecture model
  wire [31:0] Q_ARCH;
  
  //Output of design described in behaviour model
  wire [31:0] Q_BEH;
  
  wire two_model_out_equal;
  reg check_enable;
  
  assign two_model_out_equal = (Q_ARCH == Q_BEH);

  REG32_ARCH_MODEL reg32_arch_inst (.Q(Q_ARCH), .CLK(CLK), .LOAD(LOAD), .D(D), .RESET(RESET));
  
  REG32_BEH_MODEL  reg32_beh_inst  (.Q(Q_BEH), .CLK(CLK), .LOAD(LOAD), .D(D), .RESET(RESET));
  
  initial begin
    CLK = 1'b1;  // Initialize the clock to 1 (high)
  end

  // Always block to toggle the clock signal with the specified period
  always begin
    #5 CLK = ~CLK;  // Toggle clock every SYS_CLK_HALF_PERIOD time units
  end
  
  initial begin
    RESET=1; D=32'ha5a5a5a5; LOAD=0; check_enable = 0;
    // Reset
    #1  D=32'ha5a5a5a5; LOAD=0; RESET=0;
    #1  check_enable = 1;
    // Hold
    #1  D=32'ha5a5a5a5; LOAD=0; RESET=1;
    #1;
    // Normal operation
    #7 D=32'ha5a5a5a5; LOAD=1; RESET=1;
    #5;
    #5 D=32'hffff0000; LOAD=1; RESET=1;
    #5;
    // Reset
    #1 D=32'h0000ffff; LOAD=1; RESET=0;
    #1;
    // Normal operation
    #9 D=32'h0000ffff; LOAD=1; RESET=1;
    #11;
    #10 D=32'h5a5a5a5a; LOAD=0; RESET=1;
    
    #10
    $stop;
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(CLK or LOAD or RESET or D) begin
    assert (~check_enable | two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule