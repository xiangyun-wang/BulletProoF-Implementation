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
-- Revision 3.00 - 2022/05/10 - TDC finished, may still need optimization. Need to work on Controller to make automation work
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
    Calibrated_Points : out std_logic_vector(5 downto 0); -- I/O 13 downto 8
    Debug_Out_1 : out std_logic;
    Debug_Out_2 : out std_logic; --led 0 b
    Debug_Out_3 : out std_logic;  -- led 1 b
    reset : in std_logic; -- sw 2
    Get_Calibrated_Points  : in std_logic; --btn 1
    --Debug_In_2  : in std_logic;

    Calibration : in std_logic; -- sw0
    Calibration_Finished : out std_logic; -- led 2 g

    Point_Sel : in std_logic_vector(5 downto 0);-- I/O 5 downto 0
    Launch : in std_logic;  --btn 0
    Signal_Measure : in std_logic;   -- signal to be measured -- sw 1

    --Measure_Succeed : out std_logic; -- led 7
    Delay_Out : out std_logic_vector(7 downto 0); -- IO 33 downto 26
    --Measure_TryNext : out std_logic; -- led 6
    --TDC_Reset : out std_logic := '0';
    --Measure_Fail : out std_logic;  -- led 3 r
    --Get_Measurement : in std_logic; -- btn 2

    Cal_Next_Step : in std_logic -- btn 3
    --vec_out : out std_logic
    --output : out std_logic
  );

end TDC;

architecture Behavioral of TDC is

type DATA is array (0 to 49) of std_logic_vector(0 to 31);
type CALFSM is (A,C,Finished,Idel);

signal Cal_Status : CALFSM := A;
signal Cal_Data : DATA;


-- Test Path signal
signal SWcon : std_logic_vector(31 downto 0);
signal Launch_TP  : std_logic;
signal TPsel : std_logic_vector(4 downto 0);
signal test_path_o  : std_logic;

-- carry chain signal
signal MPSClk: std_logic := '0';
signal path :  std_logic := '0';
signal CC_Over   : std_logic;
signal TVal :  integer := 0;

-- mps signal
signal MPSsel: std_logic_vector(5 downto 0);
signal MPSClk_Buffer : std_logic;
signal From_Testpath : std_logic;
signal Launch_MPS : std_logic;



--signal Measure_Tracker  : integer := 0;
signal check_index : integer := 0;
--debug signal
signal check : std_logic;
signal check_next : std_logic;
signal I : integer := 0;
signal J : integer := 0;
signal Point_Data_Collection_Finished : std_logic := '0';

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
    MPSsel : in STD_LOGIC_VECTOR (5 downto 0);  --mpssel
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

path <= test_path_o when Calibration = '1' else
        Signal_Measure;

MPSsel <= std_logic_vector(to_unsigned(J, 6)) when Calibration = '1' else
          Point_Sel;

TPsel <= std_logic_vector(to_unsigned(I, 5));

Delay_Out <= std_logic_vector(to_unsigned(TVal,8));

Calibrate_F: process (Cal_Next_Step,reset)

variable Point_Tracker : integer := 0;
variable Point_Selected : integer := 0;
variable Found_Next_Point : boolean := false;
variable First_Point_Found : boolean := false;
variable Final_Point_Tracker : integer := 0;
variable Tap_Points : std_logic_vector(0 to 83) := "100100100101100110100111101000101001101010101011101100101101101110101111110000110001";
variable point_start : integer := 0;

begin
  if reset = '1' then
    Cal_Status <= A;
    Debug_Out_1 <= '0';
    Debug_Out_2 <= '0';
    Calibration_Finished <= '0';
    --Delay_Out <= "00000000";
  elsif (rising_edge(Cal_Next_Step) and Calibration = '1') then
    case Cal_Status is
      when A =>
        Debug_Out_1 <= '1';
        Debug_Out_2 <= '0';
        if (TVal/=128) and (TVal/=0) then  -- need to think about condition
          Cal_Data(J)(I) <= '1';
          Debug_Out_3 <= '1';
        else
          Cal_Data(J)(I) <= '0';
          Debug_Out_3 <= '0';
        end if;

        --Debug_Out_2 <= '1';
        J <= J +1;
        if (J = 50) then
          J <= 0;
          I <= I +1;
        end if;
        -- upper level need a clock or need a handshake protocal
        if I < 5 then
          --Calibration_Finished <= '0';
          Cal_Status <= A;
        else
          --Calibration_Finished <= '1';
          Cal_Status <= C;
        end if;
      when C =>
        --Calibration_Finished <= '1';
        Debug_Out_1 <= '0';
        Debug_Out_2 <= '1';
        --Cal_Status <= Cal_Status;

        Point_Select_loop: for K in 0 to 49 loop
         -- exit loop condition
           exit when point_start > 83;
           if (not First_Point_Found) then
             if (Cal_Data(K)(Point_Tracker)='1') then
               Tap_Points(point_start to point_start+5) := std_logic_vector(to_unsigned(K,6));
               --Point_Tracker := Point_Tracker + 1;
               point_start := point_start+6;
               --point_end := point_end+6;
               First_Point_Found := true;
             end if;


           -- find first finish
           elsif (First_Point_Found) then
             if (Cal_Data(K)(Point_Tracker)='0') then
             -- tap point found
               Point_Selected := K-1;
               Tap_Points(point_start to point_start+5) := std_logic_vector(to_unsigned(Point_Selected,6));
               --Point_Tracker := Point_Tracker + 1;
               point_start := point_start+6;
               --point_end := point_end+6;
               --Point_Tracker := Point_Tracker + 1;
             end if;
           end if;
         end loop Point_Select_loop;
         point_start := 0;
         --point_end := 5;
         --Calibration_Finished <= '1';
         Cal_Status <= Finished;

       when Finished =>
         Debug_Out_1 <= '1';
         Debug_Out_2 <= '1';
         Calibrated_Points <= Tap_Points(point_start to point_start+5);
         point_start := point_start + 6;
         if point_start > 83 then
            point_start := 0;
            Cal_Status <= Idel;
         else
            Cal_Status <= Finished;
         end if;
       when others =>
         Cal_Status <= Cal_Status;
         Calibration_Finished <= '1';
         Debug_Out_1 <= '0';
         Debug_Out_2 <= '0';
    end case;
  end if;

end process Calibrate_F;



--when Calibration = '1' else
--           Tap_Points(Measure_Tracker);


-- need to reset after each time measured

-- after receving Measure_succeed or measure_fail, need to feed Launch with 0 and measure signal with 0 to reset TDC
-- once TDC is reset successfully, TDC_Reset flag will turn to '1', and the next challenge can be inserted
--Measure : process (Launch, MPSClk)
---- variable
--variable Measure_Tracker : integer := 0;
--begin
--  if (rising_edge(MPSClk) and Calibration = '0') then
--    if (Measure_Tracker>13) then
--      Measure_Tracker := 0;
--      Measure_Fail <= '1';
--    elsif (TVal/=128 and TVal/=0) then
--        Measure_Tracker := 0;
--        Measure_TryNext <= '0';
--        Measure_Succeed <= '1';
--        Measure_Fail <= '0';
--    elsif (TVal=128 or TVal=0) then
--        Measure_Tracker := Measure_Tracker+1;
--        Measure_TryNext <= '1';
--        Measure_Succeed <= '0';
--        Measure_Fail <= '0';
--    end if;
--  end if;

--end process Measure;

--Measure : process (Get_Measurement)
--variable Measure_Tracker : integer := 0;
--begin
  --if (rising_edge(Get_Measurement)) then
--    if (TVal /= 128 and TVal/=0) then
--      Measure_Tracker := 0;
--      Measure_TryNext <= '0';
--      Measure_Succeed <= '1';
--      Measure_Fail <= '0';
--    else
--      Measure_Tracker := Measure_Tracker + 1;
--      if Measure_Tracker = 13 then
--        Measure_Tracker := 0;
--        Measure_TryNext <= '0';
--        Measure_Succeed <= '0';
--        Measure_Fail <= '1';
--      else
--        --Measure_Tracker := Measure_Tracker + 1;
--        Measure_TryNext <= '1';
--        Measure_Succeed <= '0';
--        Measure_Fail <= '0';
--      end if;
--    end if;
  --end if;
 --end process Measure;

end Behavioral;
