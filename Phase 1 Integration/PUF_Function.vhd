library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

ENTITY PUF_Function is
  Port(
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
    --debug_mux200 : out std_logic_vector(7 downto 0);
    --debug_round_constant : out std_logic_vector(7 downto 0);
    Launch_PUF : out std_logic
  );

end PUF_Function;

architecture Behavioral of PUF_Function is

  signal round_cnt : integer := 0;
  signal out_mux_200to1 : integer := 0;
  signal Point_Sel_tracker : integer := 0;
  signal message_in_sha3 : std_logic_vector(199 downto 0);
  signal message_out_sha3 : std_logic_vector(199 downto 0) := (others => '0');
  signal round_constant_sha3 : std_logic_vector(7 downto 0);
  signal LaunchMUXCtrl : std_logic := '0';
  signal load_msg : std_logic_vector(71 downto 0);
  signal msg_after_and : std_logic_vector(71 downto 0);
  signal hash_mode : std_logic := '1';
  signal out_mux_200to1_vec : std_logic_vector(7 downto 0);

  signal reset : std_logic;

  signal padded : std_logic_vector(199 downto 0);
  signal zeros : std_logic_vector(199 downto 0) := (others => '0');
  signal load_msg_flag : std_logic := '0';
  signal internal_out : std_logic_vector(199 downto 0):= (others => '0');
  
  signal v0 : std_logic_vector(199 downto 0);
  signal v1 : std_logic_vector(199 downto 0) := (others => '0');

  type CTL_STAT is (HASH, Idel, HASH_PAUSE, PUF0_0, PUF0_1, PUF1, Save);

  signal Controller_Status : CTL_STAT := Idel;

  COMPONENT SHA3_Absorb_0
    PORT (
        message_in : IN STD_LOGIC_VECTOR(199 DOWNTO 0);
        round_constant : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        message_out : OUT STD_LOGIC_VECTOR(199 DOWNTO 0)
  );
END COMPONENT;

component KState is
  port(
  Data_In : in std_logic_vector(199 downto 0);
  reset : in std_logic;
  clk : in std_logic;
  hash_mode : in std_logic;
  Data_Out : out std_logic_vector(199 downto 0)
  );
end component;

component mux200 is
  port(
    mux200_out : out std_logic;
    mux200_in : in std_logic_vector(199 downto 0);
    mux200_sel : in std_logic_vector(7 downto 0)
  );
  end component;


  begin
  
  your_instance_name : SHA3_Absorb_0
   PORT MAP (
    message_in => message_in_sha3,
    round_constant => round_constant_sha3,
    message_out => message_out_sha3
   );
   
    kstate_1 : KState
   port map(
     Data_In => internal_out,
     Data_Out => v0,
     reset => reset,
     clk => clk,
     hash_mode => hash_mode
   );
   
--    mux200_1 : mux200
--   port map(
--     mux200_in => message_out_sha3,
--     mux200_out => signal_measure,
--     mux200_sel => out_mux_200to1_vec

--   );
   
   
    HASH_1 : process (clk)
    variable ICAP_PUF_sel : integer := 0;
    begin
    if rising_edge(clk) and Calibration_Check_Succeed = '1' then
      case Controller_Status is
        when Idel =>
          LaunchMUXCtrl <= '0';
          reset <= '0';
          hash_mode <= '0';
          load_msg_flag <= '0';
          if ICAP_msg_all_finished = '1' then 
            controller_Status <= Idel;
          else
            if ICAP_msg_ready = '1' then
              ICAP_msg_request <= '0';
              
                if ICAP_PUF_sel = 0 then
                    Controller_Status <= PUF0_1;
                else
                    Controller_Status <= PUF0_0;
                end if;
              load_msg_flag <= '0';
              round_cnt <= 18;
            else
              
              ICAP_msg_request <= '1';
              controller_Status <= Idel;
            end if;
           end if;
        when PUF0_0 =>
            LaunchMUXCtrl <= '0'; -- this is for naive PUF, only path B is measured
            load_msg_flag <= '0';
            hash_mode <= '0';
            reset <= '0';
            Controller_Status <= PUF1;
            Launch_PUF <= '1';
        when PUF0_1 =>
            LaunchMUXCtrl <= '1';
            load_msg_flag <= '1';
            hash_mode <= '0';
            Controller_Status <= PUF1;
            Launch_PUF <= '1';
            reset <= '0';
            -- need one more state??
        --when PUF_Launch =>
            --Launch_PUF <= '1';
            --Controller_Status <= PUF_Delaunch;
        --when PUF_Delaunch =>
            --Launch_PUF <= '0';
            --Controller_Status <= PUF1;
        when PUF1 =>
            LaunchMUXCtrl <= '1';
            hash_mode <= '0';
            Launch_PUF <= '0';
            Load_msg_flag <= '0';
            reset <= '0';
            --round_cnt <= 0;
        if Delay_PUF /= "00000000" and Delay_PUF /= "10000000" then
            Controller_Status <= SAVE;
            --Point_Sel_Tracker <= 0;
        elsif Delay_PUF = "10000000" then
        --- this part neet further consideration ---
            
            if Point_Sel_Tracker /= 15 then
          -- take 200 to 1, measure again
                Point_Sel_Tracker <= Point_Sel_Tracker + 1; -- need to change
                if ICAP_PUF_sel = 0 then
                    Controller_Status <= PUF0_1;
                else
                    Controller_Status <= PUF0_0;
                end if;
            else
                Point_Sel_Tracker <= 0;
                
                if out_mux_200to1 < 71 then
                    out_mux_200to1 <= out_mux_200to1 + 1;
                    -- measure new 200to1
                    if ICAP_PUF_sel = 0 then
                        Controller_Status <= PUF0_1;
                    else
                        Controller_Status <= PUF0_0;
                    end if;
                else
                    -- go to hash (even if delay_out = 10000000)
                    hash_mode <= '1';
                    Controller_Status <= HASH;
                    load_msg_flag <= '1';
                    LaunchMUXCtrl <= '0';
                    round_cnt <= 0;
                    out_mux_200to1 <= 0;
                end if;
            end if;
        else
            Point_Sel_Tracker <= 0;
            
            if out_mux_200to1 < 71 then
                out_mux_200to1 <= out_mux_200to1 + 1;
                -- measure new 200to1
                if ICAP_PUF_sel = 0 then
                    Controller_Status <= PUF0_1;
                else
                    Controller_Status <= PUF0_0;
                end if;
            else
          -- go to hash (even if delay_out = 10000000)
                    hash_mode <= '1';
                    Controller_Status <= HASH;
                    load_msg_flag <= '1';
                    LaunchMUXCtrl <= '0';
                    round_cnt <= 0;
                    out_mux_200to1 <= 0;
            end if;
        end if;

    --- further consideration part end ----
        when SAVE =>
            -- some operation about save (wait how many cycles, addresses .....)
            if out_mux_200to1 = 71 then
                out_mux_200to1 <= 0;
                hash_mode <= '1';
                LaunchMUXCtrl <= '0';
                load_msg_flag <= '1';
                Controller_Status <= HASH;
                round_cnt <= 0;
            else
                out_mux_200to1 <= out_mux_200to1 + 1;
                if ICAP_PUF_sel = 0 then
                   Controller_Status <= PUF0_1;
                else
                    Controller_Status <= PUF0_0;
                end if;
            end if;
      
        when HASH =>
          Point_Sel_Tracker <= 0;
          reset <= '0';
          if load_msg_flag = '1' then
            Controller_Status <= HASH_PAUSE;
          elsif round_cnt = 17 then 
            Controller_Status <= idel;
            ICAP_PUF_sel := (ICAP_PUF_sel + 1) mod 10;
          else
            Controller_Status <= HASH_PAUSE;
          end if;
          internal_out <= message_out_sha3;
        when HASH_PAUSE =>
          load_msg_flag <= '0'; 
          round_cnt <= round_cnt+1;
          Controller_Status <= HASH;
      end case;
    end if;
    end process HASH_1;
    
    --debug_hash <= internal_out;
    
    load_msg <= "111111111111111111111111111111111111111111111111111111111111111111111111" when load_msg_flag = '1' else
            "000000000000000000000000000000000000000000000000000000000000000000000000";
    
    
    --debug_msg_out <= message_out_sha3;
    --debug_msg_in <= message_in_sha3;
    padded <= msg_after_and & zeros(127 downto 0);
-- load message logic
    msg_after_and <= (ICAP_msg & ICAP_msg & ICAP_msg(31 downto 24)) and load_msg;
    
    message_in_sha3  <= v0 when (LaunchMUXCtrl = '0' and load_msg_flag = '0') else
                    v0 xor padded when (LaunchMUXCtrl = '0' and load_msg_flag = '1') else
                    v1 when (LaunchMUXCtrl = '1' and load_msg_flag = '0') else
                    v1 xor padded; -- need to check
    
    out_mux_200to1_vec <= std_logic_vector(to_unsigned(out_mux_200to1,8));
    
    --debug_mux200 <= out_mux_200to1_vec;
    signal_measure <= message_out_sha3(1);
    
    Point_Sel_PUF <= std_logic_vector(to_unsigned(Point_Sel_Tracker,4));
    
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
                      "00000000";
--debug_round_constant <= round_constant_sha3;
  end Behavioral;
