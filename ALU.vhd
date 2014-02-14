library ieee;
use ieee.std_logic_1164.all;

entity ALU is 
	generic ( Width : integer := 8);
	port (
				Sel : in std_logic_vector(3 downto 0);
				A : in std_logic_vector(Width - 1 downto 0);
				B : in std_logic_vector(Width - 1 downto 0);
				G : out std_logic_vector(Width -1 downto 0);
				Cout : out std_logic
			);
end Entity ALU;

Architecture RTL of ALU is

	Component Logic_Slice is
	Port (
	
				Sel : in std_logic_vector(1 downto 0);
				A : in std_logic;
				B : in std_logic;
				Logic_out : out std_logic
			);
	End Component Logic_Slice;
	
	Component ALU_Slice is
	Port (
				Sel : in std_logic_vector(1 downto 0);
				A : in std_logic;
				B : in std_logic;
				Cin : in std_logic;
				ALU_Result : out std_logic;
				Cout : out std_logic
			);
	End Component ALU_Slice;

	Signal ALU_out : std_logic_vector(Width - 1 downto 0);
	Signal Logic_out : std_logic_vector(Width - 1 downto 0);
	Signal Carry_out : std_logic_vector(Width downto 0);
	

begin
 
	Logic_Generate :	for L in 0 to (Width - 1)  generate
								LS : Logic_Slice port map(Sel(2 downto 1),A(L),B(L),Logic_out(L));
							end generate Logic_Generate;
	
	Carry_out(0) <= Sel(0);
	
	ALU_Generate :	for L in 0 to (Width - 1)  generate
								ALUS : ALU_Slice port map(Sel(2 downto 1),A(L),B(L),Carry_out(L),ALU_out(L),Carry_out(L+1));
							end generate ALU_Generate;
	
	G <= ALU_out when Sel(3) = '0' else Logic_out;
	
	Cout <= Carry_out(Width);
	
end Architecture RTL;