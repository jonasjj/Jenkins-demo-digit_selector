library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.constants.all;

entity digit_selector is
  generic (
    cnt_bits : integer := digit_sel_cnt_bits
  );
  port (
    clk : in std_logic;
    rst : in std_logic;
    digit_sel : out std_logic
  );
end digit_selector; 

architecture rtl of digit_selector is

  -- Clock cycle counter for alternating between digits
  -- refresh_rate = clk_frequency / (2 ** cnt_bits)
  signal clk_cnt : unsigned(cnt_bits - 1 downto 0);

begin

  digit_sel <= clk_cnt(clk_cnt'high);

  COUNT_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        clk_cnt <= (others => '0');
        
      else
        clk_cnt <= clk_cnt + 1;
        
      end if;
    end if;
  end process;

end architecture;