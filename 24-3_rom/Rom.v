module m_rom(input variant, input [3:0] adr,output [7:0] dat);
	reg [7:0] data;
	assign dat = data;
	
	function [7:0] getRomHelloData(input [3:0] adr); begin
		case (adr)
			4'h0:	getRomHelloData=8'b10001001;	//H
			4'h1:	getRomHelloData=8'b10000110;	//E
			4'h2: getRomHelloData=8'b11000111; //L
			4'h3: getRomHelloData=8'b11000111; //L
			4'h4: getRomHelloData=8'b10100011;	//o
			4'h5:	getRomHelloData=8'b11111111;	//SP
			4'h6:	getRomHelloData=8'b11111111;	//SP
			4'h7: getRomHelloData=8'b11111111;	//SP
			4'h8: getRomHelloData=8'b11111111;	//SP
			4'h9: getRomHelloData=8'b11111111;	//SP
			4'ha:	getRomHelloData=8'b11111111;	//SP
			4'hb:	getRomHelloData=8'b11111111;	//SP
			4'hc: getRomHelloData=8'b11111111;	//SP
			4'hd: getRomHelloData=8'b11111111;	//SP
			4'he: getRomHelloData=8'b11111111;	//SP
			4'hf: getRomHelloData=8'b11111111;	//SP
			default: getRomHelloData=8'hff;
		endcase
	end	
	endfunction
	
	
	function [7:0] getRomGoodbyeData(input [3:0] adr); begin
		case (adr)
			4'h0:	getRomGoodbyeData=8'b11000010;	//G
			4'h1: getRomGoodbyeData=8'b10100011;	//o
			4'h2: getRomGoodbyeData=8'b10100011;	//o
			4'h3: getRomGoodbyeData=8'b10100001;	//d
			4'h4: getRomGoodbyeData=8'b10000011;	//b
			4'h5:	getRomGoodbyeData=8'b10010001;	//y
			4'h6:	getRomGoodbyeData=8'b10000110;	//E
			4'h7: getRomGoodbyeData=8'b11111111;	//SP
			4'h8: getRomGoodbyeData=8'b11111111;	//SP
			4'h9: getRomGoodbyeData=8'b11111111;	//SP
			4'ha:	getRomGoodbyeData=8'b11111111;	//SP
			4'hb:	getRomGoodbyeData=8'b11111111;	//SP
			4'hc: getRomGoodbyeData=8'b11111111;	//SP
			4'hd: getRomGoodbyeData=8'b11111111;	//SP
			4'he: getRomGoodbyeData=8'b11111111;	//SP
			4'hf: getRomGoodbyeData=8'b11111111;	//SP
			default: getRomGoodbyeData=8'hff;
		endcase 
	end
	endfunction
	
	always @(adr or variant) begin
		case (variant)
			1'b0: data = getRomHelloData(adr);
			1'b1: data = getRomGoodbyeData(adr);
			default: data = getRomHelloData(adr);
		endcase
	end
endmodule

