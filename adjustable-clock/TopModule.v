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

	// FPGA提供の50[MHz]クロックから分周されるクロックの定義
	wire clock_chattering; // 1000[Hz]のチャタリング除去用クロック
	m_prescale(CLK1, 24'd50000, clock_chattering);

	// インクリメント・リセットボタンの信号の定義
	wire increment_button;
	m_chattering_filter(clock_chattering, ~BTN[0], increment_button);
	wire reset_button;
	m_chattering_filter(clock_chattering, ~BTN[1], reset_button);

	// スイッチによる編集モード判定フラグの定義
	wire is_second_editing;
	m_chattering_filter(clock_chattering, SW[0], is_second_editing);
	wire is_minute_editing;
	m_chattering_filter(clock_chattering, SW[1], is_minute_editing);
	wire is_hour_editing;
	m_chattering_filter(clock_chattering, SW[2], is_hour_editing);
	wire is_editing = is_second_editing || is_minute_editing || is_hour_editing;

	// FPGA提供の50[MHz]クロックから分周されるクロックの定義
	wire clock_1hz; // 時計のインクリメント用の1[Hz]のクロック
	m_prescale(CLK1 && ~is_editing, 24'd5000000, clock_1hz);

	// 時、分、秒の値を伝えるワイヤの定義
	wire [`HOUR_WIDTH:0] hour;
	wire [`MINUTE_WIDTH:0] minute;
	wire [`SECOND_WIDTH:0] second;
	wire second_countup,  minute_countup; // 単位の繰り上がりを伝えるワイヤの定義

	// カウンタとの接続
	// definition: module m_counter( increment_clock, res, law, q, countup );
	m_counter(clock_1hz || (is_second_editing && increment_button), is_second_editing && reset_button, 6'd60, second, second_countup);
	m_counter(second_countup || (is_minute_editing && increment_button), is_minute_editing && reset_button, 6'd60, minute, minute_countup);
	m_counter(minute_countup || (is_hour_editing && increment_button), is_hour_editing && reset_button, 6'd24, hour, _);

	// LEDと7セグメントディスプレイとの接続
	assign LED={is_editing, 4'b0, reset_button, increment_button, is_hour_editing, is_minute_editing, is_second_editing};
	m_seven_segment(second % 10, HEX0); // 秒の1桁目
	m_seven_segment(second / 10, HEX1); // 秒の2桁目
	m_seven_segment(minute % 10, HEX2); // 分の1桁目
	m_seven_segment(minute / 10, HEX3); // 分の2桁目
	m_seven_segment(hour % 10, HEX4); // 時の1桁目
	m_seven_segment(hour / 10, HEX5); // 時の2桁目

endmodule
