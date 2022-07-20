--
-- Create Date: 06/21/2021 05:23:41 PM
-- Design Name:
-- Module Name: RO - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity mux200 is
    Port ( mux200_out : out STD_LOGIC;
    mux200_in : in std_logic_vector(199 downto 0);
    mux200_sel : in std_logic_vector(7 downto 0)
    );
end mux200;

architecture Behavioral of mux200 is

--signal output : std_logic;

--signal osc : std_logic;
--signal status_out : std_logic_vector(6 downto 0);
signal mux_layer0 : std_logic_vector(49 downto 0);
signal mux_layer1 : std_logic_vector(12 downto 0);
signal mux_layer2 : std_logic_vector(3 downto 0);
--signal counter : integer := 0;

begin

mux200_0: for i in 0 to 49 generate
      mux4to1_0: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
      port map(I0=>mux200_in(i*4+0), I1=>mux200_in(i*4+1), I2=>mux200_in(i*4+2), I3=>mux200_in(i*4+3),
      I4=>mux200_sel(0), I5=>mux200_sel(1), O=>mux_layer0(i));
end generate;
---------------------------------------------------------------------------------------------------
mux200_1: for i in 0 to 11 generate
      mux4to1_1: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
      port map(I0=>mux_layer0(i*4+0), I1=>mux_layer0(i*4+1), I2=>mux_layer0(i*4+2), I3=>mux_layer0(i*4+3),
      I4=>mux200_sel(2), I5=>mux200_sel(3), O=>mux_layer1(i));
end generate;

mux4to1_1_extra: LUT6
generic map (INIT => X"FF00F0F0CCCCAAAA")
port map(I0=>mux_layer0(48), I1=>mux_layer0(49), I2=>'0', I3=>'0',
I4=>mux200_sel(2), I5=>mux200_sel(3), O=>mux_layer1(12));
----------------------------------------------------------------------------------------------------------------------
mux200_2: for i in 0 to 2 generate
      mux4to1_2: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
      port map(I0=>mux_layer1(i*4+0), I1=>mux_layer1(i*4+1), I2=>mux_layer1(i*4+2), I3=>mux_layer1(i*4+3),
      I4=>mux200_sel(4), I5=>mux200_sel(5), O=>mux_layer2(i));
end generate;

mux4to1_2_extra: LUT6
generic map (INIT => X"FF00F0F0CCCCAAAA")
port map(I0=>mux_layer1(12), I1=>'0', I2=>'0', I3=>'0',
I4=>mux200_sel(4), I5=>mux200_sel(5), O=>mux_layer2(3));
----------------------------------------------------------------------------------------------------------------------
mux4to1_3_extra: LUT6
generic map (INIT => X"FF00F0F0CCCCAAAA")
port map(I0=>mux_layer2(0), I1=>mux_layer2(1), I2=>mux_layer2(2), I3=>mux_layer2(3),
I4=>mux200_sel(6), I5=>mux200_sel(7), O=>mux200_out);

--mux200_out <= mux200_in(to_integer(unsigned(mux200_sel)));

--clk_internal <= status_out(6);

end Behavioral;
