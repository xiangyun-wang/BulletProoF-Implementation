----------------------------------------------------------------------------------
-- Company: McGill University
-- Engineer: Xiangyun Wang
--
-- Create Date: 08/10/2021 04:07:28 PM
-- Design Name:
-- Module Name: Top - Behavioral
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

entity Top is
    Port (
    key : out std_logic_vector(255 downto 0); -- key generated
    key_status : out std_logic := '0'         -- key generation status, 0 is NOT finished, 1 is finished
    );
end Top;

architecture Behavioral of Top is

component TimeData is
 Port (
    clk : in STD_LOGIC;                 -- clock signal
    Launch : in std_logic;              -- Lacunch signal
    to_CC : in std_logic;               -- propagation signal to Carry Chain
    testpath_passed : out std_logic;    -- flag to indicate if testpath test passed
    finished : out std_logic;           -- flag to indicate if signal timing finishes
    retry : out std_logic;              -- flag to indicate if current signal path needs to be retimed
    Time_Measured : out STD_LOGIC_VECTOR (15 downto 0));    -- timing data
end component;

component SHA3_Function is
    port(
    clk: in std_logic;                -- clock signal
    data_ready: in std_logic;         -- flag to indicate if the input data is ready for SHA3
    end_of_all_data: in std_logic;    -- flag to indicate if there is no more data for SHA3
    data_request: out std_logic;      -- request flag for more data
    to_CC : out std_logic;            -- propagating signal to Carry Chain
    Launch : out std_logic;           -- Launch signal
    CC_finished : in std_logic;       -- flag to indicate if signal timing finishes
    CC_retry : in std_logic;          -- flag to indicate if current signal path needs to be retimed
    PUF_start : in std_logic;         -- start signal for the timing operation
    timing_data_generation_finished : out std_logic -- flag to indicate if the timing data generation process finishes
  );
end component;

component RO is
 Port (
    clk : out STD_LOGIC;     -- this output an approximately 120MHz clock
    rst : in std_logic);    -- reset signal for ring oscillator
end component;

component BRAM_test is
 Port (
        DO : out std_logic_vector(15 downto 0);     -- data output from bram
        ADDR : in std_logic_vector(11 downto 0);    -- address for bram access
        CLK : in std_ulogic;                        -- clock signal
        DI : in std_logic_vector(15 downto 0);      -- data input for bram
        EN : in std_ulogic;
        REGCE : in std_ulogic;
        RST : in std_ulogic;                        -- reset signal
        WE : in std_logic_vector(1 downto 0));      -- byte write enable
end component;

component clk_wiz_0
port
 (-- Clock in ports
  -- Clock out ports
  clk_out25          : out    std_logic;        -- clock output signal
  clk_out50          : out    std_logic;
  clk_out100          : out    std_logic;
  -- Status and control signals
  reset             : in     std_logic;         -- reset signal
  locked            : out    std_logic;
  clk_in1           : in     std_logic          -- clock source input
 );
end component;

-- TO DO:
-- component icap_data
-- port(
--     data_ready : out std_logic;        -- flog to indicate if icap data is ready
--     end_of_all_data : out std_logic;   -- flag to indicate if all data are read
--     data_request : in std_logic;       -- flag to indicate if data is requested from icap
--     clk : in std_logic                 -- clock signal
-- );
-- end component;

component Key_Generation
port(
    key_generation_start : in std_logic;                    -- flag to indicate if key generation can be started
    clk : in std_logic;                                     -- clock signal
    data_in : in std_logic_vector(31 downto 0);             -- data for key generation
    data_request : out std_logic;                           -- data request for key generation
    data_ready  : in std_logic;                             -- flag to see if data ready for key generation
    no_more_data : in std_logic;                            -- flag to indicate if there is no more timing data left for key generation
    key_generated : out std_logic_vector(255 downto 0);     -- generated key
    key_generation_finished : out std_logic                 -- flag to indicate key generation finished
);
end component;

-- clock
signal clk_out25, clk_out50, clk_out100, reset, locked, clk_in1 : std_logic;  -- signal for clock

-- TimeData
signal Launch, to_CC, testpath_passed, finished, retry : std_logic;           -- signal for timedata
signal Time_Measured : std_logic_vector(15 downto 0);

-- BRAM
signal DO,DI : std_logic_vector(15 downto 0);                       -- signal for bram
signal ADDR : std_logic_vector(11 downto 0) := "000000000000";
signal EN, REGCE, RST : std_logic;
signal WE : std_logic_vector(1 downto 0) := "11";

-- icap
signal data_ready, end_of_all_data, data_request : std_logic;   -- signal for ICAP

-- SHA3
signal PUF_start, timing_data_generation_finished : std_logic;  -- signal for SHA3

-- key generation
signal key_generation_start : std_logic := '0';       -- signal for key generation
signal  key_generation_data_request, key_generation_data_ready, key_generation_no_more_data, key_generation_finished: std_logic;
signal key_generation_data_in : std_logic_vector(31 downto 0);
signal key_generated : std_logic_vector(255 downto 0);

-- bram access for key generation
signal read_addr : std_logic_vector(11 downto 0) := "000000000000";
signal read_counter : integer := 0;

-- special type for read
type read_outs is array(0 to 2) of std_logic_vector(15 downto 0);
signal read_time_data : read_outs;

begin

-- port map
clk_generator : clk_wiz_0
   port map (
  -- Clock out ports
   clk_out25 => clk_out25,
   clk_out50 => clk_out50,
   clk_out100 => clk_out100,
  -- Status and control signals
   reset => reset,
   locked => locked,
   -- Clock in ports
   clk_in1 => clk_in1
 );

 ring_oscillator : RO
    port map(
    clk => clk_in1,
    rst => reset
    );

TDC : TimeData
    port map(
    clk => clk_out25,
    Launch => Launch,
    to_CC => to_CC,
    testpath_passed => testpath_passed,
    finished => finished,
    retry => retry,
    Time_Measured => Time_Measured
    );

BRAM : BRAM_test
    port map(
    DO => DO,
    ADDR => ADDR,
    CLK => clk_out25,
    DI => DI,
    EN => EN,
    REGCE => REGCE,
    RST => RST,
    WE => WE
    );

entropy_source : SHA3_Function
    port map(
    clk => clk_out25,
    data_ready => data_ready,
    end_of_all_data => end_of_all_data,
    data_request => data_request,
    to_CC => to_CC,
    Launch => Launch,
    CC_finished => finished,
    CC_retry => retry,
    PUF_start => PUF_start,
    timing_data_generation_finished => timing_data_generation_finished
    );

generate_key : Key_Generation
    port map(
        key_generation_start => key_generation_start,
        clk => clk_out25,
        data_in => key_generation_data_in,
        data_request => key_generation_data_request,
        data_ready => key_generation_data_ready,
        no_more_data => key_generation_no_more_data,
        key_generated  => key_generated,
        key_generation_finished => key_generation_finished
    );


    -- process for ram storage
    -- need to test on real board
    process(finished)
    begin
      -- when timing data is generated, and the timing data is valid, store the time data
      if(finished = '1' and (Time_Measured(15 downto 8) /= "00000000" or Time_Measured(15 downto 8) /= "11111111")) then
          DI <= Time_Measured;
          ADDR <= std_logic_vector(unsigned(ADDR)+1);
      end if;
    end process;

    -- process for ram read (get 2 16-bit data)
    process(finished)
    begin
      -- when timing data geneation is finished, go to key generation
      if(finished = '1' and timing_data_generation_finished <= '1') then
        key_generation_start <= '1';
        ADDR <= std_logic_vector(unsigned(ADDR)+1);
      end if;
    end process;

    -- process for key generation
    process(key_generation_start, clk_out25)
    begin
      if(key_generation_start = '1' and rising_edge(clk_out25) and key_generation_data_request = '1') then
        -- read from bram......
        key_generation_data_ready <= '0';
        if(read_counter /= 2 and ADDR /= "000000000000") then
          ADDR <= std_logic_vector(unsigned(ADDR)-1);   -- reduce address by 1
          read_time_data(read_counter) <= DO;   -- read data (need to test how many clock cycle to wait)
          read_counter <= read_counter + 1;     -- read counter increment
        elsif (ADDR = "000000000000") then      -- if address is 0, last timing data
          key_generation_no_more_data <= '1';
          key_generation_data_ready <= '1';
        else                                    -- reset read counter
          read_counter <= 0;
          key_generation_data_ready <= '1';
        end if;
      end if;
    end process;

key_generation_data_in <= read_time_data(0)&read_time_data(1);    -- timing data to key generation

key <= key_generated;                           -- key generated
key_status <= key_generation_finished;          -- key generation status

-- PUF start with testpath_passed
PUF_start <= testpath_passed;                 -- to seee if PUF timing can be started (if testpath test has passed)

end Behavioral;
