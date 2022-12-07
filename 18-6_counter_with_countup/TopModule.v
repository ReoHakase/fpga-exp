`include "constant.h"

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
	
	wire [3:0] digit1, digit2;
	
	wire digit1_countup;
	
	wire clock_1hz;
	m_prescale(CLK1, 24'd50000000, clock_1hz); // 50[MHz] / 50 000 000 = 1[Hz]より、クロックを分周する
	
	m_counter(clock_1hz, 1'b0, 6'd60, digit1, digit1_countup);
	m_counter(digit1_countup, 1'b0, 6'd60, digit2, 1'b0);
	
  // 左の２つの7セグメントにのみ２桁を表示する
	m_seven_segment(digit1, HEX0);
	m_seven_segment(digit2, HEX1);
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
