----------------------------------------------------------------------------------
-- Company: McGill
-- Engineer: Xiangyun Wang
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
-- Additional Comments:

----------------------------------------------------------------------------------

-- need to finish by 8/11

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
    Port ( MPSsel : in STD_LOGIC_VECTOR (7 downto 0); -- to select tap points
           Launch : in STD_LOGIC;                     -- launch signal
           MPSClk : out STD_LOGIC);                   -- major phase shift clock out signal
end MPS_Offset;

architecture Behavioral of MPS_Offset is

component LUT1 is
    generic(INIT : bit_vector := "10");       -- when input is 1, output is bitvector(1) = '1'; when input is 0, output is bitvector(0) = '0'
    port (
        O : out std_logic;
        I0 : in std_logic
    );
end component;


signal status_out : std_logic_vector (50 downto 0);   -- status for 50 lut1

begin

MPS_path : for i in 1 to 50 generate        -- map status array to lut1s
    BUF: LUT1 port map(I0 => status_out(i-1), O => status_out(i));
end generate;
status_out(0) <= Launch;

MPSClk <= status_out(to_integer(unsigned(MPSsel))+1);   -- get MPSClk signal from desired tap points

end Behavioral;
