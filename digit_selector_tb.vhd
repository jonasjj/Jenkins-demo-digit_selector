library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.sim.all;

entity digit_selector_tb is
end digit_selector_tb; 

architecture sim of digit_selector_tb is

  constant cnt_bits : integer := 4;

  signal clk : std_logic := '1';
  signal rst : std_logic := '1';
  signal digit_sel : std_logic;

begin

  clk <= not clk after sim_clk_period / 2;

  DUT : entity seg7.digit_selector(rtl)
  generic map (
    cnt_bits => cnt_bits
  )
  port map (
    clk => clk,
    rst => rst,
    digit_sel => digit_sel
  );

  SEQUENCER_PROC : process
    variable next_val : std_logic;

  begin
    wait for sim_clk_period * 2;
    rst <= '0';

    report "Checking value after reset";

    assert digit_sel = '0' or digit_sel = '1'
      report "digit sel has non-binary value"
      severity failure;
    
      
    wait for sim_clk_period;
      
    for i in 0 to 5 loop
      next_val := not digit_sel;

      wait for ((2 ** cnt_bits) * sim_clk_period) / 2;

      report "Checking digit_sel = " & std_logic'image(digit_sel);

      assert digit_sel = next_val
        report "digit_sel did not invert within expected time"
        severity failure;

    end loop;

    print_ok_and_finish;
  end process;

end architecture;