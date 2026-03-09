module zero_or_one_string_detection_tb;
  // Inputs
  reg clk, rst_n;
  reg in;
  
  //Output of design described in architecture model
  wire out_0;
  
  //Output of design described in behaviour model
  wire out_1;
  
  wire two_model_out_equal;
  reg check_enable;
  
  assign two_model_out_equal = (out_0 == out_1);
  
  // Register file instance
  zero_or_one_string_detection_fsm zero_or_one_string_detection_fsm_inst (.clk(clk), .rst_n(rst_n), .in(in), .out(out_0));
  
  zero_or_one_string_detection_shift_reg zero_or_one_string_detection_shift_reg_inst (.clk(clk), .rst_n(rst_n), .in(in), .out(out_1));
  
  initial begin
    clk = 1'b1;  // Initialize the clock to 1 (high)
  end

  // Always block to toggle the clock signal with the specified period
  always begin
    #5 clk = ~clk;  // Toggle clock every SYS_CLK_HALF_PERIOD time units
  end
  
  initial begin
    check_enable = 0;
    rst_n = 1'b1; in = 0;
    
    #25;
    rst_n = 1'b0; #1; check_enable = 1;
    #9;
    rst_n = 1'b1;
    #10;
    in = 1;
    #20;
    in = 0;
    #40;
    in = 1;
    #60;
    in = 0;
    #20;
    in = 1;
    #50;
    in = 0;
    #50;
    in = 1; 
  
    $stop;  // End simulation
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(clk or rst_n or in) begin
    assert (~check_enable | two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule