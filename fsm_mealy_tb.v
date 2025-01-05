module fsm_mealy_tb();

	reg i_clk;
	reg i_reset;
	reg i_a;
	wire [1:0] o_y;
	
	fsm_mealy DUT (
		.i_clk(i_clk), 
		.i_reset(i_reset), 
		.i_a(i_a), 
		.o_y(o_y)
	);
	
	initial begin
		i_clk = 1'b0;
		forever #5 i_clk = ~i_clk;		// 100MHz
	end
	
	initial begin
	
		// Setup waveform dump
		$dumpfile("fsm_mealy_output.vcd");
		$dumpvars(0,DUT);
		
		i_reset = 1;i_a = 0;
		#20 i_reset = 0;
		#10 i_a = 1; 
		#10 i_a = 0; 
		#10 i_a = 1; // (Sequence 101 detected here)
		#10 i_a = 1; 
		#10 i_a = 0; // (Sequence 110 detected here)
		#10 i_a = 0; 
		#10 i_a = 1; 
		#10 i_a = 1; 
		#10 i_a = 0; // (Sequence 110 detected here)
		#100 $finish;
	end
	
	initial begin
        $monitor("Time = %t | i_a = %b | o_y = %b | Current State = %b",$time, i_a, o_y, DUT.PS);
    end
	
endmodule 