----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity RO is
    Port ( clk : out STD_LOGIC;
    check : out std_logic;
    rst : in std_logic);
end RO;

architecture Behavioral of RO is

component LUT2 is 
    generic(
        INIT : bit_vector := X"0001"
    );
    port(
        O : out STD_LOGIC;
        I0 : in STD_LOGIC;
        I1: in STD_LOGIC
    );
end component;

--signal output : std_logic;
signal status_out : std_logic_vector (30 downto 0);
signal internal_check : std_logic := '0';
--signal status_out : std_logic_vector(6 downto 0);
begin
clk <= status_out(30);
--ro_loop: for i in 1 to 30 generate
--    status_out(i) <= (not rst) and (not status_out(i-1));
--end generate;
--status_out(0) <= (not rst) and (not status_out(30));

ro_loop: for i in 0 to 29 generate
    flip: LUT2 port map (I0 => status_out(i),I1 => rst,O => status_out(i+1));
end generate;
first: LUT2 port map (I0 => status_out(30), I1 => rst, O=>status_out(0));

--status_out(0) <= (not rst) and (not status_out(6));
--status_out(1) <= (not rst) and (not status_out(0));
--status_out(2) <= (not rst) and (not status_out(1));
--status_out(3) <= (not rst) and (not status_out(2));
--status_out(4) <= (not rst) and (not status_out(3));
--status_out(5) <= (not rst) and (not status_out(4));
--status_out(6) <= (not rst) and (not status_out(5));
--clk <= status_out(6);

cnt:process (status_out(30))

    variable counter: integer := 0;

    begin

    if(rising_edge(status_out(30))) then
        counter := counter + 1;
    end if;

    if (counter = 5000) then
        counter := 0;
        internal_check <= not internal_check;
    end if;

end process;

check <= internal_check;

end Behavioral;
