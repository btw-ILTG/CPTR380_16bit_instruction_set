----------------------------------------------------------------------------------
-- Company: Walla Walla University
-- Engineer: Stefan Hess 
-- 
-- Create Date:    20:21:53 03/08/2022 
-- Design Name: 
-- Module Name:    control_logic - Behavioral 
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
-- Control logic
--
--  Inputs:
--      op code:    4 bits [15:12]
--  Outputs:
--      ALUOp:      3 bits of ALU operation
--      Jump:       specifies if jump instruction
--      Branch:     specifies if branch instruction
--      MemtoReg:   allows RAM to be read to register
--      MemWrite:   allows writing to RAM
--      ALUSrc:     selects whether alu reg_2 is from the instruction or register
--      RegWrite:   enables writing back to register
--      LoadLargeImm:   loads a large Immediate
--      Much more to come
--
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;

entity control_logic is
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
end control_logic;

architecture Behavioral of control_logic is

begin
    with op_code select
        ALUOp <= "001"  when "0001", -- Add
                 "010"  when "0010", -- Sub
                 "001"  when "0011", -- Add Immediate (Add)
                 "011"  when "0100", -- Shift Left
                 "101"  when "0101", -- AND
                 "110"  when "0110", -- OR
                 "111"  when "0111", -- XOR
                 "000"  when "1000", -- Load Long
                 "100"  when "1001", -- Shift Right
                 "000"  when "1010", -- Not assigned
                 "000"  when "1011", -- Not assigned
                 "001"  when "1100", -- Load Word (Add)
                 "001"  when "1101", -- Store Word (Add)
                 "010"  when "1110", -- Branch if equal (Sub)
                 "000"  when "1111", -- Jump
                 "000"  when others;

    with op_code select
        ReadRegDest <= '1' when "1101", -- Store Word
                       '1' when "1110", -- Branch if equal
                       '0' when others;

    with op_code select
        Jump <=     '1' when "1111", -- Jump
                    '0' when others;

    with op_code select
        Branch <=   '1' when "1110", -- Branch if equal
                    '0' when others;

    with op_code select
        MemtoReg <= '1' when "1100", -- Load Word
                    '0' when others;

    with op_code select
        MemWrite <= '1' when "1101", -- Store Word
                    '0' when others;

    with op_code select
        ALUSrc <=   '1' when "0011", -- Add Immediate
                    '1' when "0100", -- Shift Left
                    '1' when "1001", -- Shift Right
                    '1' when "1101", -- Store Word
                    '0' when others;

    with op_code select
        RegWrite <= '1' when "0001", -- Add
                    '1' when "0010", -- Sub
                    '1' when "0011", -- Add Immediate (Add)
                    '1' when "0100", -- Shift Left
                    '1' when "0101", -- AND
                    '1' when "0110", -- OR
                    '1' when "0111", -- XOR
                    '1' when "1000", -- Load Long
                    '1' when "1001", -- Shift Right
                    '1' when "1100", -- Load Word
                    '0' when others;

    with op_code select
        LoadLargeImm <= '1' when "1000", -- Load Long
                        '0' when others;

end Behavioral;

