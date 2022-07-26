library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity KState is
  -- generic(
  -- -- constant
  -- );
  Port (
    Data_In : in std_logic_vector(199 downto 0);
    reset : in std_logic;
    clk : in std_logic;
    hash_mode : in std_logic;
    Data_Out : out std_logic_vector(199 downto 0)
  );

end KState;

architecture Behavioral of KState is
  component FDRE is
      generic(
      INIT : bit := '0';
      IS_C_INVERTED : bit := '0';
      IS_D_INVERTED : bit := '0';
      IS_R_INVERTED : bit := '0'
      );

      port(
      Q   : out std_ulogic;
      C   : in std_ulogic;
      CE  : in std_ulogic;
      D   : in std_ulogic;
      R   : in std_ulogic
      );
  end component;

begin

  kstate_map_loop : for i in 0 to 199 generate
    DFF : FDRE port map(Q => Data_Out(i), C => clk, CE => hash_mode, D => Data_In(i),R => reset);
  end generate;

end Behavioral;
