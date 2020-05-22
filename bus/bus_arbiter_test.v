//==================================================================================================
//  Filename      : bus_arbiter_test.v
//  Created On    : 2020-05-22 14:37:14
//  Last Modified : 2020-05-23 02:22:24
//  Revision      : 
//  Author        : kokkoroQwQ
//  Email         : 17307130169@fudan.edu.cn
//
//  Description   : 
//
//
//==================================================================================================
`timescale 1ns/1ps

`define NEGATIVE_RESET // see in global_config.h
`include "../global_files/global.h"
`include "../global_files/nettype.h"
`include "../global_files/global_config.h"
`include "../global_files/stddef.h"
`include "bus.h"

module bus_arbiter_test;
	
	reg clk;
	reg reset;
	reg m0_req_;
	reg m1_req_;
	reg m2_req_;
	reg m3_req_;

	wire m0_grnt_;
	wire m1_grnt_;
	wire m2_grnt_;
	wire m3_grnt_;

	integer i;

	parameter STEP = 100.0000;

	always # (STEP/2) begin
		clk <= ~clk;
	end

	bus_arbiter bus_arbiter(
		.clk(clk),
		.reset(reset),
		.m0_req_(m0_req_),
		.m1_req_(m1_req_),
		.m2_req_(m2_req_),
		.m3_req_(m3_req_),

		.m0_grnt_(m0_grnt_),
		.m1_grnt_(m1_grnt_),
		.m2_grnt_(m2_grnt_),
		.m3_grnt_(m3_grnt_)
	);

	initial begin
		# 0 begin
			clk <= `HIGH;
			reset <= `ENABLE_;
			m0_req_ <= `DISABLE_;
			m1_req_ <= `DISABLE_;
			m2_req_ <= `DISABLE_;
			m3_req_ <= `DISABLE_;
		end

		# (STEP * 3/4)
		# STEP begin
			reset <= `DISABLE_;
		end

		# STEP begin
			for (i = 0; i < `BUS_MASTER_CH; i = i + 1) begin
				case (i)
					0 : begin
						m0_req_ <= `ENABLE_;
						# (5*STEP)
						m0_req_ <= `DISABLE_;
					end
					1 : begin
						m1_req_ <= `ENABLE_;
						# (5*STEP)
						m1_req_ <= `DISABLE_;
					end
					2 : begin
						m2_req_ <= `ENABLE_;
						# (5*STEP)
						m2_req_ <= `DISABLE_;
					end
					3 : begin
						m3_req_ <= `ENABLE_;
						# (5*STEP)
						m3_req_ <= `DISABLE_;
					end
				endcase
			end
		end

		# STEP begin
			$finish;
		end
	end

	initial begin
		$dumpfile("bus_arbiter_test.vcd");
		$dumpvars(0, bus_arbiter);
	end

endmodule