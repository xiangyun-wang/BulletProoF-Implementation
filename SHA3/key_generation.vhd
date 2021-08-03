library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.user_types.all;


entity key_gen is 
        port(
        clk: in std_logic;
        squeeze_in: in std_logic_vector(199 downto 0);
        squeeze_out: out std_logic_vector(255 downto 0)
        );
end squeeze;

architecture rtl of key_gen is

signal zeros: std_logic_vector(199 downto 0) := (others =>'0'); --zero vector
signal round_constant : std_logic_vector(7 downto 0);
signal message_in : std_logic_vector(199 downto 0);
signal message_out: std_logic_vector(199 downto 0);
signal round_count : std_logic_vector(4 downto 0) := "11111";
signal internal_reset : std_logic := '0';
signal internal_out : std_logic_vector (199 downto 0) := (others => '0');

type SHA3_STATE is (INIT, LOAD, RUN, DONE);
signal state : SHA3_STATE := INIT;

component SHA3_Absorb is
  port(
    message_debug : out std_logic_vector(199 downto 0);
    message_in: in std_logic_vector (199 downto 0);
    round_constant: in std_logic_vector (7 downto 0);  -- all the round constant will be stored in the upper level file
    message_out: out std_logic_vector (199 downto 0)
  );
end component;

signal second_out: std_logic_vector(199 downto 0);
	
    begin
	squeeze_out(255 downto 56) <= squeeze_in(199 downto 0);
	squeeze_out(55 downto 0) <= second_out(199 downto 144);
	  
	hash: SHA3_Absorb
	  port map(
 	   message_debug => open,
 	   message_in => message_in,
 	   round_constant => round_constant,
 	   message_out => message_out
 	 );

  process(clk)
  begin
  if(rising_edge(clk)) then
      case state is
        when INIT => --init
          internal_reset <= '1';
          message_in <= zeros;
          state <= LOAD;
        when LOAD => -- load data
          internal_reset <= '0';
          data_request <= '1';
          if data_ready = '1' then
            --data_request <= '0';
            state <= RUN;
            round_count <= "11111";
          end if;
        when RUN => -- hash process
          data_request <= '0';
          if (round_count = "11111") then
            round_count <= "00000";
            message_in <= squeeze_in xor internal_out;
          elsif(round_count = "10001") then
            internal_out <= message_out;
            if (more_data = '0') then -- if no more data, jump to done
              state <= DONE;
            else
              state <= LOAD;
            end if;
          else
            round_count <= std_logic_vector(unsigned(round_count)+1);
            message_in <= message_out;
          end if;
        when DONE =>
           second_out <= internal_out;
      end case;

    end if;
  end process;	



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