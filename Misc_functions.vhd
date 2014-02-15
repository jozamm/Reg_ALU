library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;

package Misc_functions is
		Function log2Val( Data : integer) return integer;
end Misc_functions;

package body Misc_functions is

	Function log2Val( Data : integer) return integer is
   begin
		return integer(ceil(log2(real(Data))));		
	end ;

end Misc_functions;