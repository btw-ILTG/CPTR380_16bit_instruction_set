----------------------------------------------------------------------------------
-- Company: Walla Walla University
-- Engineer: Stefan Hess
-- 
-- Create Date:    07:00:07 03/08/2022 
-- Design Name: 
-- Module Name:    bram - Behavioral 
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
--      we:         write enable
--      clk:        clock line
--      address:    16-bit address
--      data_in:    16-bit data
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

entity bram is
    Port (  we : in std_logic;
            clk : in std_logic;
            address : in std_logic_vector (15 downto 0);
            data_in : in std_logic_vector (15 downto 0);
            data_out : out std_logic_vector (15 downto 0));
end bram;

architecture Behavioral of bram is
    type ram_type is array (0 to 8191) of std_logic_vector (7 downto 0); -- 8 KiB
    signal RAM : ram_type := (others => (others => '0'));

begin
    process(clk)
    begin
        if (clk'event and clk='1') then
            if we = '1' then
                RAM(to_integer(unsigned(address))) <= data_in(15 downto 8);
                RAM(to_integer(unsigned(address)+1)) <= data_in(7 downto 0);
                data_out <= (RAM(to_integer(unsigned(address))) & RAM(to_integer(unsigned(address)+1))); -- Big Endian
            else
                data_out <= (RAM(to_integer(unsigned(address))) & RAM(to_integer(unsigned(address)+1))); -- Big Endian
            end if;
        end if;
    end process;

end Behavioral;
