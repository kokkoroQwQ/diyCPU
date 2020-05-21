//==================================================================================================
//  Filename      : regfile.v
//  Created On    : 2020-05-19 21:01:27
//  Last Modified : 2020-05-20 11:52:08
//  Revision      : 
//  Author        : Yuanxi Ye
//  Email         : 17307130169@fudan.edu.cn
//
//  Description   : 
//
//
//==================================================================================================

`include "regfile.h"
module  regfile(
	//system signals
	input wire 				clk,
	input wire 				reset_,

	input wire 	[`AddrBus] 	addr,
	input wire 	[`DataBus] 	d_in,
	input wire 				we_,
	output 		[`DataBus]	d_out
	//
);
	reg [`DataBus] ff[`DATA_D-1:0];
	integer i;

	assign d_out = ff[addr];

	always @(posedge clk or negedge reset_) begin
		if (reset_ == `ENABLE_) begin
			for(i = 0; i < `DATA_D; i = i + 1) begin
				ff[i] <= #1 {`DATA_W{1'b0}};
			end
		end
		else begin
			if(we_ == `ENABLE_) begin
				ff[addr] <= #1 d_in;
			end
		end
	end
    
endmodule
