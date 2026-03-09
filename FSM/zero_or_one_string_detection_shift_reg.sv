module zero_or_one_string_detection_shift_reg (
  input clk, rst_n,
  input in,
  output out  
);
  
  reg [3:0] shift_reg;
  
  always @(posedge clk or negedge rst_n)
    if (~rst_n)
      shift_reg <= 4'b1010;
    else
      shift_reg <= {shift_reg[2:0], in};
  
  assign out = (shift_reg == 4'b0000) | (shift_reg == 4'b1111);
  
endmodule