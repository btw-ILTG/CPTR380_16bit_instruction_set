----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Stefan Hess
-- 
-- Create Date:    18:45:20 02/27/2022 
-- Design Name: 	 CPTR380 Instruction Set
-- Module Name:    instruction_set - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

----------------------------------------------------------------------------
--
--      Derived Clock generator.  Generates square waves
--         L.Aamodt
--           As shown, if mclk is 50Mhz t_reg and slowclk are 500hz
--
--      Edited by Stefan to be a about 5Hz and then edited to be variable
--
--	-------------- clock generator -------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity clock_generator is 
    generic(COUNT_MAX:integer;
            REG_SIZE:integer);
    Port (  master_clk : in std_logic;
             derived_clk : out std_logic);
end clock_generator;

architecture Behavioral of clock_generator is

	signal clk_next, clk_reg : unsigned(REG_SIZE-1 downto 0); -- to make it all the way to 4999999
	signal t_next, t_reg : std_logic;
begin
	process(master_clk)
	begin
		if (master_clk'event and master_clk='1') then
			clk_reg <= clk_next;
			t_reg <= t_next;		--  T-f/f register
		end if;
	end process;

	clk_next <= (others=>'0') when clk_reg=COUNT_MAX else clk_reg+1;
	t_next <= (not t_reg) when clk_reg = COUNT_MAX else t_reg;

	Clk_Buffer: BUFG       -- Put t_reg on a buffered clock line
		port map ( I => t_reg, O => derived_clk);
	            -- use slowclk to run flip/flops and counters
					-- slowclk is a square wave
					-- with 500 Hz frequency -- modified to 5Hz

end Behavioral;
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- BEGIN Mux
-- Simple 2 to 1 mux
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity mux_2 is
    generic (DATA_WIDTH:integer); 
    Port ( in_0 : in  std_logic_vector (DATA_WIDTH-1 downto 0);
           in_1 : in  std_logic_vector (DATA_WIDTH-1 downto 0);
           select_line : in std_logic;
           data_out : out std_logic_vector (DATA_WIDTH-1 downto 0));
end mux_2;

architecture Behavioral of mux_2 is
begin
    with select_line select
        data_out <= in_0 when '0',
                    in_1 when '1';
end Behavioral;

----------------------------------------------------------------------------------
-- BEGIN Adder
-- Simple adder for PC incrementation
-- Even works with PC relative addressing as long as
-- the Immediate IS SIGN EXTENDED
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_adder is
    Port ( in_0 : in  std_logic_vector (15 downto 0);
           in_1 : in  std_logic_vector (15 downto 0);
           add_out : out std_logic_vector (15 downto 0));
end pc_adder;

architecture Behavioral of pc_adder is
begin
    add_out <= std_logic_vector(unsigned(in_0)+unsigned(in_1));
end Behavioral;

----------------------------------------------------------------------------------
-- BEGIN Sign extend
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_ext is
    generic (DATA_IN_WIDTH:integer);
    Port ( input : in std_logic_vector(DATA_IN_WIDTH-1 downto 0);
           sign_ext_out : out std_logic_vector(15 downto 0)); 
end sign_ext;

architecture Behavioral of sign_ext is
begin
    sign_ext_out <= std_logic_vector(resize(signed(input), 16));
end Behavioral;

----------------------------------------------------------------------------------
-- BEGIN Left shift
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity left_shift is
    generic (SHIFT_AMOUNT:integer;
             DATA_IN_WIDTH:integer;
             DATA_OUT_WIDTH:integer);
    Port ( input : in std_logic_vector(DATA_IN_WIDTH-1 downto 0);
           left_shift_out : out std_logic_vector(DATA_OUT_WIDTH-1 downto 0)); 
end left_shift;

architecture Behavioral of left_shift is
    signal resized_input: unsigned(DATA_OUT_WIDTH-1 downto 0);
begin
    resized_input <= resize(unsigned(input), DATA_OUT_WIDTH);
    left_shift_out <= std_logic_vector(shift_left(resized_input, SHIFT_AMOUNT));
end Behavioral;

----------------------------------------------------------------------------------
-- BEGIN Bin to 7Seg 
-- Code provided by Dr. Larry Aamodt
-- Further modified by Stefan to display hex
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity bin2_7seg is
    Port ( data : in  std_logic_vector (3 downto 0);
           cath_out : out  std_logic_vector (7 downto 0));
end bin2_7seg;
architecture Behavioral of bin2_7seg is

begin
	process(data)
		begin
			case data is
				when "0000" => cath_out <= "11000000"; -- 0
				when "0001" => cath_out <= "11111001"; -- 1
				when "0010" => cath_out <= "10100100"; -- 2
				when "0011" => cath_out <= "10110000"; -- 3
				when "0100" => cath_out <= "10011001"; -- 4
				when "0101" => cath_out <= "10010010"; -- 5
				when "0110" => cath_out <= "10000010"; -- 6
				when "0111" => cath_out <= "11111000"; -- 7
				when "1000" => cath_out <= "10000000"; -- 8
				when "1001" => cath_out <= "10010000"; -- 9
				when "1010" => cath_out <= "10001000"; -- A
				when "1011" => cath_out <= "10000011"; -- b
				when "1100" => cath_out <= "11000110"; -- C
				when "1101" => cath_out <= "10100001"; -- d
				when "1110" => cath_out <= "10000110"; -- E
				when "1111" => cath_out <= "10001110"; -- F
				when others => cath_out <= "10000110";			
			end case;
	end process;
end Behavioral;
----------------------------------------------------------------------------------
-- END Bin to 7Seg
----------------------------------------------------------------------------------

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity instruction_set is
	Port (sw : in std_logic_vector (3 downto 0);
            mclk : in std_logic;
			cath : out std_logic_vector (7 downto 0);
			anode : out std_logic_vector (5 downto 1);
            led : out std_logic_vector (15 downto 0);
            tek1 : out std_logic_vector (7 downto 0);
            tek2 : out std_logic_vector (7 downto 0));
end instruction_set;

architecture Behavioral of instruction_set is


	component bin2_7seg
		Port ( data : in  std_logic_vector (3 downto 0);
                cath_out : out  std_logic_vector (7 downto 0));
	end component;

    component clock_generator is 
        generic(COUNT_MAX:integer;
                REG_SIZE:integer);
        Port (  master_clk : in std_logic;
                 derived_clk : out std_logic);
    end component;

    component bram is
        Port ( we : in std_logic;
                clk : in std_logic;
                address : in std_logic_vector (15 downto 0);
                data_in : in std_logic_vector (15 downto 0);
                data_out : out std_logic_vector (15 downto 0));
    end component;

    component alu_16bit is
        Port (ctrl_lines : in std_logic_vector (2 downto 0);
                reg_1 : in std_logic_vector (15 downto 0);
                reg_2 : in std_logic_vector (15 downto 0);
                result : out std_logic_vector (15 downto 0);
                overflow : out std_logic;
                zero : out std_logic);
    end component;

    component rom_prg is
        Port (  clk : in std_logic;
                address : in std_logic_vector (15 downto 0);
                data_out : out std_logic_vector (15 downto 0));
    end component;

    component sign_ext is
        generic (DATA_IN_WIDTH:integer);
        Port ( input : in std_logic_vector(DATA_IN_WIDTH-1 downto 0);
               sign_ext_out : out std_logic_vector(15 downto 0)); 
    end component;

    component register_file is
        Port (  we : in std_logic;
                clk: in std_logic;
                read_reg1 : in  std_logic_vector (3 downto 0);
                read_reg2 : in  std_logic_vector (3 downto 0);
                write_reg : in  std_logic_vector (3 downto 0);
                write_data : in  std_logic_vector (15 downto 0);
                pc_next : in  std_logic_vector (15 downto 0);
                reg1_data : out  std_logic_vector (15 downto 0);
                reg2_data : out  std_logic_vector (15 downto 0);
                pc : out  std_logic_vector (15 downto 0));
    end component;

    component control_logic is
        Port ( op_code : in  std_logic_vector(3 downto 0);
                ALUOp : out std_logic_vector(2 downto 0);
                ReadRegDest : out std_logic;
                Jump : out std_logic;
                Branch : out std_logic;
                MemtoReg : out std_logic;
                MemWrite : out std_logic;
                ALUSrc : out std_logic;
                RegWrite : out std_logic;
                LoadLargeImm : out std_logic);
    end component;

    component mux_2 is
        generic (DATA_WIDTH:integer); 
        Port ( in_0 : in  std_logic_vector (DATA_WIDTH-1 downto 0);
               in_1 : in  std_logic_vector (DATA_WIDTH-1 downto 0);
               select_line : in std_logic;
               data_out : out std_logic_vector (DATA_WIDTH-1 downto 0));
    end component;

    component left_shift is
        generic (SHIFT_AMOUNT:integer;
                 DATA_IN_WIDTH:integer;
                 DATA_OUT_WIDTH:integer);
        Port ( input : in std_logic_vector(DATA_IN_WIDTH-1 downto 0);
               left_shift_out : out std_logic_vector(DATA_OUT_WIDTH-1 downto 0)); 
    end component;

    component pc_adder is
        Port ( in_0 : in  std_logic_vector (15 downto 0);
               in_1 : in  std_logic_vector (15 downto 0);
               add_out : out std_logic_vector (15 downto 0));
    end component;

    component ioram is
        Port (  we : in std_logic;
                clk : in std_logic;
                read_clk : in std_logic;
                address_in : in std_logic_vector (15 downto 0);
                data_in : in std_logic_vector (15 downto 0);
                address_read : in std_logic_vector (15 downto 0);
                data_out : out std_logic_vector (15 downto 0));
    end component;

    signal rom_scanner: unsigned(15 downto 0);
    signal rom_instr: std_logic_vector(15 downto 0);

    signal slowclk: std_logic;
    signal clk_500: std_logic;

    -- All control lines
    signal ALUOp: std_logic_vector(2 downto 0);
    signal ReadRegDest, Jump, Branch, MemtoReg, MemWrite,
                ALUSrc, RegWrite, LoadLargeImm: std_logic;

    -- For register file lines that can't be directly mapped to the reg file
    -- They need to be muxed first
    signal read_reg2: std_logic_vector(3 downto 0);
    signal write_back_data: std_logic_vector(15 downto 0);
    signal sign_ext_longImm: std_logic_vector(15 downto 0);

    -- Register file outputs
    signal reg1_data, reg2_data: std_logic_vector(15 downto 0);
    -- PC is declared further down with a biginning value of 0

    -- ALU signals
    signal overflow, zero: std_logic;
    signal alu_out: std_logic_vector (15 downto 0):="0000000000000000";
    -- Sign extended Imm
    signal sign_ext_imm: std_logic_vector (15 downto 0);
    signal alu_src_mux_out: std_logic_vector (15 downto 0);

    -- RAM signals
    signal ram_data_out: std_logic_vector (15 downto 0);
    
    -- Writeback mux
    signal wb_mux_out: std_logic_vector (15 downto 0);

    -- PC + 2
    signal pc_plus_2: std_logic_vector (15 downto 0);

    -- From left shift to branch adder
    signal left_shift_branch_imm: std_logic_vector(15 downto 0);


    -- Branch address
    signal branch_addr: std_logic_vector(15 downto 0);
    signal pc_branch_next: std_logic_vector(15 downto 0);

    -- Jump address stuff
    signal jump_low_bits: std_logic_vector(12 downto 0);
    signal jump_address: std_logic_vector(15 downto 0);

    -- PC next
    signal pc_next: std_logic_vector(15 downto 0);
    signal pc: std_logic_vector(15 downto 0):="0000000000000000";

    -- For input to mux to select branch address
    signal branch_and_zero: std_logic;

    -- 7 seg output
    signal digit_out, digit_next: unsigned(1 downto 0);
    signal io_data, io_addr_read: std_logic_vector(15 downto 0);
    signal io_data_out: std_logic_vector(3 downto 0);

begin 

    clock_gen: clock_generator generic map(COUNT_MAX => 4999999, REG_SIZE => 23)
                                    port map(master_clk => mclk, derived_clk => slowclk);

    clock_gen_500: clock_generator generic map(COUNT_MAX => 49999, REG_SIZE => 17)
                                    port map(master_clk => mclk, derived_clk => clk_500);

    -- used for looking at the signals for debugging, will leave here just in case

    --tek2 <= "00000000";
    --tek1 <= "00000000";

    --tek2 <= rom_instr(15 downto 8);
    --tek1 <= rom_instr(7 downto 0);

    --tek2 <= io_data(15 downto 8);
    --tek1 <= io_data(7 downto 0);

    --tek2 <= io_addr_read(7 downto 0);
    --tek1 <= io_data(7 downto 0);

    --tek2 <= reg1_data(15 downto 8);
    --tek1 <= reg1_data(7 downto 0);

    --tek2 <= reg2_data(15 downto 8);
    --tek1 <= reg2_data(7 downto 0);

    --tek2 <= reg1_data(7 downto 0);
    --tek1 <= reg2_data(7 downto 0);

    --tek2 <= ALUOp & ReadRegDest & Jump & Branch & MemtoReg & MemWrite;
    --tek1 <= ALUSrc & RegWrite & LoadLargeImm & pc(4 downto 0);

    --tek2 <= alu_out(15 downto 8);
    --tek1 <= alu_out(7 downto 0);

    led <= rom_instr;

    process(clk_500)
    begin
        if (clk_500'event and clk_500 = '1') then
            digit_out <= digit_next; 
        end if;
    end process;

    digit_next <= digit_out+1;
    io_addr_read <= "1111000000000000";


    with digit_out select
        anode <= "10111" when "00",
                 "11011" when "01",
                 "11101" when "10",
                 "11110" when "11";


    io_ram: ioram port map(we => MemWrite, clk => slowclk, read_clk => clk_500, address_in => alu_out, data_in => reg2_data,
                            address_read => io_addr_read, data_out => io_data);

    
    with digit_out select
        io_data_out <= io_data(3 downto 0) when "00",
                       io_data(7 downto 4) when "01",
                       io_data(11 downto 8) when "10",
                       io_data(15 downto 12) when "11";

    out_to_7seg: bin2_7seg port map(data => io_data_out, cath_out => cath);

    -- Mux to control whether we select [3:0] (default) or [11:8] for the reg2 data
    reg2_read_mux: mux_2 generic map(DATA_WIDTH => 4) port map(in_0 => rom_instr(3 downto 0), 
                                     in_1 => rom_instr(11 downto 8), select_line => ReadRegDest,
                                     data_out => read_reg2);


    -- Takes in [7:0] and sign extends it
    sign_ext_7_0: sign_ext generic map(DATA_IN_WIDTH => 8) port map(input => rom_instr(7 downto 0),
                                                                    sign_ext_out => sign_ext_longImm);


    -- Choose either write_data (default) or sign extended [7:0] to write into register file
    write_data_mux: mux_2 generic map(DATA_WIDTH => 16) port map( in_0 => wb_mux_out, 
                                     in_1 => sign_ext_longImm, select_line => LoadLargeImm,
                                     data_out => write_back_data);


    rom_inst: rom_prg port map(clk => slowclk, address => pc, data_out => rom_instr);

    reg_file_inst: register_file port map(we => RegWrite, clk => slowclk, read_reg1 => rom_instr(7 downto 4),
                                            read_reg2 => read_reg2, write_reg => rom_instr(11 downto 8),
                                            write_data => write_back_data, pc_next => pc_next,
                                            reg1_data => reg1_data, reg2_data => reg2_data, pc => pc);


    -- Takes in [3:0] and sign extends it
    sign_ext_3_0: sign_ext generic map(DATA_IN_WIDTH => 4) port map(input => rom_instr(3 downto 0),
                                                                    sign_ext_out => sign_ext_imm);

    -- Selects either reg2_data (default) or sign extended [3:0]
    alu_src_mux: mux_2 generic map(DATA_WIDTH => 16) port map(in_0 => reg2_data, in_1 => sign_ext_imm,
                                                                select_line => ALUSrc, data_out => alu_src_mux_out);

    -- ALU instantiation
    alu_inst: alu_16bit port map(ctrl_lines => ALUOp, reg_1 => reg1_data, reg_2 => alu_src_mux_out,
                                 result => alu_out, overflow => overflow, zero => zero);

    -- RAM instantiation
    main_ram: bram port map(we => MemWrite, clk => slowclk, address => alu_out, data_in => reg2_data, 
                                                                                data_out => ram_data_out);

    -- Writeback mux chooses between alu_out (default) and ram_data_out
    wb_mux: mux_2 generic map(DATA_WIDTH => 16) port map(in_0 => alu_out, in_1 => ram_data_out,
                                                                select_line => MemtoReg, data_out => wb_mux_out);


    -- Control logic
    control_logic_inst: control_logic port map(op_code => rom_instr(15 downto 12), ALUOp => ALUOp, 
                                               ReadRegDest => ReadRegDest, Jump => Jump, Branch => Branch,
                                               MemtoReg => MemtoReg, MemWrite => MemWrite, ALUSrc => ALUSrc,
                                               RegWrite => RegWrite, LoadLargeImm => LoadLargeImm);

    -- Add 2 to the PC                                      2
    pc_add_2: pc_adder port map(in_0 => pc, in_1 => "0000000000000010", add_out => pc_plus_2);

    -- Branch immediate left shift 1
    branch_imm_left_shift: left_shift generic map(SHIFT_AMOUNT => 1, DATA_IN_WIDTH => 16, DATA_OUT_WIDTH => 16) 
                                                port map(input => sign_ext_imm, left_shift_out => left_shift_branch_imm);

    -- Branch PC adder
    pc_add_branch: pc_adder port map(in_0 => pc_plus_2, in_1 => left_shift_branch_imm, add_out => branch_addr);

    branch_and_zero <= Branch and zero;
    -- Mux for PC + 2 (default) or branch_addr (Branch and zero)
    branch_mux: mux_2 generic map(DATA_WIDTH => 16) port map(in_0 => pc_plus_2, in_1 => branch_addr,
                                                                select_line => branch_and_zero, 
                                                                data_out => pc_branch_next);

    -- Jump address creation
    jump_shift: left_shift generic map(SHIFT_AMOUNT => 1, DATA_IN_WIDTH => 12, DATA_OUT_WIDTH => 13)
                                    port map(input => rom_instr(11 downto 0), left_shift_out => jump_low_bits);

    -- Mux for pc_branch_next (default, could be PC + 2 or branch addr) and jump address
    jump_address <= pc_plus_2(15 downto 13) & jump_low_bits;
    jump_mux: mux_2 generic map(DATA_WIDTH => 16) port map(in_0 => pc_branch_next, in_1 => jump_address,
                                                                select_line => Jump, data_out => pc_next);

end Behavioral;
