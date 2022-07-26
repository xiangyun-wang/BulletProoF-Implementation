-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (lin64) Build 3064766 Wed Nov 18 09:12:47 MST 2020
-- Date        : Mon Jun 13 15:01:48 2022
-- Host        : ubuntu running 64-bit Ubuntu 18.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top SHA3_Absorb_0 -prefix
--               SHA3_Absorb_0_ SHA3_Absorb_0_stub.vhdl
-- Design      : SHA3_Absorb_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SHA3_Absorb_0 is
  Port ( 
    message_in : in STD_LOGIC_VECTOR ( 199 downto 0 );
    round_constant : in STD_LOGIC_VECTOR ( 7 downto 0 );
    message_out : out STD_LOGIC_VECTOR ( 199 downto 0 )
  );

end SHA3_Absorb_0;

architecture stub of SHA3_Absorb_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "message_in[199:0],round_constant[7:0],message_out[199:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "SHA3_Absorb,Vivado 2020.2";
begin
end;
