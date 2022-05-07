-- clk_count_max = (Frequency of clk)/(Frequency of UART)
-- Example: 100 MHz Clock, 115200 baud UART
-- (100000000)/(115200) = 870
-- Example: 100 MHz Clock, 9600 baud UART
-- (100000000)/(9600) = 10416.666~10417

library ieee;
use ieee.std_logic_1164.all;

entity UART_transmitter is
      generic (
        clk_count_max : integer := 870 );     -- Needs to be set correctly
      port (
        clk,start : in  std_logic;
        data : in  std_logic_vector(7 downto 0);
        transmit : out std_logic := '1';
        active, done : out std_logic := '0');
end UART_transmitter;

architecture U of UART_transmitter is
    type sequence is (waiting, bits, finish);
    signal seq : sequence := waiting;
    signal clk_count : integer range 0 to clk_count_max-1 := 0;
    signal bit_index : integer range 0 to 9 := 0;
    signal loaded_data   : std_logic_vector(9 downto 0) := "1UUUUUUUU0"; -- "stop bit, 8 data bits, start bit"
begin
    process (clk)
    begin
        if rising_edge(clk) then
            case seq is
                when waiting =>
                    active <= '0';
                    transmit <= '1';
                    done   <= '0';
                    clk_count <= 0;
                    bit_index <= 0;
                    loaded_data <= "1UUUUUUUU0";
                    if start='1' then
                        loaded_data(8 downto 1) <= data;
                        seq <= bits;
                    end if;
                when bits =>
                    active <= '1';
                    transmit <= loaded_data(bit_index);
                    if clk_count >= clk_count_max-1 then
                        if bit_index >= 9 then
                            done   <= '1';
                            clk_count <= 0;
                            seq <= finish;
                        else
                            bit_index <= bit_index + 1;
                            clk_count <= 0;
                        end if;
                    else
                        clk_count <= clk_count + 1;
                    end if;
                when finish =>
                    active <= '0';
                    done   <= '1';
                    seq   <= waiting;
                when others =>
                    seq   <= waiting;
                end case;
        end if;
    end process; 
end U;