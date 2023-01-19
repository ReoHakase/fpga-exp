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
	input 		     [9:0]		SW,
	
	//////////// Matrix Key ///////////
	input            [3:0]     KEY_ROW,
	output           [3:0]     KEY_COL

	);
	wire clk;
	wire [3:0]  out;						//押下キー(4bit)
	wire [15:0] key;						//押下キー(16bit)
	wire pushed;							//打鍵検出
	reg  [19:0] rdata = 20'd0;						//記憶したデータ(4bit x 5)

	
	m_prescale(CLK1, clk);	//100Hz
	
	m_matrix_key(clk, SW[0], KEY_ROW, KEY_COL, key, tc);	//マトリックスキーの打鍵検出
	
	m_dec16to4(key, out, pushed);	// 押下キーを4bit出力
	
	always @(negedge pushed) begin	// 出力値を記憶
		// rdata <= out;
		rdata = {rdata, out};
	end
	
	m_mat7segment(out, pushed, HEX0);	//押下キーに応じた7セグ表示
	
	m_7segment(rdata[3:0], HEX1);				//記憶したデータに応じた７セグ表示 (1st digit, the most recent input)
	m_7segment(rdata[7:4], HEX2);				//記憶したデータに応じた７セグ表示 (2nd digit)
	m_7segment(rdata[11:8], HEX3);				//記憶したデータに応じた７セグ表示 (3rd digit)
	m_7segment(rdata[15:12], HEX4);				//記憶したデータに応じた７セグ表示 (4th digit)
	m_7segment(rdata[19:16], HEX5);				//記憶したデータに応じた７セグ表示 (5th digit)
	
	assign LED = {pushed, 5'd0,out};
	
endmodule
