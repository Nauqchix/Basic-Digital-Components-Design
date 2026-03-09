module zero_or_one_string_detection_fsm (
  input clk, rst_n,
  input in,
  output out  
);
  
  //TBD
  localparam P_IDLE = 2'd0;
  localparam P_ZERO = 2'd1;
  localparam P_ONE = 2'd2;
  localparam P_NOTDEFINED = 2'd3;
  
  reg [1:0] current_state, next_state;
   always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
      current_state <= P_IDLE;
    else
      current_state <= next_state;
  end
  
  always@(in or current_state) begin
    case (current_state)
      P_IDLE: begin
        if (in == 1'b0)
          next_state = P_ZERO;
        else if (in == 1'b1)
          next_state = P_ONE;
        else
          next_state = P_IDLE;
      end
       P_ZERO: begin
        if (in == 1'b0)
          next_state = P_ZERO;
        else
          next_state = P_NOTDEFINED;
      end
      P_ONE: begin
        if (in == 1'b1)
          next_state = P_ONE;
        else
          next_state = P_NOTDEFINED;
      end
      P_NOTDEFINED: next_state = P_IDLE;
      default: next_state = P_IDLE;
    endcase
  end
  
  assign out = (current_state == P_ZERO || current_state == P_ONE);
      		  
endmodule