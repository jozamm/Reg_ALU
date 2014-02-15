library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use work.Misc_functions.all;

--This entity implements the datapath as defined in the chapter Instruction Set Architecture
--The register file and ALU are implemented as seperate entities

Entity DataPath is
	generic ( Width : integer := 16;
				 Regs : integer := 8;
				 RAM_Size : integer := 2048);
	port (
			 Reset : in std_logic;
			 Clock : in std_logic;
			 Control_Word : in std_logic_vector(15 downto 0);
			 Const : in std_logic_vector(Width - 1 downto 0);
			 
			 Cout : out std_logic;
			 Z  :out std_logic
			);
End entity DataPath;

Architecture RTL of DataPath is

	--constant Num_Reg_Addr : integer := log2Val(Regs);
	
	--Control word aliases
	Alias LE is Control_Word(0);
	Alias MD is Control_Word(1);
	Alias FS is Control_Word(5 downto 2);
	Alias MB is Control_Word(6);
	Alias B_addr is Control_Word(9 downto 7);
	Alias A_addr is Control_Word(12 downto 10);
	Alias Dest is Control_Word(15 downto 13);
	
	Signal A_Data : std_logic_vector(Width - 1 downto 0);
	Signal B_Data : std_logic_vector(Width - 1 downto 0);
	Signal D_Data : std_logic_vector(Width - 1 downto 0);
	Signal B_Bus : std_logic_vector(Width - 1 downto 0);
	Signal D_Bus : std_logic_vector(Width - 1 downto 0);
	Signal Func_out : std_logic_vector(Width - 1 downto 0);
	
	--RAM Signals
	Signal RAM_Data_in : std_logic_vector(Width - 1  downto 0);
	Signal RAM_Data_out : std_logic_vector(Width - 1 downto 0);
	Signal RAM_Addr : std_logic_vector(log2Val(RAM_Size)-1 downto 0);
	
	
begin
	
	Registers : entity work.RegisterFile generic map (Width => Width, Regs => Regs) port map(Reset,Clock,A_addr,B_addr,Dest,LE,D_Bus,A_Data,B_Data);
	
	Functions : entity work.Function_Unit generic map (Width => Width) port map (FS,A_Data,B_Bus,FS(3),Func_out,Cout,Z); --To arrange FS
	
	RAM : entity work.RAM generic map (Size => RAM_Size, Width => Width) port map(Clock => Clock, RAM_Data_in => RAM_Data_in,RAM_Data_out => RAM_Data_out,RAM_Addr => RAM_Addr, wr_ram => MD);
	
	B_Bus <= B_Data when MB = '0' else Const;
	D_Bus <= RAM_Data_out when MD = '1' else Func_out;
	RAM_Data_in <= B_Bus;
	RAM_Addr <= A_Data(log2Val(RAM_Size)-1 downto 0);

End Architecture;