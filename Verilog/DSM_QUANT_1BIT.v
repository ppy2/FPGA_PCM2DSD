/*-----------------------------------------------------------------------------
* DSM_QUANT_1BIT.v
*
* 1bit Quantizer of a Delta-Sigma Modulator
*
* Designer: AUDIY
* Date    : 21/01/13 (YY/MM/DD)
* Version : 1.00
*
* Description
*	Input
*	SIGMA_DATA_I: Integrated Data Input from DSM_SIGMA.v
*
*	Output
*	QUANT_DATA_O: 1bit Quantized Data Output
*
*	Parameter
*	PCM_Bit_Length: Parallel PCM Data Bit Length
-----------------------------------------------------------------------------*/

module DSM_QUANT_1BIT(
	SIGMA_DATA_I,
	QUANT_DATA_O
);
	
	/* Parameter Definition */
	parameter PCM_Bit_Length = 32;
	
	/* Input Definition */
	input wire signed [PCM_Bit_Length+1:0] SIGMA_DATA_I;
	
	/* Output Definition */
	output wire QUANT_DATA_O;
	
	/* Quantize */
	assign QUANT_DATA_O = ~SIGMA_DATA_I[PCM_Bit_Length+1];
	

endmodule