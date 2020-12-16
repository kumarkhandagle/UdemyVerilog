`timescale 1ns / 1ps


module top(
    input [15:0] din,
    output reg [7:0] cathode_o,
    output reg [7:0] anode_o
    );

reg [3:0] temp_pe_out; /////////Priority Encoder Output

initial begin
temp_pe_out = 4'bzzzz;
end



always@(din) ///Making circuit sensitive to all inputs 
begin
casex(din)  ////Using Casex instead of case will synthesize to priority encoders
16'b1xxx_xxxx_xxxx_xxxx: temp_pe_out = 4'b1111;
16'b01xx_xxxx_xxxx_xxxx: temp_pe_out = 4'b1110;
16'b001xx_xxxx_xxxx_xxxx:temp_pe_out = 4'b1101;
16'b0001_xxxx_xxxx_xxxx: temp_pe_out = 4'b1100;
16'b0000_1xxx_xxxx_xxxx: temp_pe_out = 4'b1011;

16'b0000_01xxx_xxxx_xxxx:temp_pe_out = 4'b1010;
16'b0000_001x_xxxx_xxxx: temp_pe_out = 4'b1001;
16'b0000_0001_xxxx_xxxx: temp_pe_out = 4'b1000;
16'b0000_0000_1xxx_xxxx: temp_pe_out = 4'b0111;
16'b0000_0000_01xx_xxxx: temp_pe_out = 4'b0110;

16'b0000_0000_001x_xxxx: temp_pe_out = 4'b0101;
16'b0000_0000_0001_xxxx: temp_pe_out = 4'b0100;
16'b0000_0000_0000_1xxx: temp_pe_out = 4'b0011;
16'b0000_0000_0000_01xx: temp_pe_out = 4'b0010;
16'b0000_0000_0000_001x: temp_pe_out = 4'b0001;
16'b0000_0000_0000_0001: temp_pe_out = 4'b0000;
default: temp_pe_out = 4'bzzzz;
endcase
end  

///To enable any seven segment in Nexys 4 DDR Anode should be given Zero (Multiplexed 8 7-seg display)
///To turn on any segment of 7-segement display we should provide zero
///This code will vary according to the development board you are using
////////COnversion of Priority Encoder Logic to Seven Segment Display decoder
always@(temp_pe_out)
 begin
 case(temp_pe_out)
 4'b0000: begin
 anode_o = 8'b0111_1111; //Turn on only first 7-segment display
 cathode_o = 8'b0000_0011;  /// cathode pattern a b c d e f g dp //Displaay 0
 end
 
 4'b0001: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b1001_1111;  //to display 1 b and c should be zero rest should be 1
 end
 
 
 4'b0010: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0010_0101;  
 end
 
 4'b0011: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0000_1101; 
 end
 
 4'b0100: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b1001_1001; 
 end
 
 4'b0101: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0100_1001; 
 end
 
 ///////////////////////////////////////////
  4'b0110: begin
 anode_o = 8'b0111_1111; //Turn on only first 7-segment display
 cathode_o = 8'b0100_0001;  /// cathode pattern a b c d e f g dp //Displaay 0
 end
 
 4'b0111: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0001_1111;  
 end
 
 
 4'b1000: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0000_0001;  
 end
 
 4'b1001: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0000_1001; 
 end
 
 4'b1010: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0001_0001; 
 end
 
 4'b1011: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b1100_0001; 
 end
 
 ////////////////////////////////////////////
  4'b1100: begin
 anode_o = 8'b0111_1111; //Turn on only first 7-segment display
 cathode_o = 8'b0110_0001;  /// cathode pattern a b c d e f g dp //Displaay 0
 end
 
 4'b1101: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b1000_0101;  
 end
 
 
 4'b1110: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0010_0001;  
 end
 
 4'b1111: begin
 anode_o = 8'b0111_1111; 
 cathode_o = 8'b0111_0001; 
 end
 
 /////////////Will turn off seven segment display in a case of no matching state
 default :  begin
 anode_o = 8'b1111_1111; 
 cathode_o = 8'b1111_1111; 
 end
 
 endcase
 end   
endmodule
