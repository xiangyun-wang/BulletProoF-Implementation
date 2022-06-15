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

component LUT1 is
    generic(INIT : bit_vector := "01");
    port (
        O : out std_logic;
        I0 : in std_logic
    );
end component;

--signal output : std_logic;

--signal osc : std_logic;
--signal status_out : std_logic_vector(6 downto 0);
begin

mux200_out <= mux200_in(to_integer(unsigned(mux200_sel)));

--clk_internal <= status_out(6);

end Behavioral;
