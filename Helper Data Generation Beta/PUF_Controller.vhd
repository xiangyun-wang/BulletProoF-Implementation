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
  --debug_clk : out std_logic;
  calibration_check_suc_debug : out std_logic;
  calibration_check_fail_debug : out std_logic;
  ICAP_msg_ready_debug : in std_logic;
  --ICAP_msg_request_debug : out std_logic;
  ICAP_msg_all_finished_debug : in std_logic;
  --debug_1 : out std_logic;
  --debug_2 : out std_logic;
  --debug_3 : out std_logic;
  --debug_v1 : out std_logic_vector(4 downto 0);
  --debug_v2 : out std_logic_vector(3 downto 0);
  debug_address : in std_logic_vector(15 downto 0);
  --debug_delay : out std_logic_vector(7 downto 0);
  debug_data_out : out std_logic_vector(11 downto 0);
  debug_data_out_1 : out std_logic;
  --ICAP_msg : in std_logic_vector(31 downto 0);
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
   --path_debug : out std_logic;
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
    Delay_Stable : out std_logic;
    Calibration_Check_Succeed : in std_logic;
    --debug_msg_in : out std_logic_vector(199 downto 0);
    --debug_msg_out : out std_logic_vector(199 downto 0);
    signal_measure : out std_logic;
    Point_Sel_PUF : out std_logic_vector(3 downto 0);
    enrollment_mode : in std_logic;
    --debug_hash : out std_logic_vector(199 downto 0);
    
    --debug_round_constant : out std_logic_vector(7 downto 0);
    write_en : out std_logic;
    PUF_Stop : in std_logic;
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

component blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
  );
END component;

component dist_mem_gen_0 IS
  PORT (
    a : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    d : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    clk : IN STD_LOGIC;
    we : IN STD_LOGIC;
    spo : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
END component;
-- need to port ring oscillator and using vivado clk wizard to get deried frequency
-- how to estimate desire frequency???


signal Calibration_Check_Succeed : std_logic := '0';
signal Calibration_Check_Fail : std_logic := '0';

-- TDC signals
--signal Calibration_Check : std_logic := '0';
signal Point_Sel_Calibration: std_logic_vector(3 downto 0);
signal Point_Sel_PUF : std_logic_vector(3 downto 0);
signal Point_Sel : std_logic_vector(3 downto 0);
signal TPsel : std_logic_vector(4 downto 0);
signal Launch : std_logic;
signal Launch_Calibration : std_logic := '0';
signal Signal_Measure : std_logic;
signal Delay_Out : std_logic_vector(7 downto 0);
signal ICAP_msg_ready : std_logic;
signal ICAP_msg : std_logic_vector(31 downto 0);
signal ICAP_msg_request : std_logic;
-- SHA3 signals
signal message_in_sha3 : std_logic_vector(199 downto 0);
signal message_out_sha3 : std_logic_vector(199 downto 0);
signal round_constant_sha3 : std_logic_vector(7 downto 0);
signal clk_ro : std_logic;
signal clk : std_logic;
signal ICAP_msg_all_finished : std_logic;
--signal reset : std_logic;

signal Launch_PUF : std_logic := '0';
--attribute dont_touch of Launch_PUF : signal is true;

-- bram signal 
signal bram_data_out : std_logic_vector(15 downto 0);
signal bram_data_out_1 : std_logic_vector(0 downto 0);
signal bram_address : std_logic_vector(15 downto 0);
signal bram_address_int : integer := 0; 
signal write_en : std_logic;
signal write_en_2 : std_logic_vector(1 downto 0);
signal bram_data_in : std_logic_vector(15 downto 0);
signal PUF_Stop : std_logic := '0';
signal delay_stable_vector : std_logic_vector(0 downto 0);
signal delay_stable : std_logic;

------------------------- Component and Signal declaration ends --------------------

begin

----------------------- port map begins ------------------------
------------------ newly added ----------------------
bram_1 : dist_mem_gen_0
  port map(
    a => bram_address,
    d => delay_stable_vector,
    clk => clk,
    we => write_en,
    spo => bram_data_out_1
  );
  
bram_0 : blk_mem_gen_0
  PORT map(
    clka => clk,
    wea => write_en_2,
    addra => bram_address,
    dina => bram_data_in,
    douta => bram_data_out
  );
------------------------- newly added ---------------------
TDC_1 : TDC
  port map(
    Calibration_Check_Succeed => Calibration_Check_Succeed,
    Point_Sel => Point_Sel,
    TPsel => TPsel,
    Launch => Launch,
    Signal_Measure => Signal_Measure,
    Delay_Out => Delay_Out
    --path_debug => debug_2
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
  clk => clk,
  ICAP_msg_all_finished => ICAP_msg_all_finished,
  ICAP_msg_ready => ICAP_msg_ready,
  ICAP_msg => ICAP_msg,
  Delay_PUF => Delay_out,
  Delay_Stable => Delay_Stable,
  Calibration_Check_Succeed  => Calibration_Check_Succeed,
  ICAP_msg_request => ICAP_msg_request,
  signal_measure => signal_measure,
  Point_Sel_PUF => Point_Sel_PUF,
  enrollment_mode => enrollment_mode,
  write_en => write_en,
  PUF_Stop => PUF_Stop,
  Launch_PUF => Launch_PUF


  --debug_1 => debug_1,
  --debug_2 => debug_2,
  --debug_3 => debug_3,
  --debug_v1 => debug_v1,
  --debug_v2 => debug_v2
  );


---------------------- port map ends ---------------------------

------------- process begins -----------------
Point_Sel <= Point_Sel_PUF when Calibration_Check_Succeed = '1' else
            Point_Sel_Calibration;
            
Launch <= Launch_PUF when Calibration_Check_Succeed = '1' else
            Launch_Calibration;
------- hash mode process end ---------

----------- process ends --------------

----- message to sha3 control




 --clk <= clk_10;
 clk <= clk_ro;
 --debug_clk <= clk_ro;
 -- debug portion ---
 --calibration_check_suc_debug <= Calibration_Check_Succeed;
 --calibration_check_fail_debug <= Calibration_Check_Fail;

            
 ICAP_msg_ready <= ICAP_msg_ready_debug;
 ICAP_msg <= "00000000000000000000000000000000" when ICAP_msg_ready = '0' else
             "00000000000000000000000000000001";
 
 --debug_1 <= Launch;
 
 --debug_v1 <= TPsel;
 --debug_v2 <= Point_Sel;
     
--ICAP_msg_request_debug <= ICAP_msg_request;

ICAP_msg_all_finished <= ICAP_msg_all_finished_debug;

--debug_delay <= Delay_Out;
debug_data_out <= bram_data_out(11 downto 0);
debug_data_out_1 <= bram_data_out_1(0);

--bram_address <= bram_address + 1
---------------- newly added (need an extra file??? maybe???) ------------------------------
bram_data_in <= "0000" & point_sel & delay_out;

bram_control : process(write_en)
begin
    if (falling_edge(write_en)) then
      if bram_address_int < 65535 then
        bram_address_int <= bram_address_int + 1;
        PUF_Stop <= '0';
      else
        bram_address_int <= 0;
        PUF_Stop <= '1';
      end if;
    end if;
end process bram_control;

--PUF_Stop <= '1' when bram_address_int = 65536 or ICAP_msg_all_finished = '1' else
--            '0';

write_en_2 <= write_en & write_en;
bram_address <= std_logic_vector(to_unsigned(bram_address_int,16)) when PUF_Stop = '0'else
                debug_address;
delay_stable_vector(0) <= delay_stable;
--------------------- newly added ---------------------------

end Behavioral;
