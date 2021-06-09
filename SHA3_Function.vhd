library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arth.all;

entity SHA3_Function is

  port(
    clk: in std_logic;
    data_ready: in std_logic;
    more_data: in std_logic;
    rst: in std_logic;
    configuration_in : in std_logic_vector (31 downto 0);
    data_request: out std_logic := '1';
    hash_out: out std_logic_vector (199 downto 0) := others =>'0'
  );
end SHA3_Function;

architecture rtl of SHA3_Function is

signal zeros: std_logic_vector(199 downto 0) := others =>'0'
signal round_constant : std_logic_vector(7 downto 0);
signal message_in : std_logic_vector(199 downto 0);
signal message_out: std_logic_vector(199 downto 0);
signal round_count : std_logic_vector(4 downto 0) := "00000";
signal padded : std_logic_vector (199 downto 0) := others =>'0';
signal internal_reset : std_logic := '0';

type SHA3_STATE is (INIT, LOAD, RUN, DONE);
signal state : SHA3_STATE := INIT;
component SHA3_Absorb is
  port(
    message_in: std_logic_vector (199 downto 0);
    --message_in_ready: std_logic;
    round_constant: std_logic_vector (7 downto 0);  -- all the round constant will be stored in the upper level file
    message_out: std_logic_vector(199 downto 0)
  );
end component;


begin

  hash: SHA3_Absorb
  port map(
    message_in => message_in,
    round_constant => round_constant,
    message_out => message_out
  );

  process(clk)
  begin
    if rst = '1' then
      state <= INIT;
    elsif(rising_edge(clk)) then
      case state is
        when INIT =>
          internal_reset <= '1';
          state <= LOAD;
        when LOAD =>
          internal_reset <= '0';
          data_request <= '1';
          if data_ready = '1' then
            --data_request <= '0';
            state <= RUN;
            round_count <= "00000";
          end if;
        when RUN =>
          data_request <= '0';
          if(round_count /= "10010") then
            round_count <= std_logic_vector(unsigned(round_count)+1);
          else
            if (more_data = '0') then
              state <= DONE;
            else
              state <= LOAD;
            end if;
          end if;
        when DONE =>
          hash_out => message_out;
      end case;

    end if;
  end process;


padded <= configuration_in & configuration_in & configuration_in(31 downto 24) & zeros(127 downto 0);

-- PUF mode????
message_in <= zeros when (internal_reset = '1') else
              (padded xor message_out) when (round_count = "00000") else
              message_out when (round_count /= "10010") else
              message_in;


-- round constant assign
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
                  "11111111"

end rtl;
