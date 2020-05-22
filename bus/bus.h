// verilog header file

`ifndef __BUS_HEADER__
	`define __BUS_HEADER__

	`define BUS_MASTER_CH		4
	`define BUS_MASTER_INDEX_W	2
	`define BusOwnerBus			2:0

	`define BUS_OWNER_MASTER_0	3'h0
	`define BUS_OWNER_MASTER_1	3'h1
	`define BUS_OWNER_MASTER_2	3'h2
	`define BUS_OWNER_MASTER_3	3'h3
	`define BUS_OWNER_MASTER_NULL	3'h`BUS_MASTER_CH

	`define BUS_SLAVE_CH		8
	`define BUS_SLAVE_INDEX_W	3
	`define BusSlaveIndexBus	2:0
	`define BusSlaveIndexLoc	29:27

	`define BUS_SLAVE_0			0
	`define BUS_SLAVE_1			1
	`define BUS_SLAVE_2			2
	`define BUS_SLAVE_3			3
	`define BUS_SLAVE_4			4
	`define BUS_SLAVE_5			5
	`define BUS_SLAVE_6			6
	`define BUS_SLAVE_7			7
`endif
