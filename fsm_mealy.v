// A mealy FSM for detecting overlapping 101, 110 sequences
// o_y will be 10 and 11 for respecctive sequence getting detected 

module fsm_mealy(
	input wire 		  i_clk,
	input	wire 		  i_reset,
	input wire		  i_a,
	output reg [1:0] o_y
);
	reg [1:0] PS, NS;
	parameter [1:0]  S0 = 2'b00;
	parameter [1:0]  S1 = 2'b01;
	parameter [1:0]  S2 = 2'b10;
	parameter [1:0]  S3 = 2'b11;

	always @(posedge i_clk or posedge i_reset)
	begin
//		if(i_reset)
			PS <= S0;
		else 
			PS <= NS;	
	end
	
	always @(i_a or PS) begin
	
		case(PS)
		
			S0 : begin
				if(i_a) begin
					NS = S1;
					o_y = 2'b00;
				end
				else begin
					NS = S0;
					o_y = 2'b00;
				end
			end // case: S0
			
			S1 : begin
				if(i_a) begin
					NS = S2;
					o_y = 2'b00;
				end
				else begin
					NS = S3;
					o_y = 2'b00;
				end
			end // case: S1
			
			
			S2 : begin
				if(i_a) begin
					NS = S2;
					o_y = 2'b00;
				end
				else begin
					NS = S3;
					o_y = 2'b11;			//sequence 110 is detected
				end
			end // case: S2
			
			S3 : begin
				if(i_a) begin
					NS = S1;
					o_y = 2'b10;		//sequence 101 is detected
				end
				else begin
					NS = S0;
					o_y = 2'b00;
				end
			end // case: S3
			
			default: begin
                NS = S0;
                o_y = 2'b00;
         end // case: default
			
		endcase
		
	end

endmodule 