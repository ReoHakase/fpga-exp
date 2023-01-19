module m_chattering_filter(input clk, input signal_in, output signal_out);
	reg signal_reg;
	assign signal_out = signal_reg;
	
	always @(posedge clk) begin
		signal_reg = signal_in;
	end
endmodule