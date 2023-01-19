module TopModule(
	//////////// CLOCK //////////
	input 		          		CLK1,
	input 		          		CLK2,
	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,
	//////////// Push Button //////////
	input 		     [1:0]		BTN,
	//////////// LED //////////
	output		     [9:0]		LED,
	//////////// SW //////////
	input 		     [9:0]		SW

	);
	wire w_we;
	wire w_btn0;
	wire [3:0] rdata;
	m_chattering u0(CLK1,BTN[0],w_btn0);
	assign w_we=~w_btn0;
	
	m_ram u1(SW[9:6],SW[3:0],w_we,rdata);
	
	assign LED=SW;
	m_seven_segment s0(rdata,HEX0); // Shows value memorized in RAM
	m_seven_segment s1(SW[3:0],HEX1); // Shows value to be written into RAM
	m_seven_segment s2(SW[7:4],HEX2); // Shows current address (1st digit)
	m_seven_segment s3(SW[9:8],HEX3); // Shows current address (2nd digit)
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
