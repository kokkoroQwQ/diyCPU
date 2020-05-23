//==================================================================================================
//  Filename      : bus_arbiter.v
//  Created On    : 2020-05-22 13:35:27
//  Last Modified : 2020-05-23 12:20:06
//  Revision      : 
//  Author        : kokkoroQwQ
//  Email         : 17307130169@fudan.edu.cn
//
//  Description   : bus arbiter 总线仲裁器
//
//
//==================================================================================================
`define NEGATIVE_RESET // see in global_config.h
`include "../global_files/global.h"
`include "../global_files/nettype.h"
`include "../global_files/global_config.h"
`include "../global_files/stddef.h"
`include "bus.h"


module bus_arbiter (
	//system signals
	input	wire		clk,
	input	wire		reset,

	input	wire		m0_req_,
	output	reg			m0_grnt_,

	input	wire		m1_req_,
	output	reg			m1_grnt_,

	input	wire		m2_req_,
	output	reg			m2_grnt_,

	input	wire		m3_req_,
	output	reg			m3_grnt_
	//
);
	reg		[`BusOwnerBus]	owner;

	/* 赋予总线使用权 */
	always @(*) begin
		/* 赋予总线使用权初始化 */
		m0_grnt_ = `DISABLE_;
		m1_grnt_ = `DISABLE_;
		m2_grnt_ = `DISABLE_;
		m3_grnt_ = `DISABLE_;

		/* 赋予总线使用权 */
		case (owner) 
		    `BUS_OWNER_MASTER_0 : begin
		    	m0_grnt_ = `ENABLE_;
		    end
		    `BUS_OWNER_MASTER_1 : begin
		    	m1_grnt_ = `ENABLE_;
		    end
		    `BUS_OWNER_MASTER_2 : begin
		    	m2_grnt_ = `ENABLE_;
		    end
		    `BUS_OWNER_MASTER_3 : begin
		    	m3_grnt_ = `ENABLE_;
		    end
		    `BUS_OWNER_MASTER_NULL : begin
		    	;
		    end
		endcase
	end

	/* 总线使用权的仲裁 */
	always @(posedge clk or `RESET_EDGE reset) begin
		if (reset == `RESET_ENABLE) begin
			// 异步复位
			owner <= #1 `BUS_OWNER_MASTER_NULL;
		end
		else begin
			/* 仲裁 */
			case (owner)
				`BUS_OWNER_MASTER_NULL : begin 	// 无主控拥有使用权
				/* 下一个获得总线使用权的主控 */
					if (m0_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else begin
						owner <= #1 `BUS_OWNER_MASTER_NULL;
					end
				end

				`BUS_OWNER_MASTER_0 : begin 	// 0号主控拥有使用权
					/* 下一个获得总线使用权的主控 */
					if (m0_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else begin
						owner <= #1 `BUS_OWNER_MASTER_NULL;
					end
				end

				`BUS_OWNER_MASTER_1 : begin 	// 1号主控拥有使用权
					/* 下一个获得总线使用权的主控 */
					if (m1_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else begin
						owner <= #1 `BUS_OWNER_MASTER_NULL;
					end
				end

				`BUS_OWNER_MASTER_2 : begin 	// 2号主控拥有使用权
					/* 下一个获得总线使用权的主控 */
					if (m2_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else if (m3_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else begin
						owner <= #1 `BUS_OWNER_MASTER_NULL;
					end
				end

				`BUS_OWNER_MASTER_3 : begin 	// 3号主控拥有使用权
					/* 下一个获得总线使用权的主控 */
					if (m3_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_3;
					end else if (m0_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_0;
					end else if (m1_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_1;
					end else if (m2_req_ == `ENABLE_) begin
						owner <= #1 `BUS_OWNER_MASTER_2;
					end else begin
						owner <= #1 `BUS_OWNER_MASTER_NULL;
					end
				end
			endcase
		end
	end
    
endmodule
