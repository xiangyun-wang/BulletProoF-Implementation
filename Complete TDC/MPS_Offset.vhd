----------------------------------------------------------------------------------
-- Company:
-- Creator: Xiangyun Wang
--
-- Create Date: 06/30/2021 09:26:44 AM
-- Design Name:
-- Module Name: MPS_Offset - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.00 - 2022/02/17 - Clean Up
-- Additional Comments:
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity MPS_Offset is
    Port ( MPSsel : in STD_LOGIC_VECTOR (3 downto 0);
           Launch : in STD_LOGIC;
           MPSClk : out STD_LOGIC);
end MPS_Offset;

architecture Behavioral of MPS_Offset is

component LUT1 is
    generic(INIT : bit_vector := "10");
    port (
        O : out std_logic;
        I0 : in std_logic
    );
end component;

signal status_out : std_logic_vector (63 downto 0);
signal MPS_MUX_4_to_1_output : std_logic_vector (3 downto 0);

begin

MPS_path : for i in 1 to 63 generate
    BUF: LUT1 port map(I0 => status_out(i-1), O => status_out(i));
end generate;
status_out(0) <= Launch;

--if the overlap is zero then exit and print an error message.
     selection0_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
--      port map(I0=>status_out(10), I1=>status_out(14), I2=>status_out(18), I3=>status_out(22),
      port map(I0=>status_out(5), I1=>status_out(8), I2=>status_out(12), I3=>status_out(15),
        I4=>MPSsel(0), I5=>MPSsel(1), O=>MPS_MUX_4_to_1_output(0));
     selection1_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
--      port map(I0=>status_out(26), I1=>status_out(29), I2=>status_out(32), I3=>status_out(36),
      port map(I0=>status_out(19), I1=>status_out(22), I2=>status_out(26), I3=>status_out(29),
        I4=>MPSsel(0), I5=>MPSsel(1), O=>MPS_MUX_4_to_1_output(1));
     selection2_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
--      port map(I0=>status_out(38), I1=>status_out(41), I2=>status_out(45), I3=>status_out(49),
      port map(I0=>status_out(33), I1=>status_out(36), I2=>status_out(40), I3=>status_out(43),
        I4=>MPSsel(0), I5=>MPSsel(1), O=>MPS_MUX_4_to_1_output(2));
        
        selection3_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
--      port map(I0=>status_out(38), I1=>status_out(41), I2=>status_out(45), I3=>status_out(49),
      port map(I0=>status_out(47), I1=>status_out(50), I2=>status_out(54), I3=>status_out(57),
        I4=>MPSsel(0), I5=>MPSsel(1), O=>MPS_MUX_4_to_1_output(3));
-- Last 4-to-1 MUX selects one of the 3 outputs from the 4-to-1 MUXs.
     selection4_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
      port map(I0=>MPS_MUX_4_to_1_output(0), I1=>MPS_MUX_4_to_1_output(1), I2=>MPS_MUX_4_to_1_output(2), I3=>MPS_MUX_4_to_1_output(3),
        I4=>MPSsel(2), I5=>MPSsel(3), O=>MPSClk);

--MPSClk <= status_out(to_integer(unsigned(MPSsel))+1);

end Behavioral;
