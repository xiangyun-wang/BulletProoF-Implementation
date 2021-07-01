----------------------------------------------------------------------------------
-- Author: Yicheng Song
-- Date: 2021/06/15
-- Version: 1
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

entity carry_chain is
    Port ( 
    mpsclk      : in  std_logic;
    path        : in  std_logic;
    TVal        : out integer
    --test1       : out std_logic_vector(127 downto 0)
    );
end carry_chain;

architecture Behavioral of carry_chain is    
    --carry4 primitive
    --selection bit S is always set to logic 1, in order to let the input signal CI or CYINIT propagate through the line.
    component CARRY4 is
        port(
        CO          : out std_logic_vector(3 downto 0);
        O           : out std_logic_vector(3 downto 0);
    
        CI          : in  std_ulogic := '0';
        CYINIT      : in  std_ulogic := '0';
        DI          : in  std_logic_vector(3 downto 0);
        S           : in  std_logic_vector(3 downto 0)
      );
    end component;
    
    --D flip-flop primitive
    component FDRE is
        generic(
        INIT : bit := '1';
        IS_C_INVERTED : bit := '0';
        IS_D_INVERTED : bit := '0';
        IS_R_INVERTED : bit := '0'
        );

        port(
        Q   : out std_ulogic := TO_X01(INIT);
        C   : in std_ulogic;
        CE  : in std_ulogic;
        D   : in std_ulogic;
        R   : in std_ulogic
        );
    end component;
    
    type output is array (31 downto 0) of std_logic_vector(3 downto 0);
    signal c_out, FF_out: output;
    signal logic_high: std_logic := '1';
    signal logic_low: std_logic := '0';

begin
    -- 32 cascade CARRY4 blocks, totally 128 carry chain stages
    C4_1: CARRY4 port map(CO => c_out(0), O => open, CI => open, CYINIT => path, DI => "0000", S => "1111");
    
    map_loop1: for i in 1 to 31 generate
        CC_map: CARRY4 port map(CO => c_out(i), O => open, CI => c_out(i - 1)(3), CYINIT => open, DI => "0000", S => "1111");
    end generate;
    
    -- 128 D flip-flop storing c_out
    map_loop2_1: for i in 0 to 31 generate
        map_loop2_2: for j in 0 to 3 generate
            DFF: FDRE port map(Q => FF_out(i)(j), C => mpsclk, CE => logic_high, D => c_out(i)(j), R => logic_low);
        end generate;
    end generate;
    
--    test: for i in 0 to 31 generate
--        test_1: for j in 0 to 3 generate
--        test1(4*i+j) <= FF_out(i)(j);
--        end generate;
--    end generate;
    
process(mpsclk)
    variable count: integer range 0 to 128;
    begin
    if(rising_edge(mpsclk)) then
        count := 0;   
        for i in 0 to 31 loop
            for j in 0 to 3 loop
                if(FF_out(i)(j) = '0') then
                    count := count + 1;
                end if;
            end loop;
        end loop;
    TVal <= count;
    end if;
end process;

end Behavioral;
