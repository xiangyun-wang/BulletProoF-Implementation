----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/25/2022 10:29:34 AM
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Key_Generation is
    Port ( Delay_Data : in STD_LOGIC_VECTOR (15 downto 0);
           --Delay_Ready : in std_logic;
           Delay_Stable : in STD_LOGIC;
           Delay_Request : out STD_LOGIC;
           Key : out STD_LOGIC_VECTOR (199 downto 0);
           Key_Generation_Finished : out std_logic := '0';
           clk : in std_logic;
           Key_Generation_Start : in std_logic;
           Delay_Finished : in STD_LOGIC);
end Key_Generation;

architecture Behavioral of Key_Generation is

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

signal message_in_sha3 : std_logic_vector(199 downto 0);
signal message_out_sha3 : std_logic_vector(199 downto 0);
signal round_constant_sha3 : std_logic_vector(7 downto 0);
signal v0 : std_logic_vector(199 downto 0);
signal internal_out : std_logic_vector(199 downto 0);
signal round_cnt : integer := 0;
signal reset : std_logic;
signal hash_mode : std_logic;
signal msg_after_and : std_logic_vector(199 downto 0);
signal padded : std_logic_vector(127 downto 0);
signal load_msg : std_logic_vector(71 downto 0);
signal load_msg_flag : std_logic;
signal zeros : std_logic_vector(199 downto 0) := (others => '0');

type Key_Generation_STAT is (Idel, HASH, HASH_PAUSE, LOAD, Finished);

signal Key_Status : Key_Generation_STAT := Idel;

begin

SHA3_key : SHA3_Absorb_0
   PORT MAP (
    message_in => message_in_sha3,
    round_constant => round_constant_sha3,
    message_out => message_out_sha3
   );
   
    kstate_key : KState
   port map(
     Data_In => internal_out,
     Data_Out => v0,
     reset => reset,
     clk => clk,
     hash_mode => hash_mode
   ); 

hash_key : process(clk)
variable load_wait : integer := 0;
begin
    if rising_edge(clk) and key_generation_start = '1' then 
      case Key_Status is 
        when Idel => 
           if Delay_Finished = '1' then 
              Key_Status <= Finished;
              Delay_Request <= '0';
           else
             round_cnt <= 0;
             Delay_Request <= '1';
             Key_Status <= LOAD;
           end if;
        when LOAD => 
            load_msg_flag <= '0';
            round_cnt <= 0;
            if load_wait < 3 then
                Delay_Request <= '1';
                Key_Status <= LOAD; 
                load_wait := load_wait + 1;
            else
                load_wait := 0;
                Delay_Request <= '0';
                load_msg_flag <= '1';
                Key_Status <= HASH;
            end if;
        when HASH =>
          if load_msg_flag = '1' then
            Key_Status <= HASH_PAUSE;
          elsif round_cnt = 17 then 
            Key_Status <= idel;
          else
            Key_Status <= HASH_PAUSE;
          end if;
          internal_out <= message_out_sha3;
        when HASH_PAUSE =>
          load_msg_flag <= '0'; 
          round_cnt <= round_cnt+1;
          Key_Status <= HASH;
        when Finished => 
            Key_Generation_Finished <= '1';
            Key_Status <= Finished;
            Key <= internal_out;
      end case;
    end if;
end process hash_key;

hash_mode <= '1';

load_msg <= "111111111111111111111111111111111111111111111111111111111111111111111111" when load_msg_flag = '1' else
            "000000000000000000000000000000000000000000000000000000000000000000000000";
    
    
    --debug_msg_out <= message_out_sha3;
    --debug_msg_in <= message_in_sha3;
    padded <= msg_after_and & zeros(127 downto 0);
-- load message logic
    msg_after_and <= (Delay_Data & Delay_Data & Delay_Data & Delay_Data & Delay_Data(15 downto 8)) and load_msg;

message_in_sha3  <= v0 when (load_msg_flag = '0') else
                    v0 xor padded when (load_msg_flag = '1');

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

end Behavioral;
