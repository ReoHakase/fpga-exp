module m_counter( increment_clock, res, law, q, countup );
    input   increment_clock,  res;
		input [5:0] law;
    output  [5:0] q;
    reg     [5:0] q;
		output countup;
		reg countup;

		always @( posedge increment_clock or posedge res )
    begin
        if( res == 1'b1 )
            q <= 6'h0;
        else if (increment_clock == 1'b1) begin
            q <= q + 6'h1;
						if(q + 6'h1 >= law) begin
							q <= 6'h0;
							countup = 1'b1;
						end
						else begin
							countup = 1'b0;
						end
				end
    end
endmodule
