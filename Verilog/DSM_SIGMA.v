/*-----------------------------------------------------------------------------
* DSM_SIGMA.v
*
* Integrater of a Delta-Sigma Modulator.
*
* Designer: AUDIY
* Date    : 22/01/13 (YY/MM/DD)
* Version : 1.00
*
* Description
*	Input
*	DATA_I: DATA from DSM_DELTA module
*
*	Output
*	DATA_O: Integrated Data Output
*	
*	Parameter
*	PCM_Bit_Length: Parallel PCM Data Bit Length
-----------------------------------------------------------------------------*/

module DSM_SIGMA(
	DATA_I,
	DATA_O
);

	/* Parameter Definition */
	parameter PCM_Bit_Length = 32;
	
	/* Input Definition */
	input  wire signed [PCM_Bit_Length:0]   DATA_I;
	
	/* Output Definition */
	output wire signed [PCM_Bit_Length+1:0] DATA_O;
	
	/* Integration */
	assign DATA_O = (DATA_O >>> 1) + DATA_I;
	
	
endmodule