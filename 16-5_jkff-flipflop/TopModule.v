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

	wire clk, j, k, q, reset, nq;
	
	assign j = SW[2];	//入力jはスイッチ2に対応	
	assign k = SW[1];	//入力kはスイッチ1に対応
	assign reset = SW[0];
	
	m_RSFF u1(~BTN[0],~BTN[1],clk,nq);	//プッシュボタンによるクロックの生成
	
	m_JKFF u2(clk,j,k,q,reset);						// JK-FF
	
	assign LED={6'h0, clk, j, k, q };		//LEDは下位3bitを使用
	
	assign HEX0=8'hff;	//7segは不使用
	assign HEX1=8'hff;
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
