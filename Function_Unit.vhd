library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Function_Unit is 
	generic ( Width : integer := 8);
	port (
				FS : in std_logic_vector(3 downto 0);
				A : in std_logic_vector(Width - 1 downto 0);
				B : in std_logic_vector(Width - 1 downto 0);
				MF_Sel : in std_logic;
				F : out std_logic_vector(Width -1 downto 0);
				Cout : out std_logic;
				Z : out std_logic
			);
end Entity Function_Unit;

Architecture RTL of Function_Unit is

	Alias H_Sel is FS(4 downto 3);
	Alias G_Sel is FS(2 downto 0);
	
	Signal G : std_logic_vector(Width - 1 downto 0);
	Signal H : Std_logic_vector(Width - 1 downto 0);
	
begin
	
	ALU_Inst : entity work.ALU generic map (Width => Width) port map(FS,A,B,G,Cout);
	Shift_Inst : entity work.Shifter generic map (Width => Width) port map(FS(1 downto 0),B,H);
	
	With MF_Sel select
		F <= 	G when '0',
				H when '1',
				(others => '0') when others;
	
	Z <= '1' when (to_integer(unsigned(G)) = 0) else '0';
	
end;