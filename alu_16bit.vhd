----------------------------------------------------------------------------------
-- Company: Walla Walla University
-- Engineer: Stefan Hess
-- 
-- Create Date:    07:00:07 03/08/2022 
-- Design Name: 
-- Module Name:    alu_16bit - Behavioral 
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
----------------------------------------------------------------------------------
-- 16-bit ALU
-- Operations: Add, Sub, Shift, AND, OR, XOR
-- 
--	Input:
--		3 control lines
--          000: No operation
--          001: Add
--          010: Sub
--          011: Shift Left
--          100: Shift Right
--          101: AND
--          110: OR
--          111: XOR
--
--		2 16-bit numbers
--
--	Output:
--		1 16-bit number resulting from the operation
--      1 bit representing whether there was an overflow
--      1 bit asserted if operation resulted in a zero (good for branching)
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_16bit is
    Port (ctrl_lines : in std_logic_vector (2 downto 0);
            reg_1 : in std_logic_vector (15 downto 0);
            reg_2 : in std_logic_vector (15 downto 0);
            result : out std_logic_vector (15 downto 0);
            overflow : out std_logic;
            zero : out std_logic);
end alu_16bit;

architecture Behavioral of alu_16bit is
    signal res_inter: std_logic_vector (15 downto 0);

begin

    with ctrl_lines select
        res_inter <= std_logic_vector(signed(reg_1) + signed(reg_2)) when "001", -- Add
                     std_logic_vector(signed(reg_1) - signed(reg_2)) when "010", -- Sub
                     std_logic_vector(shift_left(signed(reg_1), to_integer(unsigned(reg_2(3 downto 0))))) when "011", 
                                                                                        -- Shift Left don't want sign ext
                     std_logic_vector(shift_right(signed(reg_1), to_integer(unsigned(reg_2(3 downto 0))))) when "100", 
                                                                                        -- Shift Right don't want sign ext
                     std_logic_vector(reg_1 and reg_2) when "101", -- AND
                     std_logic_vector(reg_1 or reg_2) when "110", -- OR
                     std_logic_vector(reg_1 xor reg_2) when "111", -- XOR
                     (others => '0') when others;

    with ctrl_lines select
        overflow <= ((not (reg_1(15) and reg_2(15)) and res_inter(15)) 
                        or ((reg_1(15) and reg_2(15)) and not res_inter(15))) when "001", -- Add
                    ((not reg_1(15) and (reg_2(15) and res_inter(15))) 
                        or (reg_1(15) and (not(reg_2(15) and res_inter(15))))) when "010", -- Sub
                    '0' when others;
    result <= res_inter;

    process(res_inter)
    begin
        if res_inter = "0000000000000000" then
            zero <= '1';
        else
            zero <= '0';
        end if;
    end process;
        
end Behavioral;

