//60sCounter
module counter(rst,clk,ledTen,ledDigit,ledVolumn);
///////defination
input clk,rst;
output [8:0]ledTen;
output [8:0]ledDigit;
output [7:0]ledVolumn;
reg [8:0]romDigit[9:0];
reg  [6:0]romVolumn[5:0];
reg clkNew=0;
reg [21:0]cntClk=0;
reg [3:0]cntDigit=9;
reg [2:0]cntTen=5;
parameter clkDivision=1>>22;
initial begin
	romDigit[0]=9'b111111000;
	romDigit[1]=9'b011000000;
	romDigit[2]=9'b110110100;
	romDigit[3]=9'b111100100;
	romDigit[4]=9'b011001100;
	romDigit[5]=9'b101101100;
	romDigit[6]=9'b101111100;
	romDigit[7]=9'b111000000;
	romDigit[8]=9'b111111100;
	romDigit[9]=9'b111101100;
	romVolumn[0]=7'b1111110;
	romVolumn[1]=7'b1111100;
	romVolumn[2]=7'b1111000;
	romVolumn[3]=7'b1110000;
	romVolumn[4]=7'b1100000;
	romVolumn[5]=7'b1000000;
end
///////operation
//clock division
always@(negedge clk or negedge rst) begin
	if(rst==0) cntClk=0;
	else cntClk=cntClk+1;
	clkNew=cntClk>clkDivision>>1?1:0;
end
always@(negedge clkNew or negedge rst)begin
	if(rst==0)begin cntDigit=9;cntTen=5;end
	else begin
	if(cntDigit==0) cntDigit=9;
	else cntDigit=cntDigit-1;
	if(cntDigit==9)
		if(cntTen==0)cntTen=5;
		else  cntTen=cntTen-1;
	end
end
//assign
assign ledDigit=romDigit[cntDigit];
assign ledTen=romDigit[cntTen];
assign ledVolumn[6:0]=romVolumn[cntTen];
assign ledVolumn[7]=clkNew;
endmodule
