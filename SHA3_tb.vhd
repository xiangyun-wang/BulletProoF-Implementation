LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY SHA3_tb IS
END SHA3_tb;

ARCHITECTURE Behaviour of SHA3_tb IS

	COMPONENT SHA3_Function IS

	port(
	message_out_checker: out std_logic_vector(199 downto 0);
	round_constant_checker: out std_logic_vector(7 downto 0);
	clk:				in std_logic;
	data_ready: in std_logic;
	more_data: in std_logic;
	rst: in std_logic;
	configuration_in : in std_logic_vector (31 downto 0);
	data_request: out std_logic;
	hash_out : out std_logic_vector
	);

	END COMPONENT;

		signal clk : std_logic := '1';
    constant clk_period : time := 1 ns;
		--- debug protocal
		signal data_ready: std_logic;
		signal more_data:  std_logic;
		signal rst:  std_logic;
		signal configuration_in:  std_logic_vector (31 downto 0);
		signal data_request:  std_logic;
		signal hash_out:  std_logic_vector(199 downto 0);

		signal round_constant_checker : std_logic_vector(7 downto 0);

		signal message_out_checker : std_logic_vector(199 downto 0);

    BEGIN

    	dut: SHA3_Function port MAP(
				message_out_checker => message_out_checker,
				round_constant_checker => round_constant_checker,
    		clk => clk,
				data_ready => data_ready,
				more_data => more_data,
				rst => rst,
				configuration_in => configuration_in,
				data_request => data_request,
				hash_out => hash_out

    		);
      clk_process : process
    	BEGIN
        clk <= '1';
        wait for clk_period/2;
        clk <= '0';
        wait for clk_period/2;
    	END PROCESS;

    	test_process : process
    	begin
				wait for clk_period*2;
     		data_ready <= '1';
				more_data <= '1';
				configuration_in <= "10000000000000000000000000000000";
				wait for clk_period*1;
				more_data <= '0';
    		wait;
    	END PROCESS;

    END;
