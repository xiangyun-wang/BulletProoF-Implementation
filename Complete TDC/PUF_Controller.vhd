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
  clk_debug : out std_logic;
  clk_manual : in std_logic;
  calibration_check_suc_debug : out std_logic;
  calibration_check_fail_debug : out std_logic;
  ICAP_msg_ready_debug : in std_logic;
  debug_1 : out std_logic;
  debug_2 : out std_logic;
  debug_3 : out std_logic;
  debug_v1 : out std_logic_vector(4 downto 0);
  debug_v2 : out std_logic_vector(3 downto 0);
  debug_delay : out std_logic_vector(7 downto 0);
  enrollment_mode : in std_logic
  --calibration_check : in std_logic
  );

end PUF_Controller;

architecture Behavioral of PUF_Controller is
----------------------- component and signal declaration begins ----------------------

attribute dont_touch : boolean;

component TDC is
 port(
   --reset : in std_logic; -- sw 2
   Calibration_Check_Succeed : in std_logic; -- sw0
   Point_Sel : in std_logic_vector(3 downto 0);-- I/O 5 downto 0
   TPsel : in std_logic_vector(4 downto 0);
   Launch : in std_logic;  --btn 0
   Signal_Measure : in std_logic;   -- signal to be measured -- sw 1
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

--------- need ring oscillator
component RO is
port
  (
      clk: out std_logic
      --rst : in std_logic
  );
end component;

component mux200 is
  port(
    mux200_out : out std_logic;
    mux200_in : in std_logic_vector(199 downto 0);
    mux200_sel : in std_logic_vector(7 downto 0)
  );
  end component;
  
component calibration_check is 
  port(
    Delay_Calibration : in std_logic_vector(7 downto 0);
    clk : in std_logic;

    Point_Sel_Calibration : out std_logic_vector(3 downto 0);
    TPsel : out std_logic_vector(4 downto 0);
    Launch_Calibration : out std_logic;
    Calibration_Check_Succeed : out std_logic;
    --debug_1 : out std_logic;
    --debug_2 : out std_logic;
    --debug_3 : out std_logic;
    Calibration_Check_Fail : out std_logic
  );
end component;
-- need to port ring oscillator and using vivado clk wizard to get deried frequency
-- how to estimate desire frequency???


signal Calibration_Check_Succeed : std_logic;
signal Calibration_Check_Fail : std_logic;

--signal Calibration_Check : std_logic := '1';
--signal tap_point_tracker : integer := 0;
--signal test_path_tracker : integer := 0;

signal round_cnt : integer := 0;
signal msg_request : std_logic;
signal out_mux_200to1 : integer := 0;
signal out_mux_200to1_vec : std_logic_vector(7 downto 0);

-- TDC signals
--signal Calibration_Check : std_logic := '0';
signal Point_Sel_Calibration: std_logic_vector(3 downto 0);
signal Point_Sel : std_logic_vector(3 downto 0);
signal TPsel : std_logic_vector(4 downto 0);
signal Launch : std_logic;
signal Launch_Calibration : std_logic;
signal Signal_Measure : std_logic;
signal Delay_Out : std_logic_vector(7 downto 0);

-- SHA3 signals
signal message_in_sha3 : std_logic_vector(199 downto 0);
signal message_out_sha3 : std_logic_vector(199 downto 0);
signal round_constant_sha3 : std_logic_vector(7 downto 0);
signal clk_ro : std_logic;
signal clk : std_logic;
--signal reset : std_logic;

signal v0 : std_logic_vector(199 downto 0);
signal v1 : std_logic_vector(199 downto 0) := (others => '0');
signal load_msg_flag : std_logic;
signal Launch_PUF : std_logic;
attribute dont_touch of Launch_PUF : signal is true;
------ not sure if this is input or internal signal -----
signal hash_mode : std_logic;
signal LaunchMUXCtrl : std_logic;
signal ICAP_msg : std_logic_vector(31 downto 0);
signal load_msg : std_logic_vector(71 downto 0);
signal msg_after_and : std_logic_vector(71 downto 0);

-- icap signals
signal ICAP_msg_ready : std_logic;
signal ICAP_msg_all_finished : std_logic;
signal Delay_Measure_Finished : std_logic := '0';
signal tap_point_tracker_PUF : integer := 0;

--signal Calibration_Complete : std_logic;

signal reset : std_logic;

signal padded : std_logic_vector(199 downto 0);
signal zeros : std_logic_vector(199 downto 0) := (others => '0');
signal clk_100, clk_20, clk_10 : std_logic;
------ end of not sure -----

------ FSM --------
type CTL_CAL is (RESET_CAL, MEASURE, MEASURE_FINISH, CHECK, FIN);
signal Calibration_Check_Status : CTL_CAL := RESET_CAL;

type CTL_STAT is (HASH, PUF0_0, PUF0_1,PUF_Delaunch, PUF1, SAVE, Idel, PUF_END);
signal Controller_Status : CTL_STAT := Idel;


------ FSM end ---------

------------------------- Component and Signal declaration ends --------------------

begin

----------------------- port map begins ------------------------

TDC_1 : TDC
  port map(
    Calibration_Check_Succeed => Calibration_Check_Succeed,
    Point_Sel => Point_Sel,
    TPsel => TPsel,
    Launch => Launch,
    Signal_Measure => Signal_Measure,
    Delay_Out => Delay_Out
  );

SHA3 : SHA3_Absorb
    port map(
      message_in => message_in_sha3,
      message_out => message_out_sha3,
      round_constant => round_constant_sha3

    );

kstate_1 : KState
  port map(
    Data_In => message_out_sha3,
    Data_Out => v0,
    reset => reset,
    clk => clk,
    hash_mode => hash_mode
  );

Ring_Osc : RO
  port map(
    clk => clk_ro
    --rst => reset

  );
  
mux200_1 : mux200
  port map(
    mux200_in => message_out_sha3,
    mux200_out => signal_measure,
    mux200_sel => out_mux_200to1_vec
  
  );
  
cal_check_1 : calibration_check
  port map(
    Delay_Calibration => Delay_out,
    clk => clk,
    Point_Sel_Calibration => Point_Sel_Calibration,
    TPsel => TPsel,
    Launch_Calibration => Launch_Calibration,
    Calibration_Check_Succeed => Calibration_Check_Succeed,
    --debug_1 => debug_1,
    --debug_2 => debug_2,
    --debug_3 => debug_3,
    Calibration_Check_Fail => Calibration_Check_Fail
  );


---------------------- port map ends ---------------------------

------------- process begins -----------------
Point_Sel <= Point_Sel_Calibration when Calibration_Check_Succeed = '0'
            else std_logic_vector(to_unsigned(tap_point_tracker_PUF,4));
--debug_v1 <= std_logic_vector(to_unsigned(out_mux_200to1,6));
debug_v1 <= TPsel;
debug_v2 <= Point_Sel;

--- hash mode process ----------
--debug_1 <= msg_request;
-- HASH_1 : process (clk_manual)
-- --variable tap_point_trakcer : integer := 0;
-- variable ICAP_PUF_sel : integer := 0;

-- begin

-- if rising_edge(clk_manual) and Calibration_Check_Succeed = '1' then
--   --Calibration_Check_Succeed <= '1';
--   case Controller_Status is
--     when Idel =>
       
--       Launch_PUF <= '0';
--       hash_mode <= '0';
--       reset <= '0';
--       LaunchMUXCtrl <= '1';
--       if ICAP_msg_all_finished = '1' then
--         reset <= '1';
--         Controller_Status <= PUF_END;
--         -- add more??
--       else
--         debug_2 <= '1';
--         if ICAP_msg_ready = '0' then
--           msg_request <= '1';
--           Controller_Status <= Idel;
--         else
--           msg_request <= '0';
--           ICAP_PUF_sel := (ICAP_PUF_sel + 1) mod 10;
--           if ICAP_PUF_sel = 0 then
--             Controller_Status <= PUF0_1;
--           else
--             Controller_Status <= PUF0_0;
--           end if;
--         end if;
--       end if;
--     --------------------------- this part might need a loop (begin) -------------
--     when PUF0_0 =>
--       debug_2 <= '0';
--       debug_3 <= '1';
--       LaunchMUXCtrl <= '0'; -- this is for naive PUF, only path B is measured
--       load_msg_flag <= '0'; -- do not want load_msg to be activated / may need further consideration
--       hash_mode <= '0';
--       reset <= '0';
--       Controller_Status <= PUF_Delaunch;
--       Launch_PUF <= '1';
--     when PUF0_1 =>
--       debug_2 <= '0';
--       debug_3 <= '1';
--       LaunchMUXCtrl <= '1';
--       load_msg_flag <= '1'; -- set load_msg to 1, so that signal can propagate fro ICAP to sha3 directly
--       hash_mode <= '0';
--       Controller_Status <= PUF_Delaunch;
--       Launch_PUF <= '1';
--       reset <= '0';
--     when PUF_Delaunch =>
--        debug_2 <= '0';
--        debug_3 <= '0';
--        Launch_PUF <= '0';
--        Controller_Status <= PUF1;
--     when PUF1 =>
--       LaunchMUXCtrl <= '1';
--       load_msg_flag <= '0'; -- do not want load_msg to be activated / may need further consideration
--       hash_mode <= '0';
--       Launch_PUF <= '0';
--       reset <= '0';
--       if Delay_Out /= "00000000" and Delay_Out /= "10000000" then
--         debug_2 <= '1';
--         debug_3 <= '1';
--         round_cnt <= 17;
--         Controller_Status <= SAVE;
--       else
--         tap_point_tracker_PUF <= tap_point_tracker_PUF + 1; -- need to change
--         if tap_point_tracker_PUF > 15 then -- need to change
--           round_cnt <= 17;
--           if (out_mux_200to1 = 71) then
             
--             Controller_Status <= HASH;
             
--           else
--             out_mux_200to1 <= out_mux_200to1 + 1;
--             if ICAP_PUF_sel = 0 then
--               Controller_Status <= PUF0_1;
--             else
--               Controller_Status <= PUF0_0;
--             end if;
--           end if;
--         else
--           if ICAP_PUF_sel = 0 then
--             Controller_Status <= PUF0_1;
--           else
--             Controller_Status <= PUF0_0;
--         end if;
--       end if;
--     end if;
--     when SAVE =>
--       -- some operation about save (wait how many cycles, addresses .....)
--       if out_mux_200to1 = 71 then
--         Controller_Status <= HASH;
--       else
--         out_mux_200to1 <= out_mux_200to1 + 1;
--         if ICAP_PUF_sel = 0 then
--             Controller_Status <= PUF0_1;
--           else
--             Controller_Status <= PUF0_0;
--         end if;
--       end if;
--     ------------ loop ends here -----------------------
--     when HASH =>
--       hash_mode <= '1';
--       reset <= '0';
--       out_mux_200to1 <= 0;
--       tap_point_tracker_PUF <= 0;
--       round_cnt <= (round_cnt + 1) mod 18;
--       if round_cnt = 17 then
--         Controller_Status <= Idel;
--       else
--         Controller_Status <= HASH;
--       end if;
--     when PUF_END => 
--       Controller_Status <= Controller_Status;
--       Delay_Measure_Finished <= '1';

--   end case;
--  end if;
-- end process HASH_1;

load_msg <= "111111111111111111111111111111111111111111111111111111111111111111111111" when load_msg_flag = '1' else
            "000000000000000000000000000000000000000000000000000000000000000000000000";
------- hash mode process end ---------

----------- process ends --------------

----- message to sha3 control
message_in_sha3 <=  v0 when (LaunchMUXCtrl = '0' and load_msg(0) = '0') else
                    v0 xor padded when (LaunchMUXCtrl = '0' and load_msg(0) = '1') else
                    v1 when (LaunchMUXCtrl = '1' and load_msg(0) = '0') else
                    v1 xor padded;

-- message padding logic (different than the paper implementation)
padded <= msg_after_and & zeros(127 downto 0);
-- load message logic
msg_after_and <= (ICAP_msg & ICAP_msg & ICAP_msg(31 downto 24)) and load_msg;

ICAP_msg <= "10101010101010101010101010101010";

out_mux_200to1_vec <= std_logic_vector(to_unsigned(out_mux_200to1,8));

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


 --clk <= clk_10;
 clk <= clk_ro;
 -- debug portion ---
 calibration_check_suc_debug <= Calibration_Check_Succeed;
 calibration_check_fail_debug <= Calibration_Check_Fail;
 Launch <= Launch_Calibration when Calibration_Check_Succeed = '0' else
            Launch_PUF;
 ICAP_msg_ready <= ICAP_msg_ready_debug;

debug_delay <= Delay_Out;

end Behavioral;
