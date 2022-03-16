----------------------------------------------------------------------------------
-- Company: Walla Walla University
-- Engineer: Stefan Hess
-- 
-- Create Date:    07:00:07 03/08/2022 
-- Design Name: 
-- Module Name:    ioram - Behavioral 
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
-- 16-bit RAM Memory
--
--  Input:
--      we:             write enable
--      clk:            clock line
--      address_in:     16-bit address to write to
--      data_in:        16-bit data to write in
--      address_read:   16-bit address to read out
--
--  Output:
--      data_out:   16-bit data
--
--  Output will always reflect whatever the address is on the clock edge
--  Data can be written to and read from the same address in the same clock
--  cycle, the output will reflect the previously written data.
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ioram is
    Port (  we : in std_logic;
            clk : in std_logic;
            address_in : in std_logic_vector (15 downto 0);
            data_in : in std_logic_vector (15 downto 0);
            address_read : in std_logic_vector (15 downto 0);
            data_out : out std_logic_vector (15 downto 0));
end ioram;

architecture Behavioral of ioram is
    type ioram_type is array (0 to 1) of std_logic_vector (7 downto 0); -- 8 Bytes
    signal IO_RAM : ioram_type := (others => (others => '0'));
    signal address_in_parse, address_read_parse : std_logic_vector (15 downto 0);

begin

    process(clk, address_in)
    begin
        address_in_parse <= "0000" & address_in(11 downto 0);
        if (clk'event and clk='1') then
            if (address_in(15 downto 12) = "1111" and we = '1') then
                IO_RAM(to_integer(unsigned(address_in_parse))) <= data_in(15 downto 8);
                IO_RAM(to_integer(unsigned(address_in_parse)+1)) <= data_in(7 downto 0);
            end if;
        end if;
    end process;
    address_read_parse <= "0000" & address_read(11 downto 0);
    data_out <= (IO_RAM(to_integer(unsigned(address_read_parse))) & 
                            IO_RAM(to_integer(unsigned(address_read_parse)+1))); -- Big Endian

end Behavioral;
