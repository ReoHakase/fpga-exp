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
	wire clk, res, wnq;
	wire [3:0] wq;
	
	m_rs_flipflop u1(~BTN[0], ~BTN[1], clk, wnq);	// ボタン信号からクロック信号を生成
	
	assign res = SW[0];			// リセット用のボタン信号
	
	m_counter(clk, res, wq);	// 4bitカウンタ
	
	assign LED={6'h0,wq};
	m_seven_segment(wq, HEX0);
	assign HEX1=8'hff;
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
