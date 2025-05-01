-- Noridel Herron
-- test bench for InstructionMemory.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_INST_MEM is
end tb_INST_MEM;

architecture test of tb_INST_MEM is

    -- Component under test
    component INST_MEM
        Port ( addr   : in  std_logic_vector(31 downto 0);  -- input: byte address to fetch instruction
               instr  : out std_logic_vector(31 downto 0)); -- output: instruction at the given address
    end component;

    -- internal signal
    signal addr  : std_logic_vector(31 downto 0) := (others => '0');
    signal instr : std_logic_vector(31 downto 0);

    -- Function to convert std_logic_vector to hex string
    function to_hexstring(sig: std_logic_vector) return string is
    variable hex_chars : string(1 to sig'length / 4);
    variable val : std_logic_vector(sig'range) := sig;
    begin
        for i in 0 to hex_chars'length - 1 loop
            case val((sig'length - 1 - (i * 4)) downto (sig'length - 4 - (i * 4))) is
                when "0000" => hex_chars(i+1) := '0';
                when "0001" => hex_chars(i+1) := '1';
                when "0010" => hex_chars(i+1) := '2';
                when "0011" => hex_chars(i+1) := '3';
                when "0100" => hex_chars(i+1) := '4';
                when "0101" => hex_chars(i+1) := '5';
                when "0110" => hex_chars(i+1) := '6';
                when "0111" => hex_chars(i+1) := '7';
                when "1000" => hex_chars(i+1) := '8';
                when "1001" => hex_chars(i+1) := '9';
                when "1010" => hex_chars(i+1) := 'A';
                when "1011" => hex_chars(i+1) := 'B';
                when "1100" => hex_chars(i+1) := 'C';
                when "1101" => hex_chars(i+1) := 'D';
                when "1110" => hex_chars(i+1) := 'E';
                when others => hex_chars(i+1) := 'F';
            end case;
        end loop;
    return hex_chars;   -- return the hex value of the instruction in the memory
    end;
    
    -- Procedure to calculate address and return it as a variable
    procedure check_instruction(addr_out : out std_logic_vector(31 downto 0); addr_int : integer) is
    variable temp_addr : integer;
    begin
        temp_addr := addr_int * 4;
        addr_out := std_logic_vector(to_unsigned(temp_addr, 32));
    end procedure;

begin

    -- Instantiate DUT
    UUT: INST_MEM port map ( addr, instr);

    -- loop through the memory
    process
    variable addr_var : std_logic_vector(31 downto 0);
    begin
        for i in 0 to 43 loop
            check_instruction(addr_var, i);  -- generate address
            addr <= addr_var;                -- assign to signal
            wait for 200 ns;
            report "Instruction at addr " & integer'image(i * 4) & " = " & to_hexstring(instr);
        end loop;
        wait;
    end process;

end test;
