/*-----------------------------------------------------------------------------
* I2S_PCM_Converter.v
*
* I2S to Parallel PCM Converter
*
* Designer: AUDIY
* Date    : 22/01/12 (YY/MM/DD)
* Version : 1.00
* 
* Description
*	Input
*	BCLK_I : I2S Bit Clock Input
*	LRCK_I : I2S L/R Clock Input
*	DATA_I : I2S DATA Input
*	RST_I  : Reset (Active Low)
*
*	Output
*	BCLK_O : I2S Bit Clock Output (Through BCLK_I)
*	WCLK_O : Parallel PCM Word Clock Output
*	DATAL_O: Parallel PCM Left Data Output
*	DATAR_O: Parallel PCM Right Data Output
*
*	Parameter
*	PCM_Bit_Length: Parallel PCM Bit Length 
-----------------------------------------------------------------------------*/

module I2S_PCM_Converter(
    BCLK_I,
    LRCK_I,
    DATA_I,
    RST_I,
    BCLK_O,
    WCLK_O,
    DATAL_O,
    DATAR_O
);
    /* Parameter Definition */
    parameter PCM_Bit_Length = 32;

    /* Input Signal Definition */
    input  wire                             BCLK_I;
    input  wire                             LRCK_I;
    input  wire                             DATA_I;
    input  wire                             RST_I;
    
    /* Output Signal Definition */
    output wire                             BCLK_O;
    output reg                              WCLK_O;
    output wire signed [PCM_Bit_Length-1:0] DATAL_O;
    output wire signed [PCM_Bit_Length-1:0] DATAR_O;

    /* Internal Wire/Register Definition */
    reg unsigned [2*PCM_Bit_Length-1:0] DATA_LR_Buf;
    reg signed   [PCM_Bit_Length-1:0]   DATAL_Buf;
    reg signed   [PCM_Bit_Length-1:0]   DATAR_Buf;
    reg                                 WCLK_Buf;

    /* RTL */
    // Store the I2S Data and LRCK Synchronizing with Positive Edge of BCLK_I
    always @ (posedge BCLK_I) begin
        WCLK_Buf <= LRCK_I;

        if (RST_I == 1'b0) begin
      	    // When Reset is Active, Store the zero data.
            DATA_LR_Buf[2*PCM_Bit_Length-1:0] <= {DATA_LR_Buf[2*PCM_Bit_Length-2:0], 1'b0}; 
        end else begin
            DATA_LR_Buf[2*PCM_Bit_Length-1:0] <= {DATA_LR_Buf[2*PCM_Bit_Length-2:0], DATA_I};
        end
    end

    // Output the WCLK_O Synchronizing with Negative Edge of BCLK_I
    always @ (negedge BCLK_I) begin
        WCLK_O <= WCLK_Buf;
    end

    // Output the Parallel PCM Data Synchronizing with Negative Edge of Word Clock
    always @ (negedge WCLK_O) begin
        if (RST_I == 1'b0) begin
	    // When Reset is Active, Output the Zero Data
            DATAL_Buf[PCM_Bit_Length-1:0] <= 0;
            DATAR_Buf[PCM_Bit_Length-1:0] <= 0;
        end else begin
            DATAL_Buf[PCM_Bit_Length-1:0] <= DATA_LR_Buf[2*PCM_Bit_Length-1:PCM_Bit_Length];
            DATAR_Buf[PCM_Bit_Length-1:0] <= DATA_LR_Buf[PCM_Bit_Length-1:0];
        end
    end

    /* Output Signal Assign */
    assign BCLK_O = BCLK_I;
    assign DATAL_O[PCM_Bit_Length-1:0] = DATAL_Buf[PCM_Bit_Length-1:0];
    assign DATAR_O[PCM_Bit_Length-1:0] = DATAR_Buf[PCM_Bit_Length-1:0];

endmodule
