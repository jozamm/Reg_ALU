library ieee;
use ieee.std_logic_1164.all;

entity Shifter is 
	Generic( Width : integer := 8);
	port (
				Sel : in std_logic_vector(1 downto 0);
				B : in std_logic_vector(Width - 1 downto 0);
				H : out std_logic_vector(Width -1 downto 0)
			);
end Entity Shifter;

Architecture RTL of shifter is
begin

	with Sel Select
		H <= 	B when "00",
				'0' & B(B'high downto 1) when "01",
				B(B'high-1 downto 0) & '0' when "10",
				(Others => 'X') when "11",
				(Others => '0') when others;
				
End Architecture RTL;