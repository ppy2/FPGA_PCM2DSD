// Copyright (C) 2020  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
// CREATED		"Sat Jan 15 03:40:16 2022"

module DSM_1bit(
	BCK_I,
	LRCK_I,
	DATA_I,
	RST_I,
	DBCK_O,
	DSDL_O,
	DSDR_O
);


input wire	BCK_I;
input wire	LRCK_I;
input wire	DATA_I;
input wire	RST_I;
output wire	DBCK_O;
output wire	DSDL_O;
output wire	DSDR_O;

wire	[32:0] SYNTHESIZED_WIRE_0;
wire	[33:0] SYNTHESIZED_WIRE_1;
wire	[33:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	[31:0] SYNTHESIZED_WIRE_5;
wire	[31:0] SYNTHESIZED_WIRE_6;
wire	[31:0] SYNTHESIZED_WIRE_7;
wire	[31:0] SYNTHESIZED_WIRE_8;
wire	[32:0] SYNTHESIZED_WIRE_9;

assign	DBCK_O = BCK_I;
assign	DSDL_O = SYNTHESIZED_WIRE_3;
assign	DSDR_O = SYNTHESIZED_WIRE_4;




I2S_PCM_Converter	b2v_inst(
	.BCLK_I(BCK_I),
	.LRCK_I(LRCK_I),
	.DATA_I(DATA_I),
	.RST_I(RST_I),
	
	
	.DATAL_O(SYNTHESIZED_WIRE_6),
	.DATAR_O(SYNTHESIZED_WIRE_8));
	defparam	b2v_inst.PCM_Bit_Length = 32;


DSM_SIGMA	b2v_inst1(
	.BCLK_I(BCK_I),
	.DATA_I(SYNTHESIZED_WIRE_0),
	.DATA_O(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst1.PCM_Bit_Length = 32;


DSM_QUANT_1BIT	b2v_inst10(
	.SIGMA_DATA_I(SYNTHESIZED_WIRE_1),
	.QUANT_DATA_O(SYNTHESIZED_WIRE_3));
	defparam	b2v_inst10.PCM_Bit_Length = 32;


DSM_QUANT_1BIT	b2v_inst11(
	.SIGMA_DATA_I(SYNTHESIZED_WIRE_2),
	.QUANT_DATA_O(SYNTHESIZED_WIRE_4));
	defparam	b2v_inst11.PCM_Bit_Length = 32;


DSM_MAXIMIZER	b2v_inst12(
	.BCLK_I(BCK_I),
	.QUANT_DATA_I(SYNTHESIZED_WIRE_3),
	.DSDDATA_O(SYNTHESIZED_WIRE_5));
	defparam	b2v_inst12.PCM_Bit_Length = 32;


DSM_MAXIMIZER	b2v_inst13(
	.BCLK_I(BCK_I),
	.QUANT_DATA_I(SYNTHESIZED_WIRE_4),
	.DSDDATA_O(SYNTHESIZED_WIRE_7));
	defparam	b2v_inst13.PCM_Bit_Length = 32;


DSM_DELTA	b2v_inst2(
	.DSDDATA_I(SYNTHESIZED_WIRE_5),
	.PCMDATA_I(SYNTHESIZED_WIRE_6),
	.DATA_O(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst2.PCM_Bit_Length = 32;


DSM_DELTA	b2v_inst3(
	.DSDDATA_I(SYNTHESIZED_WIRE_7),
	.PCMDATA_I(SYNTHESIZED_WIRE_8),
	.DATA_O(SYNTHESIZED_WIRE_9));
	defparam	b2v_inst3.PCM_Bit_Length = 32;


DSM_SIGMA	b2v_inst4(
	.BCLK_I(BCK_I),
	.DATA_I(SYNTHESIZED_WIRE_9),
	.DATA_O(SYNTHESIZED_WIRE_2));
	defparam	b2v_inst4.PCM_Bit_Length = 32;


endmodule
