----------------------------------------------------------------------------------
-- Company: Walla Walla University
-- Engineer: Stefan Hess
-- 
-- Create Date:    15:44:16 03/08/2022 
-- Design Name: 
-- Module Name:    register_file - Behavioral 
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
-- 16-bit Register File 16 registers
--
--  Input:
--      we:         write enable
--      clk:        clock
--      read_reg1:  register 1 code 4-bits
--      read_reg2:  register 2 code 4-bits
--      write_reg:  register output code 4-bits
--      write_data: data to write to write_reg 16-bits
--      pc_next:    data to write to the pc
--
--  Output:
--      reg1_data:  16-bit data from register 1
--      reg2_data:  16-bit data from register 2
--      pc:         16-bit data of the PC
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is
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
end register_file;

architecture Behavioral of register_file is
    type register_file_type is array (0 to 15) of std_logic_vector (15 downto 0);

    signal reg_file: register_file_type;
    constant PC_REG: integer:=14;

begin

    reg1_data <= reg_file(to_integer(unsigned(read_reg1)));
    reg2_data <= reg_file(to_integer(unsigned(read_reg2)));

    pc <= reg_file(PC_REG); -- read from pc

    process(clk)
    begin
        if (clk'event and clk='1') then
            if we='1' then
                reg_file(to_integer(unsigned(write_reg))) <= write_data; -- write into memory
            end if;
            reg_file(PC_REG) <= pc_next; -- write pc_next into pc
        end if;
    end process;

end Behavioral;

