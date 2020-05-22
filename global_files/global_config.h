// verilog header file

`ifndef __GLOBAL_CONFIG_HEADER__
	`define __GLOBAL_CONFIG_HEADER__

	/********使用高电平复位时********/
	`ifdef POSITIVE_RESET
		`define RESET_EDGE 		posedge
		`define RESET_ENABLE	1'b1
		`define RESET_DISABLE 	1'b0
	`endif
	/********使用低电平复位时********/
	`ifdef NEGAITIVE_RESET
		`define RESET_EDGE 		negedge
		`define RESET_ENABLE	1'b0
		`define RESET_DISABLE 	1'b1
	`endif

	/********内存控制信号高电平有效时********/
	`ifdef POSITIVE_MEMORY
		`define MEM_ENABLE 		1'b1
		`define MENM_DISABLE 	1'b0
	`endif
	/********内存控制信号低电平有效时********/
	`ifdef NEGAITIVE_MEMORY
		`define MEM_ENABLE 		1'b0
		`define MENM_DISABLE 	1'b1
	`endif

	/********I/O口的选择********/
	
`endif