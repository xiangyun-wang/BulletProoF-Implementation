library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity calibration_check is
  -- generic(
  -- -- constant
  -- );
  Port (
  Delay_Calibration : in std_logic_vector(7 downto 0);
  clk : in std_logic;

  Point_Sel_Calibration : out std_logic_vector(3 downto 0);
  TPsel : out std_logic_vector(4 downto 0);
  Launch_Calibration : out std_logic;
  Calibration_Check_Succeed : out std_logic := '0';
  Calibration_Check_Fail : out std_logic := '0'
  --debug_3 : out std_logic;
  --debug_1 : out std_logic;
  --debug_2 : out std_logic

  );

end calibration_check;

architecture Behavioral of calibration_check is
----------------------- component and signal declaration begins ----------------------

signal Calibration_Check : std_logic := '1';
signal tap_point_tracker : integer := 0;
signal test_path_tracker : integer := 0;

------ FSM --------
type CTL_CAL is (RESET_CAL, MEASURE, MEASURE_FINISH, CHECK, FIN);
signal Calibration_Check_Status : CTL_CAL := RESET_CAL;
------ FSM end ---------

------------------------- Component and Signal declaration ends --------------------

begin

------------- process begins -----------------
TPsel <= std_logic_vector(to_unsigned(test_path_tracker,5));
Point_Sel_Calibration <= std_logic_vector(to_unsigned(tap_point_tracker,4));

Calibration_Check_Process : process(clk)

variable suc0 : integer := 0;
begin
if rising_edge(clk) and Calibration_Check = '1'then
    case Calibration_Check_Status is
      when Reset_cal =>
        Launch_Calibration <= '0';
        --debug_1 <= '0';
        --debug_2 <= '0';
        --debug_3 <= '1';
        if tap_point_tracker = 16 then
          Calibration_Check_Status <= FIN;
          Calibration_Check_Fail <= '1';
          Calibration_Check_Succeed <= '0';
        else
          Calibration_Check_Status <= Measure;
        end if;
        if suc0 = 2 then
           suc0 := 0;
          tap_point_tracker <= 0;
        end if;
      when Measure =>
        Launch_Calibration <= '1';
        Calibration_Check_Status <= Measure_Finish;
      when Measure_Finish =>
        Launch_Calibration <= '0';
        Calibration_Check_Status <= Check;
      when Check =>
        Launch_Calibration <= '0';
        if Delay_Calibration = "10000000" and suc0 = 0 then
          -- go to the next tap point
          tap_point_tracker <= tap_point_tracker + 1; -- need to think about
          Calibration_Check_Status <= Reset_cal;
          -- go to reset
        elsif Delay_Calibration /= "10000000" and Delay_Calibration /= "00000000" then
          -- measure success, go to next tap point, reset and go to a new state
          suc0 := suc0 +1;
          --debug_3 <= '0';
          --debug_1 <= '1';
          if suc0 = 2 then
          --debug_2 <= '1';
            if test_path_tracker = 31 then
              Calibration_Check_Succeed <= '1';
              --Calibration_Check <= '0';
              Calibration_Check_Status <= FIN;
            else
              test_path_tracker <= test_path_tracker + 1;
              Calibration_Check_Status <= Reset_cal;
            end if;
          else
            tap_point_tracker <= tap_point_tracker + 1;
            Calibration_Check_Status <= Reset_cal;
          end if;
        else
          Calibration_Check_Fail <= '1';
          Calibration_Check_Status <= FIN;
        end if;
      when FIN =>
        Calibration_Check <= '0';
        Calibration_Check_Status <= Calibration_Check_Status;
      end case;
end if;
end process Calibration_Check_Process;


end Behavioral;
