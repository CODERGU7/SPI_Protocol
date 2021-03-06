`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2021 Harshal Chowdhary
// ///////////////////////////////////////////////////////////////////////////////
// File Name:      Loopback.v
// Type:           Module
// Department:     Electronics and Communication Engineering, B.Tech
// Author:         Harshal Chowdhary
// Authors' Email: harshalchowdhary15@gmail.com
// Create Date:    12:56:10 10/22/2021 
// Module Name:    SPI_Loopback 
//////////////////////////////////////////////////////////////////////////////////
// Release History
// 10/22/2021 Harshal Chowdhary 
//////////////////////////////////////////////////////////////////////////////////
// Keywords:       
//////////////////////////////////////////////////////////////////////////////////
// Purpose:         
//////////////////////////////////////////////////////////////////////////////////

module SPI_loopback
#(
	parameter	CLK_FREQUENCE	= 50_000_000		,	//system clk frequence
				SPI_FREQUENCE	= 5_000_000			,	//spi clk frequence
				DATA_WIDTH		= 8					,	//serial word length
				CPOL			= 0					,	//SPI mode selection (mode 0 default)
				CPHA			= 0					 	//CPOL = clock polarity, CPHA = clock phase
)
(
	input							clk			,
	input							rst_n		,
	input		[DATA_WIDTH-1:0]	data_m_in	,
	input		[DATA_WIDTH-1:0]	data_s_in	,
	input							start_m		,
	output							finish_m	,
	output		[DATA_WIDTH-1:0]	data_m_out	,
	output		[DATA_WIDTH-1:0]	data_s_out	,
	output							data_valid_s	 
);

wire				miso	;
wire				mosi	;
wire				cs_n	;
wire				sclk	;

spi_master 
#(
	.CLK_FREQUENCE (CLK_FREQUENCE ),
	.SPI_FREQUENCE (SPI_FREQUENCE ),
	.DATA_WIDTH    (DATA_WIDTH    ),
	.CPOL          (CPOL          ),
	.CPHA          (CPHA          ) 
)
u_spi_master(
	.clk      (clk      ),
	.rst_n    (rst_n    ),
	.data_in  (data_m_in  ),
	.start    (start_m    ),
	.miso     (miso     ),
	.sclk     (sclk     ),
	.cs_n     (cs_n     ),
	.mosi     (mosi     ),
	.finish   (finish_m   ),
	.data_out (data_m_out )
);

SPI_Slave 
#(
	.CLK_FREQUENCE (CLK_FREQUENCE ),
	.SPI_FREQUENCE (SPI_FREQUENCE ),
	.DATA_WIDTH    (DATA_WIDTH    ),
	.CPOL          (CPOL          ),
	.CPHA          (CPHA          ) 
)
u_SPI_Slave(
	.clk        (clk        ),
	.rst_n      (rst_n      ),
	.data_in    (data_s_in    ),
	.sclk       (sclk       ),
	.cs_n       (cs_n       ),
	.mosi       (mosi       ),
	.miso       (miso       ),
	.data_valid (data_valid_s ),
	.data_out   (data_s_out   )
);

endmodule
