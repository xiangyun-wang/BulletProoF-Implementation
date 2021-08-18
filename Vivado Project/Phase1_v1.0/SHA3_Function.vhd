----------------------------------------------------------------------------------
-- Company: McGill
-- Engineer: Xiangyun Wang
--
-- Create Date: 07/20/2021 06:11:57 PM
-- Design Name:
-- Module Name: SHA3_Function - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: This file is for SHA3 entropy source control and integration for phase 1
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity SHA3_Function is

  port(
    clk: in std_logic;
    data_ready: in std_logic;
    from_ICAP : in std_logic_vector(31 downto 0);
    end_of_all_data: in std_logic;
    data_request: out std_logic;
    to_CC : out std_logic;
    Launch : out std_logic;
    CC_finished : in std_logic;
    CC_retry : in std_logic;
    PUF_start : in std_logic; -- start signal of the timing operation
    timing_data_generation_finished : out std_logic := '0'
  );
end SHA3_Function;

architecture rtl of SHA3_Function is

signal zeros: std_logic_vector(199 downto 0) := (others =>'0'); --zero vector
signal round_constant : std_logic_vector(7 downto 0);           -- round constant for SHA3
signal message_in : std_logic_vector(199 downto 0);             -- message into SHA3
signal message_out: std_logic_vector(199 downto 0);             -- message out from SHA3
signal round_count : std_logic_vector(4 downto 0) := "11111";   -- round count for SHA3
signal padded : std_logic_vector (199 downto 0) := (others =>'0'); -- padded message

signal Fselect : integer range 0 to 199 := 0;                 -- to select which output from SHA3 to be timed
signal to_SHA3, from_FF : std_logic_vector(199 downto 0);     -- input to SHA3 before xor with padded configuration and content from Flip-Flop
signal enter_SHA3 : std_logic_vector(199 downto 0);           -- acutal data to SHA3
signal from_SHA3 : std_logic_vector(199 downto 0);            -- output from SHA3
signal hash_mode : std_logic;                                 -- to indicate in hash mode or puf mode
signal hash_reset : std_logic;                                -- reset signal of sha3
signal LaunchMUXCtrl : std_logic;                             -- control signal sending to sha3
signal load_msg : std_logic_vector(31 downto 0);              -- load_message mask for icap input
signal loaded_message : std_logic_vector(31 downto 0);        -- loaded message from icap
signal need_to_time_icap : std_logic;                         -- flag to indicate if icap needs to be timed
signal icap_counter : integer range 0 to 99 := 0;

-- SHA3 finite state machine
type SHA3_STATE is (INIT, LOAD, TIME_ICAP, RUN, PUF, PUF_reset, DONE);
signal state : SHA3_STATE := INIT;

-- SHA3 combo logic
component SHA3_Absorb is
  port(
    message_in: in std_logic_vector (199 downto 0);
    round_constant: in std_logic_vector (7 downto 0);  -- all the round constant will be stored in the upper level file
    message_out: out std_logic_vector (199 downto 0)
  );
end component;


begin

  hash: SHA3_Absorb
  port map(
    message_in => message_in,
    round_constant => round_constant,
    message_out => message_out
  );

-- flip flops to store result from SHA3
 kstate: for i in 199 downto 0 generate
    FF: FDCE
   generic map (
      INIT => '0') -- Initial value of register ('0' or '1')
   port map (
      Q => from_FF(i),      -- Data output
      C => clk,             -- Clock input
      CE => hash_mode,    -- Clock enable input
      CLR => hash_reset,  -- Asynchronous clear input
      D => from_SHA3(i)      -- Data input
   );
 end generate;


loaded_message <= from_ICAP and load_msg;

-- pad data to desired size
padded <= loaded_message & loaded_message & loaded_message(31 downto 24) & zeros(127 downto 0);

-- data to SHA3 before xor with padded data
to_SHA3 <= zeros when (LaunchMUXCtrl = '1') else
           from_FF;

-- actual data to SHA3
enter_SHA3 <= to_SHA3 xor padded;

SHA3_MODE : process (clk)

begin

    if(rising_edge(clk)) then

        case state is

        when INIT => --init
          hash_reset <= '1';
          LaunchMUXCtrl <= '1';
          load_msg <= "00000000000000000000000000000000";
          timing_data_generation_finished <= '0';
          if (PUF_start = '1') then   -- if timing process can be started, go to load
            state <= LOAD;
          end if;
        when LOAD => -- load data -- need to fix
           Launch <= '0';
           hash_reset <= '0';
           data_request <= '1';
           Fselect <= 0;

           if data_ready = '1' then       -- wait for data
               icap_counter <= icap_counter + 1;      -- periodically time path from icap, in this case, 100 times / icap_timing
               if(icap_counter = 99) then
                   state <= PUF_reset;
                   need_to_time_icap <= '1';
               else
                   state <= RUN;    -- when data ready, load message and start to do SHA3 operation
                   round_count <= "11111";
                   load_msg <= "11111111111111111111111111111111";
               end if;
           elsif end_of_all_data = '1' then
                state <= DONE;
           end if;

        when TIME_ICAP =>  -- time path from icap
            -- turn load_msg to 1s
            load_msg <= "11111111111111111111111111111111";
            Launch <= '1';
            if(CC_finished = '1') then
                if (CC_retry = '0') then    -- if time data generated successfully, increase Fselect by 1, to time the next bit
                    Fselect <= Fselect + 1;
                end if;
                if (Fselect = 200) then
                    need_to_time_icap <= '0';
                    state <= LOAD;
                else
                    state <= PUF_reset;
                end if;
            end if;

        when RUN => -- hash process
          data_request <= '0';
          hash_mode <= '1';
          if (round_count = "11111") then
            round_count <= "00000";
          elsif(round_count = "10001") then     -- when hash process done, go to puf reset, get ready to measure puf
            load_msg <= "00000000000000000000000000000000";
            state <= PUF_reset;
          else
            round_count <= std_logic_vector(unsigned(round_count)+1);
          end if;
        when PUF =>
            hash_mode <= '0';
            LaunchMUXCtrl <= '0';
            Launch <= '1';
            load_msg <= "00000000000000000000000000000000";
            if(CC_finished = '1') then
                if (CC_retry = '0') then      -- same idea as time_icap
                    Fselect <= Fselect + 1;
                end if;
                if (Fselect = 200) then
                    state <= LOAD;
                else
                    state <= PUF_reset;
                end if;
            end if;

        when PUF_reset => -- reset puf to get ready for timing operation
            LaunchMUXCtrl <= '1';
            Launch <= '0';
            load_msg <= "00000000000000000000000000000000";
            if from_SHA3 = zeros then
                if (need_to_time_icap /= '1') then
                    state <= PUF;
                else
                    icap_counter <= 0;
                    state <= TIME_ICAP;
                end if;
            end if;
        when DONE =>    -- set flag to indicate timing data generation finished
           timing_data_generation_finished <= '1';
           state <= INIT;
      end case;

    end if;

end process;

from_SHA3 <= message_out;
to_CC <= from_SHA3(Fselect);
message_in <= enter_SHA3;

round_constant <= "00000001" when (round_count = "00000") else
                  "10000010" when (round_count = "00001") else
                  "10001010" when (round_count = "00010") else
                  "00000000" when (round_count = "00011") else
                  "10001011" when (round_count = "00100") else
                  "00000001" when (round_count = "00101") else
                  "10000001" when (round_count = "00110") else
                  "00001001" when (round_count = "00111") else
                  "10001010" when (round_count = "01000") else
                  "10001000" when (round_count = "01001") else
                  "00001001" when (round_count = "01010") else
                  "00001010" when (round_count = "01011") else
                  "10001011" when (round_count = "01100") else
                  "10001011" when (round_count = "01101") else
                  "10001001" when (round_count = "01110") else
                  "00000011" when (round_count = "01111") else
                  "00000010" when (round_count = "10000") else
                  "10000000" when (round_count = "10001") else
                  "11111111";

end rtl;
