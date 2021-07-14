----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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
-- 
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
           rst : in std_logic;
           MPSClk : out STD_LOGIC);
end MPS_Offset;

architecture Behavioral of MPS_Offset is

component LUT2 is 
    generic(
        INIT : bit_vector := "0010"
    );
    port(
        O : out std_logic;
        I0 : in std_logic;
        I1 : in std_logic
    );
end component;

type tap_points_structure is array(0 to 11) of integer;
signal tap_points: tap_points_structure := (
0 => 0,
1 => 2,
2 => 3,
3 => 5,
4 => 10,
5 => 15,
6 => 20,
7 => 25,
8 =>30,
9 =>35,
10 => 40,
11 => 49
);

signal status_out : std_logic_vector (49 downto 0);

begin

MPS_path : for i in 1 to 49 generate
    BUF: LUT2 port map(I0 => status_out(i-1),I1 => rst, O => status_out(i));
end generate;

first : LUT2 port map(I0 => Launch,I1 => rst, O => status_out(0));

MPSClk <= status_out(tap_points(to_integer(unsigned(MPSsel))));

end Behavioral;
