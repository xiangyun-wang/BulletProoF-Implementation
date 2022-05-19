library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity PUF_Controller is
  -- generic(
  -- -- constant
  -- );
  Port (
  enrollment_mode : in std_logic;
  Need_Calibration : in std_logic;
  --hash_mode : in std_logic;
  reset : in std_logic
  --load_msg : in std_logic_vector(71 downto 0);
  --clk : in std_logic
  --LaunchMUXCtrl : in std_logic;
  --round_cnt : in integer
  );

end PUF_Controller;

architecture Behavioral of PUF_Controller is
----------------------- component and signal declaration begins ----------------------

component TDC is
 port(
   reset : in std_logic; -- sw 2
   Get_Calibrated_Points  : in std_logic; --btn 1
   Calibration : in std_logic; -- sw0
   Point_Sel : in std_logic_vector(5 downto 0);-- I/O 5 downto 0
   Launch : in std_logic;  --btn 0
   Signal_Measure : in std_logic;   -- signal to be measured -- sw 1
   Cal_Next_Step : in std_logic;

   Calibrated_Points : out std_logic_vector(5 downto 0); -- I/O 13 downto 8
   Calibration_Finished : out std_logic; -- led 2 g
   Delay_Out : out std_logic_vector(7 downto 0) -- IO 33 downto 26

   );
end component;

component SHA3_Absorb is
 port(
  message_in: in std_logic_vector (199 downto 0);
  round_constant: in std_logic_vector (7 downto 0);  -- all the round constant will be stored in the upper level hdl file
  message_out: out std_logic_vector(199 downto 0)
    );
end component;

component KState is
  port(
  Data_In : in std_logic_vector(199 downto 0);
  reset : in std_logic;
  clk : in std_logic;
  hash_mode : in std_logic;
  Data_Out : out std_logic_vector(199 downto 0)
  );
end component;


signal TDC_reset : std_logic;
signal Get_Calibrated_Points : std_logic;
signal Calibration : std_logic;
signal Point_Sel : std_logic_vector(5 downto 0);
signal Launch : std_logic;
signal Signal_Measure : std_logic;
signal Cal_Next_Step : std_logic;
signal Calibrated_Points : std_logic_vector(5 downto 0);
signal Calibration_Finished : std_logic;
signal Delay_Out : std_logic_vector(7 downto 0);

signal message_in_sha3 : std_logic_vector(199 downto 0);
signal message_out_sha3 : std_logic_vector(199 downto 0);
signal round_constant_sha3 : std_logic_vector(7 downto 0);
signal reset : std_logic;

signal v0 : std_logic_vector(199 downto 0);
signal v1 : std_logic_vector(199 downto 0) := (others => '0');

------ not sure if this is input or internal signal -----
signal hash_mode : std_logic;
signal LaunchMUXCtrl : std_logic;
signal ICAP_msg : std_logic_vector(31 downto 0);
signal load_msg : std_logic_vector(71 downto 0);
signal msg_after_and : std_logic_vector(71 downto 0);

signal ICAP_msg_ready : std_logic;
signal ICAP_msg_all_finished : std_logic;

signal Calibration_Complete : std_logic;
------ end of not sure -----

------ FSM --------
type CTL_CAL is (Idel, RESET, GO, NEX, DATA_FIN, FIND_FIN_GET_STA, SAVE, VOID);
signal Calibration_Status : CTL_CAL := Idel;

type CTL_STAT is (HASH, PUF0_0, PUF0_1, PUF1, SAVE, Idel);
signal Controller_Status : CTL_STAT := Idel;

signal tap_point_tracker : integer := 0;
signal tap_point_bank : std_logic_vector(0 to 83);
signal round_cnt : integer := 0;
signal msg_request : std_logic;
------ FSM end ---------

------------------------- Component and Signal declaration ends --------------------

begin

----------------------- port map begins ------------------------

TDC : TDC
  port map(
    reset => TDC_reset,
    Get_Calibrated_Points => Get_Calibrated_Points,
    Calibration => Calibration,
    Point_Sel => Point_Sel,
    Launch => Launch,
    Signal_Measure => Signal_Measure,
    Cal_Next_Step => clk,

    Calibrated_Points => Calibrated_Points,
    Calibration_Finished => Calibration_Finished,
    Delay_Out => Delay_Out
  );

SHA3 : SHA3_Absorb
    port map(
      message_in => message_in_sha3,
      message_out => message_out_sha3,
      round_constant => round_constant_sha3

    );

kstate : KState
  port map(
    Data_In => message_out_sha3,
    Data_Out => v0,
    reset => reset,
    clk => clk,
    hash_mode => hash_mode
  );

---------------------- port map ends ---------------------------

------------- process begins -----------------
Calibration : process (clk)
variable counter : integer := 0;
variable reset_counter : integer := 0;
begin
if rising_edge(clk) then
  case Calibration_Status is
    when Idel =>
      if enrollment_mode = '1' then
        counter := 0;
        Calibration= '1'
        Calibration_Status <= RESET;
      end if;
    when RESET =>
      TDC_reset = '1';
      -- wait for a few clock cc
      if reset_counter < 5 then
        Calibration_Status <= RESET;
        reset_counter := reset_counter + 1;
      else
        reset_counter := 0;
        Calibration_Status <= RUN;
      end if;
    when RUN =>
      TDC_reset = '0';
      Launch <= '1';
      Cal_Next_Step <= '0';
      if counter > 1599 then
        Calibration_Status <= DATA_FIN;
      else
        Calibration_Status <= NXT;
      end if;
    when NXT =>
      TDC_reset = '0';
      Launch <= '0';
      Cal_Next_Step <= '1';
      -- need a counter for this
      -- after counter reaches certain value, it will jump to next stage
      counter := counter + 1;
      Calibration_Status <= RUN;
    when DATA_FIN =>
      -- wait for a few cc, to let the system find the proper points
      Cal_Next_Step <= '0';

      Calibration_Status <= FIND_FIN_GET_STA;
    when FIND_FIN_GET_STA =>
      Cal_Next_Step <= '1';
      -- setup a counter to save and come back
      Calibration_Status <= SAVE;
      -- if get counter > certain number, go to last state : void
      Calibration_Status <= VOID;
    when SAVE =>
      Cal_Next_Step <= '0';
      -- if certain contion is satisfied
      Calibration_Status <= FIND_FIN;
    when others =>
      Calibration <= '1'
      Calibration_Status <= Calibration_Status;
    end case;

end if;

end process Calibration;


------- hash mode process ----------
HASH : process (clk)
variable tap_point_trakcer : integer := 0;
variable ICAP_PUF_sel : integer := 0;
begin

if rising_edge(clk) and Calibration_Complete = '1' then
  case Controller_Status is
    when Idel =>
      Launch <= '0';
      hash_mode <= '0';
      reset <= '0';
      if ICAP_msg_all_finished = '1' then
        reset = '1';
      else
        if ICAP_msg_ready = '0' then
          msg_request <= '1';
          Controller_Status <= Idel
        else
          msg_request <= '0';
          ICAP_PUF_sel := (ICAP_PUF_sel + 1) mod 10;
          if ICAP_PUF_sel = 0 then
            Controller_Status <= PUF0_1;
          else
            Controller_Status <= PUF0_0;
          end if;
        end if;
      end if;
    --------------------------- this part might need a loop (begin) -------------
    when PUF0_0 =>
      LaunchMUXCtrl <= '0'; -- this is for naive PUF, only path B is measured
      round_cnt <= 1; -- do not want load_msg to be activated / may need further consideration
      hash_mode <= '0';
      reset <= '0';
      Controller_Status <= PUF1;
      Launch <= '1';
    when PUF0_1 =>
      LaunchMUXCtrl <= '1';
      round_cnt <= '0'; -- set load_msg to 1, so that signal can propagate fro ICAP to sha3 directly
      hash_mode <= '0';
      Controller_Status <= PUF1
      Launch <= '1';
      reset <= '0';
    when PUF1 =>
      LaunchMUXCtrl <= '1'; -- this is for naive PUF, only path B is measured
      round_cnt <= 1; -- do not want load_msg to be activated / may need further consideration
      hash_mode <= '0';
      Launch <= '0';
      reset <= '0';
      if Delay_Out /= "00000000" or Delay_Out /= "10000000" then
        round_cnt <= 17;
        Controller_Status <= SAVE;
      else
        tap_point_trakcer <= tap_point_trakcer + 6;
        if tap_point_trakcer > 83 then
          round_cnt <= 17;
          Controller_Status <= HASH;
          tap_point_tracker <= 0;
        else
          if ICAP_PUF_sel = 0 then
            Controller_Status <= PUF0_1;
          else
            Controller_Status <= PUF0_0;
        end if;
      end if;
    end if;
    when SAVE =>
      -- some operation about save (wait how many cycles, addresses .....)
      Controller_Status <= HASH;
    ------------ loop ends here -----------------------
    when HASH =>
      hash_mode <= '1';
      reset <= '0';
      round_cnt <= (round_cnt + 1) mod 18;
      if round_cnt = 17 then
        Controller_Status <= Idel;
      else
        Controller_Status <= HASH;
      end if;

  end case;
 end if;
end process HASH;

Point_Sel <= tap_point_bank(tap_point_tracker to tap_point_trakcer+5);

load_msg <= "111111111111111111111111111111111111111111111111111111111111111111111111" when round_cnt = 0 else
            "000000000000000000000000000000000000000000000000000000000000000000000000";
------- hash mode process end ---------

---------- PUF mode process begin ----------------
PUF : process (clk)
begin

end process PUF;
 ----------- PUF mode process end -------
----------- process ends --------------

----- message to sha3 control
message_in_sha3 <=  v0 when (LaunchMUXCtrl = '0' and load_msg(0) = '0') else
                    v0 xor padded (LaunchMUXCtrl = '0' and load_msg(0) = '1') else
                    v1 when (LaunchMUXCtrl = '1' and load_msg(0) = '0') else
                    v1 xor padded;

-- message padding logic (different than the paper implementation)
padded <= msg_after_and & msg_after_and & msg_after_and(31 downto 24) & zeros(127 downto 0);
-- load message logic
msg_after_and <= ICAP_msg and load_msg;

Calibration_Complete <= Calibration_Finished when (enrollment_mode = '1') else
                    <= '1';

round_constant_sha3 <= "00000001" when (round_cnt = 0) else
                      "10000010" when (round_cnt = 1) else
                      "10001010" when (round_cnt = 2) else
                      "00000000" when (round_cnt = 3) else
                      "10001011" when (round_cnt = 4) else
                      "00000001" when (round_cnt = 5) else
                      "10000001" when (round_cnt = 6) else
                      "00001001" when (round_cnt = 7) else
                      "10001010" when (round_cnt = 8) else
                      "10001000" when (round_cnt = 9) else
                      "00001001" when (round_cnt = 10) else
                      "00001010" when (round_cnt = 11) else
                      "10001011" when (round_cnt = 12) else
                      "10001011" when (round_cnt = 13) else
                      "10001001" when (round_cnt = 14) else
                      "00000011" when (round_cnt = 15) else
                      "00000010" when (round_cnt = 16) else
                      "10000000" when (round_cnt = 17) else
                      "11111111";

end Behavioral;
