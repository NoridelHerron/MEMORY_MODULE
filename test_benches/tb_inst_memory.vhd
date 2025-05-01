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

    -- Expected values (replace with your expected instruction values)
    type instr_array is array (0 to 43) of std_logic_vector(31 downto 0);
    constant expected_instr : instr_array := (
        0  => x"01498933",
        1  => x"407312B3",
        2  => x"0149F933",
        3  => x"0149E933",
        4  => x"0009A903",
        5  => x"01392023",
        6  => x"403151B3",
        7  => x"0030F113",
        8  => x"00816193",
        9  => x"00219213",
        10 => x"002081B3",
        11 => x"402081B3",
        12 => x"0020C1B3",
        13 => x"002091B3",
        14 => x"00502023",
        15 => x"00002483",
        16 => x"003100B3",
        17 => x"4062A233",
        18 => x"009412B3",
        19 => x"00C5A3B3",
        20 => x"00F6B4B3",
        21 => x"0128C533",
        22 => x"015A55B3",
        23 => x"018BC5B3",
        24 => x"01BCE6B3",
        25 => x"01EEDF33",
        26 => x"00500093",
        27 => x"0030A113",
        28 => x"0041B193",
        29 => x"0071C213",
        30 => x"00822293",
        31 => x"00F2B313",
        32 => x"00132313",
        33 => x"00135413",
        34 => x"40146493",
        35 => x"00002503",
        36 => x"00B02223",
        37 => x"41498933",
        38 => x"416AAAB3",
        39 => x"00500093",
        40 => x"4013C3B3",
        41 => x"40331293",
        42 => x"01498933",
        43 => x"4055A513"
    );

    -- Function to convert std_logic_vector to hex string
    function to_hexstring(sig: std_logic_vector) return string is
        variable hex_chars : string(1 to sig'length / 4);
        variable val : std_logic_vector(sig'range) := sig;
    begin
        for i in 0 to hex_chars'length - 1 loop
            case val((sig'length - 1 - (i * 4)) downto (sig'length - 4 - (i * 4))) is
                when "0000" => hex_chars(i+1) := '0'; when "0001" => hex_chars(i+1) := '1';
                when "0010" => hex_chars(i+1) := '2'; when "0011" => hex_chars(i+1) := '3';
                when "0100" => hex_chars(i+1) := '4'; when "0101" => hex_chars(i+1) := '5';
                when "0110" => hex_chars(i+1) := '6'; when "0111" => hex_chars(i+1) := '7';
                when "1000" => hex_chars(i+1) := '8'; when "1001" => hex_chars(i+1) := '9';
                when "1010" => hex_chars(i+1) := 'A'; when "1011" => hex_chars(i+1) := 'B';
                when "1100" => hex_chars(i+1) := 'C'; when "1101" => hex_chars(i+1) := 'D';
                when "1110" => hex_chars(i+1) := 'E'; when others   => hex_chars(i+1) := 'F';
            end case;
        end loop;
        return hex_chars;
    end;

    procedure check_instruction(addr_out : out std_logic_vector(31 downto 0); addr_int : integer) is
        variable temp_addr : integer;
    begin
        temp_addr := addr_int * 4;
        addr_out := std_logic_vector(to_unsigned(temp_addr, 32));
    end procedure;

begin

    UUT: INST_MEM port map ( addr, instr);

    process
        variable addr_var : std_logic_vector(31 downto 0);
        variable pass_count, fail_count : integer := 0;
    begin
        for i in 0 to 43 loop
            check_instruction(addr_var, i);
            addr <= addr_var;
            wait for 100 ns;
            if instr = expected_instr(i) then
                pass_count := pass_count + 1;
            else
                fail_count := fail_count + 1;
            end if;
        end loop;

        report "Instruction memory test completed.";
        report "Total Passed: " & integer'image(pass_count);
        report "Total Failed: " & integer'image(fail_count);
        wait;
    end process;

end test;
