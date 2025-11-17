library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Timer is
    generic( N : natural := 8);
    port (

        reload  			 : in std_logic_vector(N-1 downto 0); 
        enable, clear, clk   : in std_logic;
        t, z        		 : out std_logic
    );
end entity;

architecture TimerLogic of Timer is 

	signal cuenta, cuenta_sig  : unsigned(N-1 downto 0);
		
	begin

		process (clk)
	 
			begin
		
				if rising_edge(clk) then 
					cuenta <= cuenta_sig;
				end if; 
		end process;
		
		cuenta_sig <= (others => '0')   when clear = '1'else 
				      cuenta            when enable = '0' else	
				      cuenta - 1        when not z else unsigned(reload); 					  
		
		t <= cuenta ?= 1; -- si c es = 1 entonces el resultado es true , y ese booleano se guarda en t
		z <= cuenta ?= 0; 
			
		
end architecture;