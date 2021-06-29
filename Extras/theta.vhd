----------------------------------------------------------------------------------
-- Author: Yicheng Song 
-- 
-- Create Date: 05/25/2021 02:57:56 PM
-- Design Name: Keccak sponge function implementation section Theta
-- Module Name: theta - Behavioral
-- Project Name: Keccak
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- Using Keccak-f[200], i.e. 18 rounds needed and each array length is 8 bits
-- All rotate are counter-clockwise rotate, i.e. right rotate
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;

entity theta is
    Port ( 
           message_in : in std_logic_vector (199 downto 0);
           message_out : out std_logic_vector(199 downto 0)
         );
end theta;

architecture Behavioral of theta is

    type plane is array (4 downto 0) of std_logic_vector(7 downto 0);
    type state is array (4 downto 0) of plane;
    
    signal sum_sheet : plane;
    signal theta_in, theta_out : state;

begin
--map input signal to state signal
    theta_in(0)(0)(7 downto 0) <= message_in(7 downto 0);
    theta_in(0)(1)(7 downto 0) <= message_in(15 downto 8);
    theta_in(0)(2)(7 downto 0) <= message_in(23 downto 16);
    theta_in(0)(3)(7 downto 0) <= message_in(31 downto 24);
    theta_in(0)(4)(7 downto 0) <= message_in(39 downto 32);
    theta_in(1)(0)(7 downto 0) <= message_in(47 downto 40);
    theta_in(1)(1)(7 downto 0) <= message_in(55 downto 48);
    theta_in(1)(2)(7 downto 0) <= message_in(63 downto 56);
    theta_in(1)(3)(7 downto 0) <= message_in(71 downto 64);
    theta_in(1)(4)(7 downto 0) <= message_in(79 downto 72);
    theta_in(2)(0)(7 downto 0) <= message_in(87 downto 80);
    theta_in(2)(1)(7 downto 0) <= message_in(95 downto 88);
    theta_in(2)(2)(7 downto 0) <= message_in(103 downto 96);
    theta_in(2)(3)(7 downto 0) <= message_in(111 downto 104);
    theta_in(2)(4)(7 downto 0) <= message_in(119 downto 112);
    theta_in(3)(0)(7 downto 0) <= message_in(127 downto 120);
    theta_in(3)(1)(7 downto 0) <= message_in(135 downto 128);
    theta_in(3)(2)(7 downto 0) <= message_in(143 downto 136);
    theta_in(3)(3)(7 downto 0) <= message_in(151 downto 144);
    theta_in(3)(4)(7 downto 0) <= message_in(159 downto 152);
    theta_in(4)(0)(7 downto 0) <= message_in(167 downto 160);
    theta_in(4)(1)(7 downto 0) <= message_in(175 downto 168);
    theta_in(4)(2)(7 downto 0) <= message_in(183 downto 176);
    theta_in(4)(3)(7 downto 0) <= message_in(191 downto 184);
    theta_in(4)(4)(7 downto 0) <= message_in(199 downto 192);

--compute sum of the columns
t0001: for x in 0 to 4 generate
    t0002: for i in 0 to 7 generate
        sum_sheet(x)(i) <= theta_in(0)(x)(i) xor theta_in(1)(x)(i) xor theta_in(2)(x)(i) xor theta_in(3)(x)(i) xor theta_in(4)(x)(i);
    end generate;
 end generate;

--rotate sum and compute the theta output
--x from 1 to 3
t0010: for y in 0 to 4 generate
    t0011: for x in 1 to 3 generate
        theta_out(y)(x)(0) <= theta_in(y)(x)(0) xor sum_sheet(x - 1)(0) xor sum_sheet(x + 1)(7);
        t0012: for i in 1 to 7 generate
            theta_out(y)(x)(i) <= theta_in(y)(x)(i) xor sum_sheet(x - 1)(i) xor sum_sheet(x + 1)(i - 1);
        end generate;
    end generate;
end generate;

--x = 0
t0020: for y in 0 to 4 generate
    theta_out(y)(0)(0) <= theta_in(y)(0)(0) xor sum_sheet(4)(0) xor sum_sheet(1)(7);
    t0021: for i in 1 to 7 generate
        theta_out(y)(0)(i) <= theta_in(y)(0)(i) xor sum_sheet(4)(i) xor sum_sheet(1)(i - 1);
    end generate;
end generate;

--x = 4
t0030: for y in 0 to 4 generate
    theta_out(y)(4)(0) <= theta_in(y)(4)(0) xor sum_sheet(3)(0) xor sum_sheet(0)(7);
    t0031: for i in 1 to 7 generate
        theta_out(y)(4)(i) <= theta_in(y)(4)(i) xor sum_sheet(3)(i) xor sum_sheet(0)(i - 1);
    end generate;
end generate;

end Behavioral;
