//==================================================================================================
//  Filename      : reg32b_test.v
//  Created On    : 2020-05-22 00:17:51
//  Last Modified : 2020-05-23 02:49:10
//  Revision      : 
//  Author        : kokkoroQwQ
//  Email         : 17307130169@fudan.edu.cn
//
//  Description   : 
//
//
//==================================================================================================
`timescale 1ns/1ps

`include "reg32b.h"

module reg32b_test;

	reg clk;
	reg reset_;
	reg [`AddrBus] addr;
	reg [`DataBus] d_in;
	reg we_;
	wire [`DataBus] d_out;

	integer i;

	parameter STEP = 100.0000;

	always # (STEP/2) begin
		clk <= ~clk;
	end

	reg32b reg32b(
		.clk(clk),
		.reset_(reset_),
		.addr(addr),
		.d_in(d_in),
		.we_(we_),
		.d_out(d_out)
	);

	initial begin
		# 0 begin
			clk <= `HIGH;
			reset_ <= `ENABLE_;
			addr <= {`ADDR_W{1'b0}};
			d_in <= {`DATA_W{1'b0}};
			we_ <= `DISABLE_;
		end
		# (STEP * 3 /4)
		# STEP begin
			reset_ <= `DISABLE_;
		end

		# STEP begin
			for (i = 0; i < `DATA_D; i = i + 1) begin
				# STEP begin
					we_  <= `ENABLE_;
					addr <= i;
					d_in <= i;
				end
				# STEP begin
					we_  <= `DISABLE_;
					addr <= {`ADDR_W{1'b0}};
					d_in <= {`DATA_W{1'b0}};
					if(d_out == i) begin
						$display($time, " ff[%d]=%d Read/Write Check Ok !", i, d_out);
					end else begin
						$display($time, " ff[%d]=%d Read/Write Check NG !", i, d_out);
					end
				end
			end
		end
		# STEP begin
			$finish;
		end
	end

	initial begin
		$dumpfile("reg32b.vcd");
		$dumpvars(0, reg32b);
	end

endmodule
