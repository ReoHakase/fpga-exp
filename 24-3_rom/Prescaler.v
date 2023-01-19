`include "constants.h"

module m_prescale(input clock, input [`CLOCK_SCALER_WIDTH:0] length, output prescaled_clock);
	reg [`CLOCK_SCALER_WIDTH:0] count = 0;
	assign prescaled_clock = (count == `CLOCK_SCALER_WIDTH'b0) ? 1'b1 : 1'b0;
	always @(posedge clock)
	begin
		if(count >= length) count = 0;
		else count = count + 1;
	end
endmodule