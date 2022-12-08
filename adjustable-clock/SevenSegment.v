// `should_show_point`は点を表示するかどうかを決めるの信号
module m_seven_segment(input [3:0] idat, input should_show_point, output [7:0] odat);

    function [7:0] LedDec;
      input [3:0] num;
      input _should_show_point;
      begin
        case (num)
          // 7セグメントLEDの各桁の負論理で表される点灯パターン
          4'h0:        LedDec = {~_should_show_point, 7'b1000000};  // 0
          4'h1:        LedDec = {~_should_show_point, 7'b1111001};  // 1
          4'h2:        LedDec = {~_should_show_point, 7'b0100100};  // 2
          4'h3:        LedDec = {~_should_show_point, 7'b0110000};  // 3
          4'h4:        LedDec = {~_should_show_point, 7'b0011001};  // 4
          4'h5:        LedDec = {~_should_show_point, 7'b0010010};  // 5
          4'h6:        LedDec = {~_should_show_point, 7'b0000010};  // 6
          4'h7:        LedDec = {~_should_show_point, 7'b1111000};  // 7
          4'h8:        LedDec = {~_should_show_point, 7'b0000000};  // 8
          4'h9:        LedDec = {~_should_show_point, 7'b0011000};  // 9
          4'ha:        LedDec = {~_should_show_point, 7'b0001000};  // a
          4'hb:        LedDec = {~_should_show_point, 7'b0000011};  // b
          4'hc:        LedDec = {~_should_show_point, 7'b0100111};  // c
          4'hd:        LedDec = {~_should_show_point, 7'b0100001};  // d
          4'he:        LedDec = {~_should_show_point, 7'b0000110};  // e
          4'hf:        LedDec = {~_should_show_point, 7'b0001110};  // f
           default:     LedDec = 8'b11111111;  // LED OFF
        endcase
      end
    endfunction

    assign odat = LedDec(idat, should_show_point);

endmodule
