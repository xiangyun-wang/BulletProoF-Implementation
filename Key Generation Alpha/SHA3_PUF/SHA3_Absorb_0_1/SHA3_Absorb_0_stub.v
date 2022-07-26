// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Mon Jun 13 15:01:48 2022
// Host        : ubuntu running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top SHA3_Absorb_0 -prefix
//               SHA3_Absorb_0_ SHA3_Absorb_0_stub.v
// Design      : SHA3_Absorb_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "SHA3_Absorb,Vivado 2020.2" *)
module SHA3_Absorb_0(message_in, round_constant, message_out)
/* synthesis syn_black_box black_box_pad_pin="message_in[199:0],round_constant[7:0],message_out[199:0]" */;
  input [199:0]message_in;
  input [7:0]round_constant;
  output [199:0]message_out;
endmodule
