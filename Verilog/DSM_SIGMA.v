/*-----------------------------------------------------------------------------
* DSM_SIGMA.v
*
* Integrater of a Delta-Sigma Modulator.
*
* Designer: AUDIY
* Date    : 22/01/13 (YY/MM/DD)
* Version : 1.01
*
* Description
*	Input
*	BCLK_I: Bit Clock
*	DATA_I: DATA from DSM_DELTA module
*
*	Output
*	DATA_O: Integrated Data Output
*	
*	Parameter
*	PCM_Bit_Length: Parallel PCM Data Bit Length
-----------------------------------------------------------------------------*/

module DSM_SIGMA(
	BCLK_I,
	DATA_I,
	DATA_O
);

	/* Parameter Definition */
	parameter PCM_Bit_Length = 32;
	
	/* Input Definition */
	input  wire                             BCLK_I;
	input  wire signed [PCM_Bit_Length:0]   DATA_I;
	
	/* Output Definition */
	output wire signed [PCM_Bit_Length+1:0] DATA_O;
	
	/* Internal Register Definition */
	reg signed [PCM_Bit_Length:0] DATA_Latch_pos = 0;
	reg signed [PCM_Bit_Length:0] DATA_Latch_neg = 0;
	
	/* RTL */
	always @ (posedge BCLK_I) begin
		DATA_Latch_pos <= DATA_O[PCM_Bit_Length+1:1];
	end
	
	always @ (negedge BCLK_I) begin
		DATA_Latch_neg <= DATA_Latch_pos;
	end
	
	assign DATA_O = DATA_Latch_neg + DATA_I;
	
endmodule