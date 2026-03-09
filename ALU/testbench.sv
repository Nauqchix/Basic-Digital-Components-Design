module ALU_TB;
  //Inputs
  reg [31:0] OP1; // operand 1
  reg [31:0] OP2; // operand 2
  reg [5:0] OPRN; // operation code
  
  //Output of design described in architecture model
  wire [31:0] OUT_ARCH; // result of the operation.
  wire ZERO_ARCH;
  
  //Output of design described in behaviour model
  wire [31:0] OUT_BEH; // result of the operation.
  wire ZERO_BEH;
  
  wire two_model_out_equal;
  
  assign two_model_out_equal = (OUT_ARCH == OUT_BEH) & (ZERO_ARCH == ZERO_BEH);
  
  
  // Testcases
  integer oprnd_idx, oprn_idx;
  integer NumSet01[0:7];
  integer NumSet02[0:7];
  integer OpCode[0:8];
  
  ALU_ARCH_MODEL	alu_arch_inst(.OUT(OUT_ARCH), .ZERO(ZERO_ARCH), .OP1(OP1), .OP2(OP2), .OPRN(OPRN));
  
  ALU_BEH_MODEL     alu_beh_inst(.OUT(OUT_BEH), .ZERO(ZERO_BEH), .OP1(OP1), .OP2(OP2), .OPRN(OPRN));
  
  initial begin
    // Initialize number sets
    NumSet01[0] = 10;  NumSet01[1] = -15; NumSet01[2] =  25; NumSet01[3] = -30; NumSet01[4] = 0; NumSet01[5] = -15; NumSet01[6] = 23; NumSet01[7] =  0;
    NumSet02[0] = 10;  NumSet02[1] =  15; NumSet02[2] = -25; NumSet02[3] = -30; NumSet02[4] = 0; NumSet02[5] =  42; NumSet02[6] =  0; NumSet02[7] = 70;
    
    // Set of operation
    OpCode[0] = 1; // add 
    OpCode[1] = 2; // sub 
    OpCode[2] = 3; // mult
    OpCode[3] = 4; // shiftR
    OpCode[4] = 5; // shiftL
    OpCode[5] = 6; // and
    OpCode[6] = 7; // or
    OpCode[7] = 8; // nor
    OpCode[8] = 9; // slt
    
    // Loop through operands and operation
    for(oprnd_idx=0; oprnd_idx<8; oprnd_idx=oprnd_idx+1) begin
      for(oprn_idx=0; oprn_idx<9; oprn_idx=oprn_idx+1) begin
         OP1=NumSet01[oprnd_idx]; OP2=NumSet02[oprnd_idx]; OPRN=OpCode[oprn_idx];
         #2 ;
         case(OPRN)
           1: $write("+");
           2: $write("-");
           3: $write("*");
           4: $write(">>");
           5: $write("<<");
           6: $write("&");
           7: $write("|");
           8: $write("|~");
           9: $write("slt");
         endcase
       end
    end
    
    #1
    $stop;
  
  end
  
  //Whenever A or B or CI change, test will fail if corresponding outputs of designs in both models are not identical
  always @(OP1 or OP2 or OPRN) begin
    assert (two_model_out_equal) else $display ("Test Failed");
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end

endmodule