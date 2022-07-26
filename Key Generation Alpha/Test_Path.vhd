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
    signal TP_MUX_4_to_1_output_00 : std_logic_vector(7 downto 0);
    signal TP_MUX_4_to_1_output_01 : std_logic_vector(3 downto 0);
    signal TP_MUX_4_to_1_output_10 : std_logic_vector(7 downto 0);
    signal TP_MUX_4_to_1_output_11 : std_logic_vector(3 downto 0);
    signal path0_out : std_logic;
    signal path1_out : std_logic;

begin
    -- First stage of SW
    SW1_0: LUT3 port map(O => path0(0), I0 => Launch, I1 => Launch, I2 => SWcon(0));
    SW1_1: LUT3 port map(O => path1(0), I0 => Launch, I1 => Launch, I2 => SWcon(0));

    -- stage 1 to 31 of SW
    map_loop0: for i in 1 to 31 generate
        SWmap_0: LUT3 port map(O => path0(i), I0 => path0(i-1), I1 => path1(i-1), I2 => SWcon(i));
        SWmap_1: LUT3 port map(O => path1(i), I0 => path1(i-1), I1 => path0(i-1), I2 => SWcon(i));
    end generate;

    --Test_Path_o <= path0(to_integer(unsigned(TPsel))) or path1(to_integer(unsigned(TPsel)));
    
     selection00_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")

      port map(I0=>path0(0), I1=>path0(1), I2=>path0(2), I3=>path0(3),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(0));
     selection01_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")

      port map(I0=>path0(4), I1=>path0(5), I2=>path0(6), I3=>path0(7),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(1));
     selection02_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")

      port map(I0=>path0(8), I1=>path0(9), I2=>path0(10), I3=>path0(11),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(2));
        selection03_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>path0(12), I1=>path0(13), I2=>path0(14), I3=>path0(15),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(3));
        selection04_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
         port map(I0=>path0(16), I1=>path0(17), I2=>path0(18), I3=>path0(19),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(4));
        selection05_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
         port map(I0=>path0(20), I1=>path0(21), I2=>path0(22), I3=>path0(23),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(5));
        selection06_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
         port map(I0=>path0(24), I1=>path0(25), I2=>path0(26), I3=>path0(27),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(6));
        selection07_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>path0(28), I1=>path0(29), I2=>path0(30), I3=>path0(31),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_00(7));
        
        selection08_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>TP_MUX_4_to_1_output_00(0), I1=>TP_MUX_4_to_1_output_00(1), I2=>TP_MUX_4_to_1_output_00(2), I3=>TP_MUX_4_to_1_output_00(3),
        I4=>TPsel(2), I5=>TPsel(3), O=>TP_MUX_4_to_1_output_01(0));
        selection09_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>TP_MUX_4_to_1_output_00(4), I1=>TP_MUX_4_to_1_output_00(5), I2=>TP_MUX_4_to_1_output_00(6), I3=>TP_MUX_4_to_1_output_00(7),
        I4=>TPsel(2), I5=>TPsel(3), O=>TP_MUX_4_to_1_output_01(1));
        
        selection010_lut: LUT6
       generic map (INIT => X"FF00F0F0CCCCAAAA")
       port map(I0=>TP_MUX_4_to_1_output_01(0), I1=>TP_MUX_4_to_1_output_01(1), I2=>'0', I3=>'0',
       I4=>TPsel(4), I5=>'0', O=>path0_out);
        



     selection10_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
      port map(I0=>path1(0), I1=>path1(1), I2=>path1(2), I3=>path1(3),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(0));
     selection11_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")

      port map(I0=>path1(4), I1=>path1(5), I2=>path1(6), I3=>path1(7),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(1));
     selection12_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")

      port map(I0=>path1(8), I1=>path1(9), I2=>path1(10), I3=>path1(11),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(2));
        selection13_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>path1(12), I1=>path1(13), I2=>path1(14), I3=>path1(15),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(3));
        selection14_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
         port map(I0=>path1(16), I1=>path1(17), I2=>path1(18), I3=>path1(19),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(4));
        selection15_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
         port map(I0=>path1(20), I1=>path1(21), I2=>path1(22), I3=>path1(23),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(5));
        selection16_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
         port map(I0=>path1(24), I1=>path1(25), I2=>path1(26), I3=>path1(27),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(6));
        selection17_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>path1(28), I1=>path1(29), I2=>path1(30), I3=>path1(31),
        I4=>TPsel(0), I5=>TPsel(1), O=>TP_MUX_4_to_1_output_10(7));
        
        selection18_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>TP_MUX_4_to_1_output_10(0), I1=>TP_MUX_4_to_1_output_10(1), I2=>TP_MUX_4_to_1_output_10(2), I3=>TP_MUX_4_to_1_output_10(3),
        I4=>TPsel(2), I5=>TPsel(3), O=>TP_MUX_4_to_1_output_11(0));
        selection19_lut: LUT6
      generic map (INIT => X"FF00F0F0CCCCAAAA")
        port map(I0=>TP_MUX_4_to_1_output_10(4), I1=>TP_MUX_4_to_1_output_10(5), I2=>TP_MUX_4_to_1_output_10(6), I3=>TP_MUX_4_to_1_output_10(7),
        I4=>TPsel(2), I5=>TPsel(3), O=>TP_MUX_4_to_1_output_11(1));
        
        selection110_lut: LUT6
       generic map (INIT => X"FF00F0F0CCCCAAAA")
       port map(I0=>TP_MUX_4_to_1_output_11(0), I1=>TP_MUX_4_to_1_output_11(1), I2=>'0', I3=>'0',
       I4=>TPsel(4), I5=>'0', O=>path1_out);

        out_lut: LUT2
        generic map(INIT => "1110")
        port map(I0=>path0_out, I1=> path1_out, O=>Test_Path_o);

end Behavioral;
