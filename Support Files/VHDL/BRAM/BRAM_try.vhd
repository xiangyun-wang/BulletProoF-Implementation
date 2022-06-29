----------------------------------------------------------------------------------
-- Company: McGill University
-- Engineer: Xiangyun Wang
-- 
-- Create Date: 06/29/2021 08:24:07 AM
-- Design Name: Block RAM try and test
-- Module Name: BRAM_try - Behavioral
-- Project Name: 
-- Target Devices: Arty A7
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity BRAM_try is
  Port (
    CLK : in std_logic;
    vec_out : out std_logic;
    output : out std_logic
  );
    
end BRAM_try;

architecture Behavioral of BRAM_try is

signal DO:      std_logic_vector(7 downto 0);
signal ADDR :   std_logic_vector(11 downto 0) := "000000000000";

--signal CLK :    std_logic;
--constant clk_period : time := 1000000000 ns;

signal DI :     std_logic_vector(7 downto 0);
signal EN :     std_ulogic := '1';
signal REGCE :  std_ulogic;
signal RST :    std_ulogic;
signal WE :     std_logic_vector(0 downto 0) := "0";

signal CLK_100, clk_25, locked : std_logic;
signal reset : std_logic := '0';

signal v1, v2, v3 : std_logic_vector(7 downto 0);
        
component BRAM_test is
    port(
        DO :    out std_logic_vector(7 downto 0);
        ADDR :  in std_logic_vector(11 downto 0);
        CLK :   in std_ulogic;
        DI :    in std_logic_vector(7 downto 0);
        EN :    in std_ulogic;
        REGCE : in std_ulogic;
        RST :   in std_ulogic;
        WE :    in std_logic_vector(0 downto 0)
    );
end component;

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  CLK_100          : out    std_logic;
  clk_25          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  locked            : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;



begin

storage: BRAM_test
    port map(
        DO => DO,
        ADDR => ADDR,
        CLK => clk_25,
        DI => DI,
        EN => EN,
        REGCE => REGCE,
        RST => RST,
        WE => WE
    );
    
your_instance_name : clk_wiz_0
   port map ( 
  -- Clock out ports  
   CLK_100 => CLK_100,
   clk_25 => clk_25,
  -- Status and control signals                
   reset => reset,
   locked => locked,
   -- Clock in ports
   clk_in1 => CLK
 );
    
--clk_process : process
--begin
   -- CLK <= '0';
    --wait for clk_period/2;
    --CLK <= '1';
    --wait for clk_period/2;
--end process;

--try_process : process

--variable counter : integer := 0;

--begin
--    EN <= '1';
--    WE <= "1";
--    ADDR <= "000000000000";
--    DI <= "00000001";
--    --wait for clk_period;

--    ADDR <= "000000000001";
--    DI <= "00000010";
--    --wait for clk_period;
    
--    EN <= '1';
--    WE <= "0";
--    ADDR <= "000000000000";
--    --wait for clk_period;
--    v1 <= DO;
--    --wait for clk_period;
    
--    ADDR <= "000000000001";
--    --wait for clk_period;
--    v2 <= DO;
--    --wait for clk_period;
    
--END process;

output <= clk_25;

vec_out <= DO(0);

end Behavioral;
