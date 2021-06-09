library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arth.all;

-- By Alfred

entity SHA3_Absorb is

  port (
    rst : std_logic;
    message_in: std_logic_vector (199 downto 0);
    --message_in_ready: std_logic;
    round_constant: std_logic_vector (7 downto 0);  -- all the round constant will be stored in the upper level file
    message_out: std_logic_vector(199 downto 0)
    );

end SHA3_Absorb;

architecture rtl of SHA3_Absorb is

  constant row_max : integer := 5;
  constant column_max : integer := 5;
  constant lane_max : integer := 8;

  --type lane is array ((lane_max-1) downto 0) of std_logic;
  type plane is array ((column_max-1) downto 0) of std_logic_vector ((lane_max-1) downto 0);
  type state is array ((row_max-1) downto 0) of plane;

  signal A, B : state;
  signal theta_in, theta_out, pi_in, pi_out, rho_in, rho_out, chi_in, chi_out, iota_in, iota_out, pre_output: state;

begin

theta_in <= A;
rho_in <= theta_out;
pi_in <= rho_out;
chi_in <= pi_out;
iota_in <= chi_out;
pre_output <= iota_out;

-- ** the generate notation: round_operation,step_number,outer_loop_number,inner_loop_number **
-- ** example: r000 means round_operation,step 1 (parse input),outer loop number 0, inner loop number 0 **

------------ parse ----------------
-- parse the input 200 bits into 5*5*8 3D array
r000: for i in 0 to 4 generate
  r001: for j in 0 to 4 generate
    A(i)(j)(7 downto 0) <= message_in ((i*40+(j+1)*8-1) downto (i*40+j*8));
  end generate;
end generate;

----------------------------- theta -----------------------
--compute sum of the columns
r100: for x in 0 to 4 generate
        sum_sheet(x) <= theta_in(0)(x) xor theta_in(1)(x) xor theta_in(2)(x) xor theta_in(3)(x) xor theta_in(4)(x);
 end generate;

--rotate sum and compute the theta output
--x from 1 to 3
r110: for y in 0 to 4 generate
    r111: for x in 1 to 3 generate
        theta_out(y)(x)(0) <= theta_in(y)(x)(0) xor sum_sheet(x - 1)(0) xor sum_sheet(x + 1)(7);
        r1110: for i in 1 to 7 generate
            theta_out(y)(x)(i) <= theta_in(y)(x)(i) xor sum_sheet(x - 1)(i) xor sum_sheet(x + 1)(i - 1);
        end generate;
    end generate;
end generate;

--x = 0
r120: for y in 0 to 4 generate
    theta_out(y)(0)(0) <= theta_in(y)(0)(0) xor sum_sheet(4)(0) xor sum_sheet(1)(7);
    r121: for i in 1 to 7 generate
        theta_out(y)(0)(i) <= theta_in(y)(0)(i) xor sum_sheet(4)(i) xor sum_sheet(1)(i - 1);
    end generate;
end generate;

--x = 4
r130: for y in 0 to 4 generate
    theta_out(y)(4)(0) <= theta_in(y)(4)(0) xor sum_sheet(3)(0) xor sum_sheet(0)(7);
    r131: for i in 1 to 7 generate
        theta_out(y)(4)(i) <= theta_in(y)(4)(i) xor sum_sheet(3)(i) xor sum_sheet(0)(i - 1);
    end generate;
end generate;

------------------------ rho ----------------------
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

------------------ pi -------------
r300: for i in 0 to 4 generate
  r301: for j in 0 to 4 generate
    pi_out((2*j+3*i) mod 5)(i) <= pi_in(i)(j);
  end generate;
end generate;

----------------- chi --------------
r400: for i in 0 to 4 generate
  r401: for j in 0 to 4 generate
    chi_out(i)(j) <= chi_in(i)(j) xor ((not chi_in(i)((j+1) mod 5)) and chi_in(i)((j+2) mod 5));
  end generate;
end generate;

-- r410: for i in 0 to 4 generate
--   chi_out(i)(3) <= chi_in(i)(3) xor ((not chi_in(i)(4)) and chi_in(i)(0));
-- end generate;
--
-- r420: for i in 0 to 4 generate
--   chi_out(i)(4) <= chi_in(i)(4) xor ((not chi_in(i)(0)) and chi_in(i)(1));
-- end generate;

------------------ iota -------------
-- lane (0,0)
iota_out(0)(0) <= iota_in(0)(0) xor round_constant;

-- plane 1 to 4
r500: for i in 1 to 4 generate
  r501: for j in 0 to 4 generate
    iota_out(i)(j) <= iota_in(i)(j);
  end generate;
end generate;

-- lane 1 to 4 of plane 0
r510: for j in 1 to 4 generate
  iota(0)(j) <= iota_in(0)(j);
end generate;

-- output reformate
r600: for i in 0 to 4 generate
  r601: for j in 0 to 4 generate
    message_out ((i*40+(j+1)*8-1) downto (i*40+j*8)) <= pre_output(i)(j)(7 downto 0);
  end generate;
end generate;

end rtl;
