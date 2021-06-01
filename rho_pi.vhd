library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arth.all;

entity rho_pi is

  port (
    message_in: std_logic_vector (199 downto 0);
    message_in_ready: std_logic;
    message_out: std_logic_vector(199 downto 0)
    );

end rho_pi;

architecture rtl of rho_pi is

  constant row_max : integer := 5;
  constant column_max : integer := 5;
  constant lane_max : integer := 8;

  --type lane is array ((lane_max-1) downto 0) of std_logic;
  type plane is array ((column_max-1) downto 0) of std_logic_vector ((lane_max-1) downto 0);
  type state is array ((row_max-1) downto 0) of plane;

  signal A, B : state;
  signal theta_in, theta_out, pi_in, pi_out, rho_in, rho_out: state;

begin

theta_in <= A;
rho_in <= theta_out;
pi_in <= rho_out;

-- parse the input 200 bits into 5*5*8 3D array
r00: for i in 0 to 4 generate
  r01: for j in 0 to 4 generate
    A(i)(j) <= message_in ((i*40+(j+1)*8-1) downto (i*40+j*8));
  end generate;
end generate;

-- rho
rho_out(0)(0)(7 downto 0) <= rho_in(0)(0)(7 downto 0);  -- (0,0)
--rho_out(0)(0)( downto ) <= rho_in(0)(0)( downto );

rho_out(0)(1)(6 downto 0) <= rho_in(0)(1)(7 downto 1);  --(0,1)
rho_out(0)(1)(7 downto 7) <= rho_in(0)(1)(0 downto 0);

rho_out(0)(2)(1 downto 0) <= rho_in(0)(2)(7 downto 6);  --(0,2)
rho_out(0)(2)(7 downto 2) <= rho_in(0)(2)(5 downto 0);

rho_out(0)(3)(3 downto 0) <= rho_in(0)(3)(7 downto 4);  --(0,3)
rho_out(0)(3)(7 downto 4) <= rho_in(0)(3)(3 downto 0);

rho_out(0)(4)(4 downto 0) <= rho_in(0)(4)(7 downto 3);  --(0,4)
rho_out(0)(4)(7 downto 5) <= rho_in(0)(4)(2 downto 0);

rho_out(1)(0)(3 downto 0) <= rho_in(1)(0)(7 downto 4);  --(1,0)
rho_out(1)(0)(7 downto 4) <= rho_in(1)(0)(3 downto 0);

rho_out(1)(1)(3 downto 0) <= rho_in(1)(1)(7 downto 4);  --(1,1)
rho_out(1)(1)(7 downto 4) <= rho_in(1)(1)(3 downto 0);

rho_out(1)(2)(1 downto 0) <= rho_in(1)(2)(7 downto 6);  --(1,2)
rho_out(1)(2)(7 downto 2) <= rho_in(1)(2)(5 downto 0);

rho_out(1)(3)(0 downto 0) <= rho_in(1)(3)(7 downto 7);  --(1,3)
rho_out(1)(3)(7 downto 1) <= rho_in(1)(3)(6 downto 0);

rho_out(1)(4)(3 downto 0) <= rho_in(1)(4)(7 downto 4);  --(1,4)
rho_out(1)(4)(7 downto 4) <= rho_in(1)(4)(3 downto 0);

rho_out(2)(0)(4 downto 0) <= rho_in(2)(0)(7 downto 3);  --(2,0)
rho_out(2)(0)(7 downto 5) <= rho_in(2)(0)(4 downto 0);

rho_out(2)(1)(5 downto 0) <= rho_in(2)(1)(7 downto 2);  --(2,1)
rho_out(2)(1)(7 downto 6) <= rho_in(2)(1)(1 downto 0);

rho_out(2)(2)(4 downto 0) <= rho_in(2)(2)(7 downto 3);  --(2,2)
rho_out(2)(2)(7 downto 5) <= rho_in(2)(2)(2 downto 0);

rho_out(2)(3)(6 downto 0) <= rho_in(2)(3)(7 downto 1);  --(2,3)
rho_out(2)(3)(7 downto 7) <= rho_in(2)(3)(0 downto 0);

rho_out(2)(4)(0 downto 0) <= rho_in(2)(4)(7 downto 7);  --(2,4)
rho_out(2)(4)(7 downto 1) <= rho_in(2)(4)(6 downto 0);

rho_out(3)(0)(6 downto 0) <= rho_in(3)(0)(7 downto 1);  --(3,0)
rho_out(3)(0)(7 downto 7) <= rho_in(3)(0)(0 downto 0);

rho_out(3)(1)(2 downto 0) <= rho_in(3)(1)(7 downto 5);  --(3,1)
rho_out(3)(1)(7 downto 3) <= rho_in(3)(1)(4 downto 0);

rho_out(3)(2)(0 downto 0) <= rho_in(3)(2)(7 downto 7);  --(3,2)
rho_out(3)(2)(7 downto 1) <= rho_in(3)(2)(6 downto 0);

rho_out(3)(3)(2 downto 0) <= rho_in(3)(3)(7 downto 5);  --(3,3)
rho_out(3)(3)(7 downto 3) <= rho_in(3)(3)(4 downto 0);

rho_out(3)(4)(7 downto 0) <= rho_in(3)(4)(7 downto 0);  --(3,4)
--rho_out(3)(4)(7 downto ) <= rho_in(3)(4)( downto 0);

rho_out(4)(0)(5 downto 0) <= rho_in(4)(0)(7 downto 2);  --(4,0)
rho_out(4)(0)(7 downto 6) <= rho_in(4)(0)(1 downto 0);

rho_out(4)(1)(5 downto 0) <= rho_in(4)(1)(7 downto 2);  --(4,1)
rho_out(4)(1)(7 downto 6) <= rho_in(4)(1)(1 downto 0);

rho_out(4)(2)(2 downto 0) <= rho_in(4)(2)(7 downto 5);  --(4,2)
rho_out(4)(2)(7 downto 3) <= rho_in(4)(2)(4 downto 0);

rho_out(4)(3)(7 downto 0) <= rho_in(4)(3)(7 downto 0);  --(4,3)
--rho_out(4)(3)(7 downto ) <= rho_in(4)(3)( downto 0);

rho_out(4)(4)(1 downto 0) <= rho_in(4)(4)(7 downto 6);  --(4,4)
rho_out(4)(4)(7 downto 6) <= rho_in(4)(4)(5 downto 0);

-- pi
r30: for i in 0 to 4 generate
  r31: for j in 0 to 4 generate
    pi_out((2*j+3*i) mod 5)(i) <= pi_in(i)(j);
  end generate;
end generate;


end rtl;
