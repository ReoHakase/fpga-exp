module m_rs_flipflop(input set,input reset,output q,output nq);
	assign q=~(set & nq);
	assign nq=~(reset & q);
endmodule


module m_counter( ck, res, law, q, countup );
    input   ck, res;
	 input [5:0] law;
    output  [5:0] q;
    reg     [5:0] q;
	 output countup;
	 reg countup;

    always @( posedge ck or posedge res )
    begin
        if( res == 1'b1 )
            q <= 4'h0;
        else begin
            q <= q + 4'h1;
				if(q + 4'h1 >= law) begin
					q <= 4'h0;
					countup = 1'b1;
				end
				else
		      countup = 1'b0;
			end
    end
endmodule

