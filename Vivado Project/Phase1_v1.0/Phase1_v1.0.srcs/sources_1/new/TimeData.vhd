----------------------------------------------------------------------------------
-- Company: McGill
-- Engineer: Xiangyun Wang
--
-- Create Date: 07/20/2021 06:11:57 PM
-- Design Name:
-- Module Name: TimeData - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This file is for TDC integration
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

entity TimeData is
    Port (
    clk : in STD_LOGIC;
    Launch : in std_logic;
    to_CC : in std_logic;
    testpath_passed : out std_logic;
    finished : out std_logic;
    retry : out std_logic;
    Time_Measured : out STD_LOGIC_VECTOR (15 downto 0));
end TimeData;



architecture Behavioral of TimeData is

component test_path is
 port(
    SWcon:          in std_logic_vector(31 downto 0);
    Launch:         in std_logic;
    TPsel:          in integer;

    test_path_o:     out std_logic);
end component;

component carry_chain is
 port(
    mpsclk      : in  std_logic;
    path        : in  std_logic;
    finished    : out std_logic;
    retry       : out std_logic;
    TVal        : out integer );
end component;

component MPS_Offset is
 port(
    MPSsel : in std_logic_vector(7 downto 0);
    Launch : in std_logic;
    MPSClk : out STD_LOGIC);
end component;


type TimeData_state is (testpath_test, testpath_reset, time_data_generation);
signal state : TimeData_state := testpath_test;

type tap_point_selection is array (0 to 14) of std_logic_vector(5 downto 0);    -- need to modify to real tap points
signal chosen_tap_points : tap_point_selection := (
    "00000000",
    "00000010",
    "00000101",
    "00000111",
    "00001011",
    "00001111",
    "00010100",
    "00010111",
    "00011001",
    "00011100",
    "00011111",
    "00100000",
    "00100011",
    "00100101",
    "00101000"
);

signal tap_point_counter : integer range 0 to 14 := 0;

signal test_path_path : std_logic;
signal testpath_counter : integer range 0 to 32 := 0;
signal internal_launch : std_logic;

-- test path
signal SWcon : std_logic_vector(31 downto 0);
signal TPsel : integer := 0;
signal testpath_launch : std_logic;

-- Carry Chain
signal path, internal_finished,internal_retry : std_logic;
signal TVal : integer;

-- MPS
signal mpsclk : std_logic;
signal mpsclk_internal : std_logic;
signal MPSsel : std_logic_vector(7 downto 0);
signal Calsel : std_logic;

begin

testpath : test_path
 port map(
 SWcon => SWcon,
 Launch => testpath_Launch,
 TPsel => TPsel,
 test_path_o => test_path_path
 );

carrychain : carry_chain
 port map(
  mpsclk => mpsclk,
  path => path,
  finished => internal_finished,
  retry => internal_retry,
  TVal => TVal
 );

 MPSoffset : MPS_Offset
  port map(
  MPSsel => MPSsel,
  Launch => internal_launch,
  MPSClk=> mpsclk_internal
  );

BUFG_inst : BUFG
  port map(
    O => MPSClk,
    I => MPSClk_internal
  );

-- //////////////////////////////////////////////////////////////////////////////////////////////////
  -- logic to control TDC

 path <= test_path_path when Calsel = '1' else
         to_CC;

 Time_Measured <= std_logic_vector(to_unsigned(TVal,8))&MPSsel when (internal_finished = '1' and internal_retry = '0');

 process(internal_finished)
 begin
 if(internal_finished'event and internal_finished = '1') then
    if(internal_retry = '1' and tap_point_counter /= 14) then
        tap_point_counter <= tap_point_counter + 1;
    else
        tap_point_counter <= 0;
    end if;
 end if;
 end process;

process(internal_finished)

begin

  case state is
  when testpath_test =>
      testpath_launch <= '1';
      internal_launch <= '1';
      Calsel <= '1';
      if(internal_finished = '1') then
        state <= testpath_reset;
      elsif(testpath_counter = 31) then
        state <= time_data_generation;
      end if;
  when testpath_reset =>
       testpath_launch <= '0';
       internal_launch <= '0';
       if(internal_finished = '0') then
        state <= testpath_test;
       end if;
  when time_data_generation =>
        Calsel <= '0';
  end case;

end process;

testpath_passed <= '1' when testpath_counter = 31 else
                   '0';

testpath_counter <= testpath_counter +1 when (internal_finished = '1' and (internal_retry = '0' or tap_point_counter = 14) and TVal /= 0 and TVal /= 128);
TPsel <= testpath_counter;
-- //////////////////////////////////////////////////////////////////////////////////////////////////

retry <= '0' when (tap_point_counter = 14 and internal_retry = '1') else
         internal_retry;
finished <= internal_finished;
MPSsel <= chosen_tap_points(tap_point_counter);


end Behavioral;
