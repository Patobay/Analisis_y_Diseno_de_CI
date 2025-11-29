library ieee;
use ieee.std_logic_1164.all;
use std.env.finish;
use work.all;

entity Timer_tb is
end entity;

architecture tb of Timer_tb is 

signal tbclk : std_logic := '1';
constant clk_half_period : time := 5 ns; 

constant N : natural := 8;
signal clear, enable, z, t : std_logic;
signal reload : std_logic_vector (N-1 downto 0);

begin 

    Temporizador: entity Timer 
                  generic map (N => N)
                  port map (reload => reload, enable => enable, clear => clear, z => z, t => t, clk => tbclk);


    tbclk <= not(tbclk) after clk_half_period; 

    process
    begin
        
        reload <= "00000010";
        clear  <= '1'; wait for  (clk_half_period * 5)/2;
        clear  <= '0'; 
        enable <= '1';
        wait until z = '1';
        reload <= "00000011";
        wait until z = '1';
	wait for clk_half_period;
	finish;
    end process;

end architecture;
