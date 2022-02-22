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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity Calibrate is
  Port (
    test_out_1 : out std_logic;
    test_out_2 : out std_logic;
    launch : in std_logic;
    Config_sel : in std_logic_vector(2 downto 0);
    Testpath_sel : in std_logic_vector(4 downto 0);
    MPS_sel : in std_logic_vector(5 downto 0);
    
    address : in std_logic_vector(5 downto 0);
    write_en : in std_logic;
    Data_in : in std_logic_vector(7 downto 0);
    Data_out : out std_logic_vector (7 downto 0);
    Data_out_backup : out std_logic_vector (7 downto 0);
    reset : in std_logic
    --vec_out : out std_logic
    --output : out std_logic
  );
    
end Calibrate;

architecture Behavioral of Calibrate is

-- relay signals
signal SWcon : std_logic_vector(31 downto 0);
signal TPsel : std_logic_vector(4 downto 0);
signal path :  std_logic;
signal TVal :  integer;
signal mpsclk: std_logic;
signal MPSsel: std_logic_vector(5 downto 0);
signal mpsclk_internal : std_logic;

-- bram signals
signal DO:      std_logic_vector(7 downto 0);
signal ADDR :   std_logic_vector(11 downto 0);
signal DI :     std_logic_vector(7 downto 0);
signal EN :     std_ulogic := '1';
signal REGCE :  std_ulogic;
signal RST :    std_ulogic;
signal WE :     std_logic_vector(0 downto 0);


signal clk, clk_100, clk_50, clk_25, locked : std_logic;


component test_path is
 port(
    SWcon:          in std_logic_vector(31 downto 0);
    Launch:         in std_logic;
    TPsel:          in std_logic_vector(4 downto 0);
    
    test_path_o:     out std_logic);
end component;

component carry_chain is
 port(
    mpsclk      : in  std_logic;
    path        : in  std_logic;
    TVal        : out integer );
end component;

component MPS_Offset is
 port(
    MPSsel : in STD_LOGIC_VECTOR (5 downto 0);
    Launch : in STD_LOGIC;
    rst    : in std_logic;
    MPSClk : out STD_LOGIC);
end component;
        
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
 (
  clk_100          : out    std_logic;
  clk_50          : out    std_logic;
  clk_25          : out    std_logic;
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

testpath : test_path
 port map(
 SWcon => SWcon,
 Launch => Launch,
 TPsel => TPsel,
 test_path_o => path
 );

carrychain : carry_chain
 port map(
  mpsclk => mpsclk,
  path => path,
  TVal => TVal
 );
 
 MPSoffset : MPS_Offset
  port map(
  MPSsel => MPSsel,
  Launch => Launch,
  rst => reset,
  MPSClk=> mpsclk_internal
  );

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
 
BUFG_inst : BUFG
 port map (
  O => MPSClk, -- 1-bit output: Clock output
  I => MPSClk_internal  -- 1-bit input: Clock input
 );


WE(0) <= write_en;
DI <= data_in;
data_out_backup <= DO;
data_out <= std_logic_vector(to_unsigned(TVal,8));
ADDR <= "000000" & address;

TPsel <= Testpath_sel;

MPSsel <= MPS_sel;

test_out_1 <= path;
test_out_2 <= MPSClk;

SWcon <= "00000000000000000000000000000000" when (Config_sel = "000") else
         "10101010101010101010101010101010" when (Config_sel = "001") else
         "01010101010101010101010101010101" when (Config_sel = "010") else
         "00000000000000001111111111111111" when (Config_sel = "011") else
         "11111111111111110000000000000000" when (Config_sel = "100") else
         "11111111111111111111111111111111" when (Config_sel = "101") else
         "00011001100110010000001001100110" when (Config_sel = "110") else
         "00011001100110010000000100010100";
         
--SWcon <= "00000000000000000000000000000000";         
  
end Behavioral;
