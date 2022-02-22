// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
// Date        : Wed Jul 14 20:06:12 2021
// Host        : ubuntu running 64-bit Ubuntu 18.04.5 LTS
// Command     : write_verilog -force -mode synth_stub {/media/psf/Home/OneDrive/Summer SURE 2021/Secure
//               Boot/Vivado_Project/Calibration/Calibration.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v}
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_100, clk_50, clk_25, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_100,clk_50,clk_25,reset,locked,clk_in1" */;
  output clk_100;
  output clk_50;
  output clk_25;
  input reset;
  output locked;
  input clk_in1;
endmodule
