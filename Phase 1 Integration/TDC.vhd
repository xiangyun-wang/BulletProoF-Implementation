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
-- Revision 2.00 - 2022/05/10 - Calibration Automation
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

entity TDC is
  -- generic(
  -- -- constant
  -- );
  Port (
  -- debug ports
    --reset : in std_logic; -- sw 2
    --Get_Calibrated_Points  : in std_logic; --btn 1
    --Calibrated_Points : out std_logic_vector(5 downto 0); -- I/O 13 downto 8
    --Debug_Out_1 : out std_logic;
    --Debug_Out_2 : out std_logic; --led 0 b
    --Debug_Out_3 : out std_logic;  -- led 1 b


    Calibration_Check_Succeed : in std_logic; -- sw0
    --Calibration_Finished : out std_logic; -- led 2 g

    Point_Sel : in std_logic_vector(3 downto 0);-- I/O 5 downto 0
    Launch : in std_logic;  --btn 0
    Signal_Measure : in std_logic;   -- signal to be measured -- sw 1

    Delay_Out : out std_logic_vector(7 downto 0); -- IO 33 downto 26
    TPsel : in std_logic_vector(4 downto 0);
    path_debug : out std_logic

    --Cal_Next_Step : in std_logic -- btn 3

  );

end TDC;

architecture Behavioral of TDC is

-- Test Path signal
signal SWcon : std_logic_vector(31 downto 0);
signal Launch_TP  : std_logic;
--signal TPsel : std_logic_vector(4 downto 0);
signal test_path_o  : std_logic;

-- carry chain signal
signal MPSClk: std_logic := '0';
signal path :  std_logic := '0';
--signal CC_Over   : std_logic;
signal TVal :  integer := 0;

-- mps signal
signal MPSsel: std_logic_vector(3 downto 0);
signal MPSClk_Buffer : std_logic;
signal From_Testpath : std_logic;
signal Launch_MPS : std_logic;


component Test_Path is
 port(
    SWcon:          in std_logic_vector(31 downto 0); --swcon
    Launch:         in std_logic;                     -- Launch_TP
    TPsel:          in std_logic_vector(4 downto 0);  -- TPsel
    test_path_o:     out std_logic);                  --test_path_o
end component;

component Carry_Chain is
 port(
    mpsclk      : in  std_logic;  -- MPSClk
    path        : in  std_logic;  -- path
    --Over        : out std_logic;  -- CC_Over
    TVal        : out integer );  --TVal
end component;

component MPS_Offset is
 port(
    MPSsel : in STD_LOGIC_VECTOR (3 downto 0);  --mpssel
    Launch : in STD_LOGIC;    --Launch_MPS
    MPSClk : out STD_LOGIC);  --MPSClk_buffer
end component;

begin

testpath : Test_Path
 port map(
 SWcon => SWcon,
 Launch => Launch,
 TPsel => TPsel,
 test_path_o => test_path_o
 );

carrychain : Carry_Chain
 port map(
  mpsclk => mpsclk,
  path => path,
  --Over => CC_Over,
  TVal => TVal
 );

 MPSoffset : MPS_Offset
  port map(
  MPSsel => MPSsel,
  Launch => Launch,
  MPSClk=> MPSClk_Buffer
  );

BUFG_inst : BUFG
 port map (
  O => MPSClk, -- 1-bit output: Clock output
  I => MPSClk_Buffer  -- 1-bit input: Clock input
 );


SWcon <= "10000000000000000000000000000001";

path <= signal_measure when Calibration_Check_Succeed = '1' else
        test_path_o;

MPSsel <= Point_Sel;

path_debug <= path;

Delay_Out <= std_logic_vector(to_unsigned(TVal,8));

end Behavioral;
