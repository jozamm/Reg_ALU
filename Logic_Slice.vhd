library ieee;
use ieee.std_logic_1164.all;

Entity Logic_Slice is
	Port (
	
				Sel : in std_logic_vector(1 downto 0);
				A : in std_logic;
				B : in std_logic;
				Logic_out : out std_logic
			);
End Entity Logic_Slice;

Architecture RTL of Logic_Slice is
	
	Signal AND_op : std_logic;
	Signal OR_op : std_logic;
	Signal NOT_op : std_logic;
	Signal XOR_op : std_logic;
	
Begin
	
	AND_op <= A and B;
	OR_op <= A or B;
	NOT_op <= not A;
	XOR_op <= A xor B;
	
	with Sel select
	Logic_out <= 	AND_op 	when "00",
						OR_op 	when "01",
						NOT_op 	when "10",
						XOR_op 	when "11",
						'0' 		when others;

End Architecture RTL;
	