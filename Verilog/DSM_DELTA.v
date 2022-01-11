/*-----------------------------------------------------------------------------
* DSM_DELTA.v
*
* Differentiator of a Delta-Sigma Modulator
*
* Designer: AUDIY
* Date    : 22/01/12 (YY/MM/DD)
* Version : 1.00
*
* Description
*	Input
*	PCMDATA_I: Monoaural Parallel PCM Data
*	DSDDATA_I: Monoaural Maximized DSD Data
*
*	Output
*	DATA_O: Differentiated Data (as PCM_Bit_Length+1 bit)
*
*	Parameter
*	PCM_Bit_Length: Parallel PCM Data Bit Length
-----------------------------------------------------------------------------*/

module DSM_DELTA(
	PCMDATA_I,
	DSDDATA_I,
	DATA_O
);

	/* Parameter Definition */
	parameter PCM_Bit_Length = 32;
	
	/* Input Definition */
	input  wire signed [PCM_Bit_Length-1:0] PCMDATA_I;
	input  wire signed [PCM_Bit_Length-1:0] DSDDATA_I;
	
	/* Output Definition */
	output wire signed [PCM_Bit_Length:0]   DATA_O;
	
	/* Assign */
	assign DATA_O = PCMDATA_I - DSDDATA_I;

endmodule