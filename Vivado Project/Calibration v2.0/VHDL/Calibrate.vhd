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
-- Revision 1.00 - 2022/02/17 - Clean Up
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
    Data_out : out std_logic_vector(7 downto 0);
    MPS_sel : in std_logic_vector(5 downto 0)
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
signal reset : std_logic;


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

BUFG_inst : BUFG
 port map (
  O => MPSClk, -- 1-bit output: Clock output
  I => MPSClk_internal  -- 1-bit input: Clock input
 );

TPsel <= Testpath_sel;

MPSsel <= MPS_sel;
Data_out <= std_logic_vector(to_unsigned(TVal,8));
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
