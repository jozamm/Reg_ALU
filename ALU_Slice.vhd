library ieee;
use ieee.std_logic_1164.all;

Entity ALU_Slice is
	Port (
				Sel : in std_logic_vector(1 downto 0);
				A : in std_logic;
				B : in std_logic;
				Cin : in std_logic;
				ALU_Result : out std_logic;
				Cout : out std_logic
			);
End Entity ALU_Slice;

Architecture RTL of ALU_Slice is

	Signal Y : std_logic;

Begin
	
	with Sel select
		Y <= '0' when "00",
				B when "01",
				not B when "10",
				'1' when "11",
				'1' when others;
				

	ALU_Result <= A xor Y xor Cin;
	Cout <= (A and Y) or (A and Cin) or (Y and Cin);

End Architecture RTL;