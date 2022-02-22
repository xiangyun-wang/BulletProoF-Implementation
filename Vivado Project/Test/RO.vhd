----------------------------------------------------------------------------------
-- Company: McGill
-- Engineer: Xiangyun Wang
-- 
-- Create Date: 06/21/2021 05:23:41 PM
-- Design Name: 
-- Module Name: RO - Behavioral
-- Project Name: BulletProoF Secure Boot
-- Target Devices: Arty A7
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.00 - Ring Oscillator Working, file clean up
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity RO is
    Port ( clk : out STD_LOGIC;     -- this output an approximately 240MHz clock
    --check : out std_logic;
    rst : in std_logic);
end RO;

architecture Behavioral of RO is

component LUT2 is 
    generic(
        INIT : bit_vector := X"1"
    );
    port(
        O : out STD_LOGIC;
        I0 : in STD_LOGIC;
        I1: in STD_LOGIC
    );
end component;

signal status_out : std_logic_vector (6 downto 0);

begin

clk <= status_out(6);

ro_loop: for i in 0 to 5 generate
    flip: LUT2 port map (I0 => status_out(i),I1 => rst,O => status_out(i+1));
end generate;
first: LUT2 port map (I0 => status_out(6), I1 => rst, O=>status_out(0));


end Behavioral;
