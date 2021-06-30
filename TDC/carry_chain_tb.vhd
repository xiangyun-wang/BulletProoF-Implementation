----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/30/2021 11:48:03 AM
-- Design Name: 
-- Module Name: carry_chain_tb - Behavioral
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

entity carry_chain_tb is
--    Port (
--    mpsclk      : in  std_logic;
--    path        : in  std_logic;
--    TVal        : out integer
--    );
end carry_chain_tb;

architecture Behavioral of carry_chain_tb is
    component carry_chain is
        Port ( 
        mpsclk      : in  std_logic;
        path        : in  std_logic;
        TVal        : out integer
    );    
    end component;
    
    constant clk_period: time := 1 ns;
    signal clk: std_logic :='0';
    signal path: std_logic := '0';
    signal TVal: integer;
    
        
begin
    
    Test: carry_chain port map(mpsclk => clk, path => path, TVal => TVal);
    
    path_process: process
    begin
        path <= '0';
        wait for clk_period;
        path <= '1';
        wait for clk_period;          
    end process;
    
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;


end Behavioral;
