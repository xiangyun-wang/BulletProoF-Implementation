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
  clk_manual : in std_logic;
  calibration_check_suc_debug : out std_logic;
  calibration_check_fail_debug : out std_logic;
  ICAP_msg_ready_debug : in std_logic;
  ICAP_msg_request_debug : out std_logic;
  ICAP_msg_all_finished_debug : in std_logic;
  debug_1 : out std_logic;
  debug_2 : out std_logic;
  debug_3 : out std_logic;
  debug_v1 : out std_logic_vector(4 downto 0);
  debug_v2 : out std_logic_vector(3 downto 0);
  debug_delay : out std_logic_vector(7 downto 0);
  ICAP_msg : in std_logic_vector(31 downto 0);
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

component PUF_Function is
  Port (
    clk : in std_logic;
    ICAP_msg_all_finished : in std_logic;
    ICAP_msg_ready: in std_logic;
    ICAP_msg : in std_logic_vector(31 downto 0);
    ICAP_msg_request : out std_logic;
    Delay_PUF : in std_logic_vector(7 downto 0);
    Calibration_Check_Succeed : in std_logic;
    --debug_msg_in : out std_logic_vector(199 downto 0);
    --debug_msg_out : out std_logic_vector(199 downto 0);
    signal_measure : out std_logic;
    Point_Sel_PUF : out std_logic_vector(3 downto 0);
    --debug_hash : out std_logic_vector(199 downto 0);
    
    --debug_round_constant : out std_logic_vector(7 downto 0);
    Launch_PUF : out std_logic
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

-- TDC signals
--signal Calibration_Check : std_logic := '0';
signal Point_Sel_Calibration: std_logic_vector(3 downto 0);
signal Point_Sel_PUF : std_logic_vector(3 downto 0);
signal Point_Sel : std_logic_vector(3 downto 0);
signal TPsel : std_logic_vector(4 downto 0);
signal Launch : std_logic;
signal Launch_Calibration : std_logic;
signal Signal_Measure : std_logic;
signal Delay_Out : std_logic_vector(7 downto 0);
signal ICAP_msg_ready : std_logic;
--signal ICAP_msg : std_logic_vector(31 downto 0);
signal ICAP_msg_request : std_logic;
-- SHA3 signals
signal message_in_sha3 : std_logic_vector(199 downto 0);
signal message_out_sha3 : std_logic_vector(199 downto 0);
signal round_constant_sha3 : std_logic_vector(7 downto 0);
signal clk_ro : std_logic;
signal clk : std_logic;
signal ICAP_msg_all_finished : std_logic;
--signal reset : std_logic;

signal Launch_PUF : std_logic;
--attribute dont_touch of Launch_PUF : signal is true;

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

Ring_Osc : RO
  port map(
    clk => clk_ro
    --rst => reset

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
  
PUF_1 : PUF_Function
port map(
  clk => clk_manual,
  ICAP_msg_all_finished => ICAP_msg_all_finished,
  ICAP_msg_ready => ICAP_msg_ready,
  ICAP_msg => ICAP_msg,
  Delay_PUF => Delay_out,
  Calibration_Check_Succeed  => Calibration_Check_Succeed,
  ICAP_msg_request => ICAP_msg_request,
  signal_measure => signal_measure,
  Point_Sel_PUF => Point_Sel_PUF,
  Launch_PUF => Launch_PUF


  --debug_1 => debug_1,
  --debug_2 => debug_2,
  --debug_3 => debug_3,
  --debug_v1 => debug_v1,
  --debug_v2 => debug_v2
  );


---------------------- port map ends ---------------------------

------------- process begins -----------------
Point_Sel <= Point_Sel_Calibration when Calibration_Check_Succeed = '0' else
            Point_Sel_PUF;
            
Launch <= Launch_Calibration when Calibration_Check_Succeed = '0' else
            Launch_PUF;
------- hash mode process end ---------

----------- process ends --------------

----- message to sha3 control




 --clk <= clk_10;
 clk <= clk_ro;
 
 -- debug portion ---
 calibration_check_suc_debug <= Calibration_Check_Succeed;
 calibration_check_fail_debug <= Calibration_Check_Fail;

            
 ICAP_msg_ready <= ICAP_msg_ready_debug;
 --ICAP_msg <= "00000000000000000000000000000000" when ICAP_msg_ready = '0' else
   --          "10101010101010101010101010101010";
             
ICAP_msg_request_debug <= ICAP_msg_request;

ICAP_msg_all_finished <= ICAP_msg_all_finished_debug;

debug_delay <= Delay_Out;

end Behavioral;
