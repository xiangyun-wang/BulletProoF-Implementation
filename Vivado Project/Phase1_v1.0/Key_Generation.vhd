----------------------------------------------------------------------------------
-- Company: McGill University
-- Engineer: Xiangyun Wang
--
-- Create Date: 08/16/2021 02:26:26 PM
-- Design Name:
-- Module Name: Key_Generation - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
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

-- need to import sha3 and squeeze

entity Key_Generation is
    port(
    key_generation_start : in std_logic;
    clk : in std_logic;
    data_in : in std_logic_vector(31 downto 0);
    data_request : out std_logic;
    data_ready  : in std_logic;
    no_more_data : in std_logic;
    key_generated : out std_logic_vector(255 downto 0);
    key_generation_finished : out std_logic:= '0');
end Key_Generation;

architecture Behavioral of Key_Generation is

signal round_constant : std_logic_vector(7 downto 0);                     -- round constant
signal round_count : std_logic_vector(4 downto 0) := "11111";             -- round constant counter
signal message_in, message_out : std_logic_vector(199 downto 0);          -- message in and out for SHA3
signal padded : std_logic_vector(199 downto 0) := (others => '0');        -- padded data
signal internal_reset : std_logic := '0';
signal internal_out : std_logic_vector(199 downto 0) := (others => '0');
signal zeros : std_logic_vector(199 downto 0) := (others => '0');         -- zero vector
signal squeeze_counter : integer := 0;                                    -- counter for squeeze
signal reset_round_count : std_logic := '0';                              -- flag to indicate if round_count needs to be reset

type SHA3_STATE is (INIT, LOAD, ABSORB, SQUEEZE, DONE);   -- SHA3 key generation finite state machine
signal state : SHA3_STATE := INIT;

type squeeze_out is array (0 to 5) of std_logic_vector(71 downto 0);      -- squeeze out from SHA3
signal keys : squeeze_out;

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

  key_generation : process(clk)
  begin
    if(rising_edge(clk)) then
      case state is
        when INIT => --init
          message_in <= zeros;
          if(key_generation_start = '1')then
            state <= LOAD;
          end if;
        when LOAD => -- load data
          data_request <= '1';
          if data_ready = '1' then    -- wait for data
            state <= ABSORB;
            round_count <= "11111";
          end if;
        when ABSORB => -- hash absorb process
          data_request <= '0';
          if (round_count = "11111") then
            round_count <= "00000";
            message_in <= padded xor internal_out;      -- xor with data padded
          elsif(round_count = "10001") then
            internal_out <= message_out;
            if (no_more_data = '1') then
              state <= SQUEEZE;
              reset_round_count <= '1';
            else
              state <= LOAD;
            end if;
          else
            round_count <= std_logic_vector(unsigned(round_count)+1);
            message_in <= message_out;
          end if;
        when SQUEEZE =>         -- same idea as absorb, but no xor with padded data
          if (reset_round_count = '1') then
            round_count <= "11111";
            reset_round_count <= '0';
          elsif(round_count = "11111") then
            round_count <= "00000";
            message_in <= internal_out;
          elsif(round_count = "10001") then
            internal_out <= message_out;
            keys(squeeze_counter) <= message_out;
            squeeze_counter <= squeeze_counter + 1;
            if (squeeze_counter /= 5) then
              state <= SQUEEZE;
              reset_round_count <= '1';
            else
              state <= DONE;                --  jump to done if data squeezed is enough
            end if;
          else
            round_count <= std_logic_vector(unsigned(round_count)+1);   -- increase round count
            message_in <= message_out;
          end if;

        when DONE =>
           key_generation_finished <= '1';        -- indicate key generation finished
      end case;

    end if;
end process;

padded <= data_in & data_in & data_in(31 downto 24) & zeros(127 downto 0);      -- padded data

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

key_generated <= keys(1) & keys(2) & keys(3) & keys(4)(39 downto 0);            -- generated key

end Behavioral;
