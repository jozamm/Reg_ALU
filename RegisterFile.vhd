library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Misc_functions.all;

Entity RegisterFile is
	Generic ( Width : integer := 8; --Width of Register
				 Regs : integer := 8 ); --Number of Registers
	Port (
				Reset : in std_logic;
				Clock : in std_logic;
				A_addr : in std_logic_vector(log2Val(Regs) - 1 downto 0);
				B_addr : in std_logic_vector(log2Val(Regs) - 1 downto 0);
				Dest : in std_logic_vector(log2Val(Regs) - 1 downto 0);
				LE : in std_logic;
				D_data : in std_logic_vector(Width - 1 downto 0);
				A_data : out std_logic_vector(Width - 1 downto 0);
				B_data : out std_logic_vector(Width - 1 downto 0)
			);
End Entity RegisterFile;

Architecture RTL of RegisterFile is

	Type Reg_Array is array(0 to Regs -1) of std_logic_vector(Width - 1 downto 0);
	Signal RegFile : Reg_Array;
	
begin
	
	--Create RAM Registers
	Process(Reset,Clock,LE)
	Begin
		if (Reset = '1') then
			for L in 0 to (Regs-1) loop
				RegFile(L) <= (others => '0');
			end loop;
		elsif (rising_edge(Clock)) then
			if (LE = '1') then 
				RegFile(to_integer(unsigned(Dest))) <= D_data;
			end if;
		end if;
	End process;
	
	--Access A Data
	A_data <= RegFile(to_integer(unsigned(A_addr)));
		
	--Access B Data
	B_data <= RegFile(to_integer(unsigned(B_addr)));
	
End;