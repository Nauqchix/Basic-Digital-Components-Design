module REGISTER_FILE_32x32_BEH_MODEL(
  // Outputs
  output reg [31:0] DATA_R1, 
  output reg [31:0] DATA_R2,
  // Inputs
  input [31:0] DATA_W,
  input [4:0] ADDR_R1, ADDR_R2, ADDR_W,
  input READ, WRITE, CLK, RST
);
  
  reg [31:0] REG32_Q [0:31];
  
  //TBD
  integer i;
  always @(posedge CLK or negedge RST) begin
    if (~RST) begin
      for (i = 0; i < 32; i = i + 1) 
        REG32_Q[i] <= 32'd0;
    end 
    else if (WRITE) begin
      REG32_Q[ADDR_W] <= DATA_W;
    end
  end

  always @(*) begin
    if (READ) begin
      DATA_R1 = REG32_Q[ADDR_R1];
      DATA_R2 = REG32_Q[ADDR_R2];
    end
    else begin
      DATA_R1 = 32'bz;   
      DATA_R2 = 32'bz;
    end
  end
    
  
endmodule