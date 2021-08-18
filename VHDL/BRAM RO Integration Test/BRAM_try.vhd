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
    address : in std_logic_vector(11 downto 0);
    write_en : in std_logic;
    Data_in : in std_logic_vector(7 downto 0);
    Data_out : out std_logic_vector (7 downto 0);
    reset : in std_logic
    --vec_out : out std_logic
    --output : out std_logic
  );
    
end BRAM_try;

architecture Behavioral of BRAM_try is

signal DO:      std_logic_vector(7 downto 0);
signal ADDR :   std_logic_vector(11 downto 0); --:= "000000000000";

signal DI :     std_logic_vector(7 downto 0);
signal EN :     std_ulogic := '1';
signal REGCE :  std_ulogic;
signal RST :    std_ulogic;
signal WE :     std_logic_vector(0 downto 0);


signal clk, clk_100, clk_50, clk_25, locked : std_logic;

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
  clk_100          : out    std_logic;
  clk_50          : out    std_logic;
  clk_25          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;
  locked            : out    std_logic;
  clk_in1           : in     std_logic
 );
end component;

component RO
port
 (
  clk : out STD_LOGIC;
  rst : in std_logic
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
    
clk_generator : clk_wiz_0
   port map ( 
  -- Clock out ports  
   CLK_100 => clk_100,
   clk_50 => clk_50,
   clk_25 => clk_25,
  -- Status and control signals                
   reset => reset,
   locked => locked,
   -- Clock in ports
   clk_in1 => clk
 );
 
 Ring_Osc : RO
   port map (
   clk => clk,
   rst => reset
   );





--cnt:process (clk_25)
--    variable counter: integer := 0;
--    begin
--    if(rising_edge(clk_25)) then
--        counter := counter + 1;
--    end if;
--    if (counter = 5000) then
--        counter := 0;
--        check_internal <= not check_internal;
--    end if;
--end process;
--output <= check_internal;

WE(0) <= write_en;
DI <= data_in;
data_out <= DO;
ADDR <= address;

end Behavioral;
