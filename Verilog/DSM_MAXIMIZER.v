/*-----------------------------------------------------------------------------
* DSM_MAXIMIZER.v
*
* Bit Extender of a Delta-Sigma Modulator (Behave like an ADC)
* 
* Designer: AUDIY
* Date    : 22/01/15 (YY/MM/DD)
* Version : 1.00
*
* Description
*	Input
*	BCLK_I: I2S Bit Clock
*	QUANT_DATA_I: Quantized DSD Data
*
*	Output
*	DSDDATA_O: Maximized DSD Data (from 1 bit to PCM bit Length)
*
*	Parameter
*	PCM_Bit_Length: Parallel PCM Data Bit Length
-----------------------------------------------------------------------------*/

module DSM_MAXIMIZER(
	BCLK_I,
	QUANT_DATA_I,
	DSDDATA_O
);

	/* Parameter Definition */
	parameter PCM_Bit_Length = 32;
	
	/* Input Definition */
	input  wire                             BCLK_I;
	input  wire                             QUANT_DATA_I;
	
	/* Output Definition */
	output wire signed [PCM_Bit_Length-1:0] DSDDATA_O;
	
	/* Internal Register Definition */
	reg                             QUANT_DATA_Buf; // For Reading 1 bit DSD Data
	reg signed [PCM_Bit_Length-1:0] DSDDATA_Buf;    // For Storing Maximized DSD Data
	
	/* RTL */
	// Read 1 bit DSD Data
	always @ (posedge BCLK_I) begin
		QUANT_DATA_Buf <= QUANT_DATA_I;
	end
	
	// Maximize DSD Data from QUANT_DATA_Buf
	always @ (negedge BCLK_I) begin
		if (QUANT_DATA_Buf == 1'b1) begin
			// Maximum PCM Amplitude
			DSDDATA_Buf <= 32'h7fff_ffff;
		end else begin
			// Minimum PCM Amplitude
			DSDDATA_Buf <= 32'h8000_0000;
		end
	end
	
	/* Output the Maximized Data */
	assign DSDDATA_O = DSDDATA_Buf;
	
endmodule