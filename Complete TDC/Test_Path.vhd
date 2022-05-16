----------------------------------------------------------------------------------
-- Author: Xiangyun Wang
-- Date: 2022/02/17
-- Version: 2.0
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

entity Test_Path is
    Port (
        SWcon:      in std_logic_vector(31 downto 0);
        Launch:     in std_logic;
        TPsel:      in std_logic_vector(4 downto 0);

        Test_Path_o:       out std_logic
        --test_1:     out std_logic
    );
end Test_Path;

architecture Behavioral of Test_Path is
    -- LUT3 primitive
    -- Work as a 2:1 MUX, with INIT value of "00011011"
    component LUT3 is
        generic(
        INIT : bit_vector := X"CA"  -- indicate that the attribute of the logic table is 01010011
        );

        port(
        O : out std_ulogic;

        I0 : in std_ulogic;
        I1 : in std_ulogic;
        I2 : in std_ulogic
        );
    end component;
    --signal path0, path1: SW_out;
    signal path0 : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
    signal path1 : std_logic_vector(31 downto 0) := "00000000000000000000000000000000";

begin
    -- First stage of SW
    SW1_0: LUT3 port map(O => path0(0), I0 => Launch, I1 => Launch, I2 => SWcon(0));
    SW1_1: LUT3 port map(O => path1(0), I0 => Launch, I1 => Launch, I2 => SWcon(0));

    -- stage 1 to 31 of SW
    map_loop0: for i in 1 to 31 generate
        SWmap_0: LUT3 port map(O => path0(i), I0 => path0(i-1), I1 => path1(i-1), I2 => SWcon(i));
        SWmap_1: LUT3 port map(O => path1(i), I0 => path1(i-1), I1 => path0(i-1), I2 => SWcon(i));
    end generate;

    Test_Path_o <= path0(to_integer(unsigned(TPsel))) or path1(to_integer(unsigned(TPsel)));

end Behavioral;
