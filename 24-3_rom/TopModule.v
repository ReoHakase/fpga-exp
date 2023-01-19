`include "constants.h"

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
	
	
	// FPGA提供の50[MHz]クロックから分周されるクロックの定義
	wire clock_1hz; // 時計のインクリメント用の1[Hz]のクロック
	m_prescale(CLK1, `CLOCK_SCALER_WIDTH'd50000000, clock_1hz);
	
	reg [3:0] cnt;
	
	wire variant;
	m_chattering_filter u10(CLK1, SW[0], variant);
	
	always @(posedge clock_1hz) begin
		cnt=cnt+1;
	end
	
	assign LED={variant, 5'h0,cnt};
	
	m_rom u1(variant, cnt+5,HEX0);
	m_rom u2(variant, cnt+4,HEX1);
	m_rom u3(variant, cnt+3,HEX2);
	m_rom u4(variant, cnt+2,HEX3);
	m_rom u5(variant, cnt+1,HEX4);
	m_rom u6(variant, cnt,HEX5);
	
endmodule
