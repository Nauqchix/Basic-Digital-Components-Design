module RF_TB;
  // Storage list for register addresses and data
  reg [4:0] ADDR_W;
  reg [4:0] ADDR_R1;
  reg [4:0] ADDR_R2;
  // Reset, Read, Write control signals
  reg READ, WRITE, RST, CLK;
  // Data register to hold written data
  reg [31:0] DATA_REG;
  
  // Wire lists for clock and register outputs
  //Output of design described in architecture model
  wire [31:0] DATA_R1_ARCH;
  wire [31:0] DATA_R2_ARCH;
  
  //Output of design described in behaviour model
  wire [31:0] DATA_R1_BEH;
  wire [31:0] DATA_R2_BEH;
  
  wire two_model_out_equal;
  reg check_enable;
  
  integer i;
  
  assign two_model_out_equal = (DATA_R1_ARCH == DATA_R1_BEH) | (DATA_R2_ARCH == DATA_R2_BEH);
  
  // Register file instance
  REGISTER_FILE_32x32_ARCH_MODEL ref_32x32_arch_inst(
    .DATA_R1(DATA_R1_ARCH), .DATA_R2(DATA_R2_ARCH), 
      .ADDR_R1(ADDR_R1), .ADDR_R2(ADDR_R2), 
      .DATA_W(DATA_REG), .ADDR_W(ADDR_W), 
      .READ(READ), .WRITE(WRITE), .CLK(CLK), .RST(RST)
  );
  
  REGISTER_FILE_32x32_BEH_MODEL ref_32x32_beh_inst(
    .DATA_R1(DATA_R1_BEH), .DATA_R2(DATA_R2_BEH), 
      .ADDR_R1(ADDR_R1), .ADDR_R2(ADDR_R2), 
      .DATA_W(DATA_REG), .ADDR_W(ADDR_W), 
      .READ(READ), .WRITE(WRITE), .CLK(CLK), .RST(RST)
  );
  
  initial begin
    CLK = 1'b1;  // Initialize the clock to 1 (high)
  end

  // Always block to toggle the clock signal with the specified period
  always begin
    #5 CLK = ~CLK;  // Toggle clock every SYS_CLK_HALF_PERIOD time units
  end
  
  initial begin
    check_enable = 0;
    RST = 1'b1;
    READ = 1'b0;
    WRITE = 1'b0;
    DATA_REG = {32{1'b0}};
    ADDR_R1 = {5{1'b0}};
    ADDR_R2 = {5{1'b0}};

    // Start the operation: Apply reset
    #10 RST = 1'b0; 
    #10 RST = 1'b1; check_enable = 0;
  
    // Write cycle: Write data to each register
    for (i = 0; i < 32; i = i + 1) begin
        #10 DATA_REG = i; 
        READ = 1'b0; 
        WRITE = 1'b1; 
        ADDR_W = i;
    end
  
    // No-op for a while after writing
    #10;
    #5 READ = 1'b0; WRITE = 1'b0;
  
    // Test of write data by reading it back
    for (i = 0; i < 32; i = i + 1) begin
        #5 READ = 1'b1; WRITE = 1'b0; ADDR_R1 = i; ADDR_R2 = i; 
        #5; check_enable = 1;
    end
  
    // No-op after tests
    #5 READ = 1'b0; WRITE = 1'b0; check_enable = 0;
  
    // Output test results to console
    #10 
  
    $stop;  // End simulation
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(ADDR_W or ADDR_R1 or ADDR_R2 or READ or WRITE or RST or CLK or DATA_REG) begin
    assert (~check_enable | two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule