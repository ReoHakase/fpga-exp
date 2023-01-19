module m_matrix_key(
	input             clk, rst,	// クロック，リセット
	input      [3:0]  row, 			// 4bit入力 行
	output reg [3:0]  col,			// 4bit出力 列
	output reg [15:0] key,			// 16bitキー出力
	output            tc				// 出力カウント
	) ;
	
	reg [2:0]  index ;	
	reg [15:0] tmp ;

	always @(posedge rst or posedge clk) begin
		if(rst == 1'b1)begin
			tmp   <= 16'hFFFF ;
			key   <= 16'h0000 ;
			index <= 3'd0 ;
		end
		else begin
			//LSB=0 colへの出力をセット
			if (index[0] == 1'b0) begin
				case (index[2:1]) 
					2'd0: begin
								col <= 4'b1110 ;
								key <= ~tmp ;
								tmp <= 16'hFFFF ;
							end
					2'd1: col <= 4'b1101 ;
					2'd2: col <= 4'b1011 ;
					2'd3: col <= 4'b0111 ;
				endcase
			end
			//LSB=1 rowの値を読む
			else begin
				tmp[{2'd0, index[2:1]}] <= row[0] ;
				tmp[{2'd1, index[2:1]}] <= row[1] ;
				tmp[{2'd2, index[2:1]}] <= row[2] ;
				tmp[{2'd3, index[2:1]}] <= row[3] ;
			end
			
			index <= index + 3'd1 ;		
			
		end
	end
	
	assign tc = (index == 3'd0) ? 1'b1 : 1'b0 ;
	
endmodule

// 押下されているキーを4bitで出力（16bit→4bitデコーダ）
module m_dec16to4 (
		input [15:0] key,		// 16bit入力
		output [3:0] out,		// 4bit出力
		output       pushed		//打鍵検出
) ;

		function [4:0] f ;
				input [15:0] in ;
				case(in)
				16'h0001: f = { 1'b1, 4'h1 } ;		// (1) 0000_0000_0000_0001 → 4'h0
				16'h0002: f = { 1'b1, 4'h2 } ;		// (2) 0000_0000_0000_0010 → 4'h1
				16'h0004: f = { 1'b1, 4'h3 } ;		// (3) 0000_0000_0000_0100 → 4'h2
				16'h0008: f = { 1'b1, 4'ha } ;		// (A) 0000_0000_0000_1000 → 4'h3
				16'h0010: f = { 1'b1, 4'h4 } ;		// (4) 0000_0000_0001_0000 → 4'h4
				16'h0020: f = { 1'b1, 4'h5 } ;		// (5) 0000_0000_0010_0000 → 4'h5
				16'h0040: f = { 1'b1, 4'h6 } ;		// (6) 0000_0000_0100_0000 → 4'h6
				16'h0080: f = { 1'b1, 4'hb } ;		// (B) 0000_0000_1000_0000 → 4'h7
				16'h0100: f = { 1'b1, 4'h7 } ;		// (7) 0000_0001_0000_0000 → 4'h8
				16'h0200: f = { 1'b1, 4'h8 } ;		// (8) 0000_0010_0000_0000 → 4'h9
				16'h0400: f = { 1'b1, 4'h9 } ;		// (9) 0000_0100_0000_0000 → 4'hA
				16'h0800: f = { 1'b1, 4'hc } ;		// (C) 0000_1000_0000_0000 → 4'hB
				16'h1000: f = { 1'b1, 4'hf } ;		// (*) 0001_0000_0000_0000 → 4'hC
				16'h2000: f = { 1'b1, 4'h0 } ;		// (0) 0010_0000_0000_0000 → 4'hD
				16'h4000: f = { 1'b1, 4'he } ;		// (#) 0100_0000_0000_0000 → 4'hE
				16'h8000: f = { 1'b1, 4'hd } ;		// 1000_0000_0000_0000 → 4'hF
				default:  f = { 1'b0, 4'h0 } ;		// キーが一つだけ押されているとき以外は pushed=0, out=0
				endcase
		endfunction

		assign { pushed, out } = f(key) ;

endmodule

