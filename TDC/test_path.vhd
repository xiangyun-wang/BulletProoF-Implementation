----------------------------------------------------------------------------------
-- Author: Yicheng Song
-- Date: 2021/06/16
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

entity test_path is
    Port ( 
        SWcon:      in std_logic_vector(31 downto 0);
        Launch:     in std_logic;
        TPsel:      in std_logic_vector(4 downto 0);
        
        test_path_o:       out std_logic
        --test_1:     out std_logic
    );
end test_path;

architecture Behavioral of test_path is
    -- LUT3 primitive
    -- Work as a 2:1 MUX, with INIT value of "00011011"
    component LUT3 is 
        generic(
        INIT : bit_vector := X"53"  -- indicate that the attribute of the logic table is 01010011
        );

        port(
        O : out std_ulogic;
    
        I0 : in std_ulogic;
        I1 : in std_ulogic;
        I2 : in std_ulogic
        );
    end component;    
    
    type SW_out is array (31 downto 0) of std_logic;
    type LUT_out is array (7 downto 0) of std_logic;
    type MUX7_out is array (3 downto 0) of std_logic;
    type MUX8_out is array (1 downto 0) of std_logic;
    signal path0, path1: SW_out;
    signal to_MUX7: LUT_out;
    signal to_MUX8: MUX7_out;
    signal to_MUX9: MUX8_out;

    -- LUT6, MUXF7, MUXF8 and MUXF9 primitives
    -- To implement a 32:1 mux, 8 LUT6, 4 MUXF7, 2 MUXF8 and a MUXF9 are needed
    component LUT6 is
        generic(
        INIT : bit_vector := X"555533330F0F00FF"
        );

        port(
        O : out std_ulogic;

        I0 : in std_ulogic;
        I1 : in std_ulogic;
        I2 : in std_ulogic;
        I3 : in std_ulogic;
        I4 : in std_ulogic;
        I5 : in std_ulogic
        );
    end component;
    
    component MUXF7 is
        port(
        O : out std_ulogic;

        I0 : in std_ulogic;
        I1 : in std_ulogic;
        S  : in std_ulogic
        );    
    end component;
    
    component MUXF8 is
        port(
        O : out std_ulogic;

        I0 : in std_ulogic;
        I1 : in std_ulogic;
        S  : in std_ulogic
        );
    end component;    
    
begin
    -- First stage of SW
    SW1_0: LUT3 port map(O => path0(0), I0 => Launch, I1 => Launch, I2 => SWcon(0));
    SW1_1: LUT3 port map(O => path1(0), I0 => Launch, I1 => Launch, I2 => SWcon(0));
    
    -- stage 1 to 31 of SW
    map_loop0: for i in 1 to 31 generate
        SWmap_0: LUT3 port map(O => path0(i), I0 => path0(i-1), I1 => path1(i-1), I2 => SWcon(i));
        SWmap_1: LUT3 port map(O => path1(i), I0 => path1(i-1), I1 => path0(i-1), I2 => SWcon(i));
    end generate;

    --test_1 <= path0(31) AND path1(31);
    map_loop1: for i in 0 to 7 generate
        LUTmap: LUT6 port map(O => to_MUX7(i), I0 => path0(4*i), I1 => path0(4*i+1), I2 => path0(4*i+2), I3 => path0(4*i+3), I4 => TPsel(0), I5 => TPsel(1));
    end generate;
    map_loop2: for i in 0 to 3 generate
        MUXF7map: MUXF7 port map (O => to_MUX8(i), I0 => to_MUX7(2*i), I1 => to_MUX7(2*i+1), S => TPsel(2));
    end generate;
    map_loop3: for i in 0 to 1 generate
        MUXF8map: MUXF8 port map (O => to_MUX9(i), I0 => to_MUX8(2*i), I1 => to_MUX8(2*i+1), S => TPsel(3));
    end generate;    
    MUXF9map: LUT3 port map (O => test_path_o, I0 => to_MUX9(0), I1 => to_MUX9(1), I2 => TPsel(4));
    
end Behavioral;
