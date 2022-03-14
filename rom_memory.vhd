----------------------------------------------------------------------------------
-- Company: Walla Walla University
-- Engineer: Stefan Hess
-- 
-- Create Date:    07:33:07 03/08/2022 
-- Design Name: 
-- Module Name:    rom_memory - Behavioral 
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
-- 16-bit ROM Memory
--
--  Input:
--      clk:        clock line
--      address:    16-bit address
--
--  Output:
--      data_out:   16-bit data
--
--  Program memory
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_prg is
    generic (ROM_LENGTH:integer:=256); -- Total length of ROM in bytes
            
    Port (  clk : in std_logic;
            address : in std_logic_vector (15 downto 0);
            data_out : out std_logic_vector (15 downto 0));
end rom_prg;

architecture Behavioral of rom_prg is
    type rom_type is array (0 to ROM_LENGTH-1) of std_logic_vector (7 downto 0);
    constant ROM: rom_type:=( -- 256x8 bits
        --x"31", x"02", x"00", x"00", x"00", x"00", x"00", x"00",

        --x"81", x"0F", x"41", x"1C", x"00", x"00", x"82", x"07", 
        --x"D2", x"10", x"31", x"12", x"82", x"03", x"D2", x"10",
        --x"31", x"12", x"D2", x"10", x"31", x"12", x"82", x"01",
        --x"D2", x"10", x"00", x"00", x"00", x"00", x"00", x"00",

        x"81", x"0F", x"41", x"1C", x"85", x"07", x"86", x"06",
        x"87", x"00", x"88", x"00", x"E8", x"63", x"17", x"75",
        x"38", x"81", x"F0", x"06", x"D7", x"10", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",

        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",

        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",

        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",

        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",

        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",

        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",

        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00");


begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            data_out <= (ROM(to_integer(unsigned(address))) & ROM(to_integer(unsigned(address)+1))); -- Big Endian
        end if;
    end process;
end Behavioral;
