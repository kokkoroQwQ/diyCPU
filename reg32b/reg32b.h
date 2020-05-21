`ifndef __REGISTER_HEADER_
	`define __REGISTER_HEADER_

	/*********信号电平*********/
	`define HIGH			1'b1
	`define LOW 			1'b0

	/**********逻辑值**********/
	`define ENABLE_			1'b0
	`define DISABLE_		1'b1

	`define DATA_W			32
	`define DataBus			31:0
	`define DATA_D			32

	`define ADDR_W			5
	`define AddrBus			4:0
`endif
