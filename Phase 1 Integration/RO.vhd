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
    Port ( clk : out STD_LOGIC
    --check : out std_logic;
    --rst : in std_logic
    );
end RO;

architecture Behavioral of RO is

attribute dont_touch : boolean;


component LUT1 is
    generic(INIT : bit_vector := "01");
    port (
        O : out std_logic;
        I0 : in std_logic
    );
end component;

--signal output : std_logic;
signal status_out : std_logic_vector (30 downto 0);
signal clk_internal : std_logic := '0';
signal counter : integer := 0;
attribute dont_touch of status_out : signal is true;
attribute dont_touch of clk_internal : signal is true;
--signal osc : std_logic;
--signal status_out : std_logic_vector(6 downto 0);
begin
clk <= clk_internal;
--ro_loop: for i in 1 to 30 generate
--    status_out(i) <= (not rst) and (not status_out(i-1));
--end generate;
--status_out(0) <= (not rst) and (not status_out(30));

--ro_loop: for i in 0 to 29 generate
    --flip: LUT2 port map (I0 => status_out(i),I1 => rst,O => status_out(i+1));
--end generate;
--first: LUT2 port map (I0 => status_out(30), I1 => rst, O=>status_out(0));

--ro_loop: for i in 0 to 1 generate
--    flip: LUT1 port map (I0 => status_out(i),O => status_out(i+1));
--end generate;
--first: LUT1 port map (I0 => status_out(2), O=>status_out(0));

ro_loop: for i in 0 to 0 generate
    flip: LUT1 port map (I0 => status_out(i),O => status_out(i+1));
end generate;
--first: LUT1 port map (I0 => status_out(2), O=>status_out(0));

ro_delay: for i in 1 to 29 generate
    delay: LUT1 generic map (INIT => "10") port map (I0 => status_out(i), O => status_out(i+1));
end generate;
last : LUT1 generic map (INIT => "10") port map (I0 => status_out(30), O => status_out(0));

--status_out(0) <= (not rst) and (not status_out(6));
--status_out(1) <= (not rst) and (not status_out(0));
--status_out(2) <= (not rst) and (not status_out(1));
--status_out(3) <= (not rst) and (not status_out(2));
--status_out(4) <= (not rst) and (not status_out(3));
--status_out(5) <= (not rst) and (not status_out(4));
--status_out(6) <= (not rst) and (not status_out(5));
--clk <= status_out(6);

cnt:process (status_out(30))

    --variable counter: integer := 0;

    begin
      if rising_edge(status_out(30)) then
        if (counter = 300) then
          counter <= 0;
          clk_internal <= not clk_internal;
        else
          counter <= counter + 1;
        end if;
      
      end if;

end process;

--clk_internal <= status_out(6);

end Behavioral;
