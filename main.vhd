library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity main is
  Port (CLK100MHZ:in std_logic;
        uart_out:out std_logic;
        vaux4_n : in STD_LOGIC:='0';
        vaux4_p : in STD_LOGIC;
        vaux5_n : in STD_LOGIC:='0';
        vaux5_p : in STD_LOGIC;
        vaux6_n : in STD_LOGIC:='0';
        vaux6_p : in STD_LOGIC;
        vaux7_n : in STD_LOGIC:='0';
        vaux7_p : in STD_LOGIC;
        vaux15_n: in STD_LOGIC:='0';
        vaux15_p: in STD_LOGIC;
        vaux0_n : in STD_LOGIC:='0';
        vaux0_p : in STD_LOGIC;
        vaux12_p: in STD_LOGIC;
        vaux12_n: in STD_LOGIC:='0';
        vaux13_p: in STD_LOGIC;
        vaux13_n: in STD_LOGIC:='0';
        vaux14_p: in STD_LOGIC;
        vaux14_n: in STD_LOGIC:='0'
        );
end main;

architecture Behavioral of main is

component UART_transmitter is
  generic (
    clk_count_max : integer := 870 );     -- Needs to be set correctly
    -- Example: 100 MHz Clock, 115200 baud UART
    -- (100000000)/(115200) = 870
      port (
        clk,start : in std_logic;
        data : in std_logic_vector (7 downto 0);
        transmit : out std_logic := '1';
        active, done : out std_logic := '0');
end component;

component temp_vccint is
    Port ( clk100    : in STD_LOGIC;
            temp      : out STD_LOGIC_VECTOR (11 downto 0);
            voltage   : out STD_LOGIC_VECTOR (11 downto 0);
            voltage1   : out STD_LOGIC_VECTOR (11 downto 0);
            voltage2  : out STD_LOGIC_VECTOR (11 downto 0);
            voltage3  : out STD_LOGIC_VECTOR (11 downto 0);
            voltage4  : out STD_LOGIC_VECTOR (11 downto 0);
            voltage5  : out STD_LOGIC_VECTOR (11 downto 0);
            voltage6  : out STD_LOGIC_VECTOR (11 downto 0);
            voltage7  : out STD_LOGIC_VECTOR (11 downto 0);
            voltage8  : out STD_LOGIC_VECTOR (11 downto 0);
            voltage9  : out STD_LOGIC_VECTOR (11 downto 0);
            vaux4_n : in STD_LOGIC;
            vaux4_p : in STD_LOGIC;
            vaux5_n : in STD_LOGIC;
            vaux5_p : in STD_LOGIC;
            vaux6_n : in STD_LOGIC;
            vaux6_p : in STD_LOGIC;
            vaux7_n : in STD_LOGIC;
            vaux7_p : in STD_LOGIC;
            vaux15_n: in STD_LOGIC;
            vaux15_p: in STD_LOGIC;
            vaux0_n : in STD_LOGIC;
            vaux0_p : in STD_LOGIC;
            vaux12_p: in STD_LOGIC;
            vaux12_n: in STD_LOGIC;
            vaux13_p: in STD_LOGIC;
            vaux13_n: in STD_LOGIC;
            vaux14_p: in STD_LOGIC;
            vaux14_n: in STD_LOGIC
            );
end component;

constant time_b : integer := 1;     -- Needs to be set correctly -- seconds between data transmitions

constant clock_b: integer := time_b*100000000;
constant numofger : integer := 11;
signal start :std_logic:='0';
signal data :std_logic_vector(7 downto 0) := "00000000";
signal active,transmit,done :std_logic;
type printseq is (waiting, first, second, third, forth, space, linefeed, carriagereturn);
signal readytoprint: printseq:= waiting;
signal actual_data1 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data2 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data3 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data4 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data5 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data6 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data7 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data8 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data9 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data10 :std_logic_vector (15 downto 0) := "0000000000000000";
signal actual_data11 :std_logic_vector (15 downto 0) := "0000000000000000";
signal temp :std_logic_vector (11 downto 0) := (others => '0');
signal voltage : std_logic_vector (11 downto 0) := (others => '0');
signal voltage1 : std_logic_vector (11 downto 0) := (others => '0');
signal voltage2 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal voltage3 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal voltage4 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal voltage5 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal voltage6 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal voltage7 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal voltage8 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal voltage9 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
begin
RS232:component UART_Transmitter 
port map(
     clk => CLK100MHZ,
     start => start,
     data => data,
     active => active,
     transmit => uart_out,
     done => done
);

adc:component temp_vccint
port map(
    clk100 => clk100MHZ,
    temp => temp,
    voltage => voltage,
    voltage1 => voltage1,
    voltage2 => voltage2,
    voltage3 => voltage3,
    voltage4 => voltage4,
    voltage5 => voltage5,
    voltage6 => voltage6,
    voltage7 => voltage7,
    voltage8 => voltage8,
    voltage9 => voltage9,
    vaux4_n  => vaux4_n, 
    vaux4_p  => vaux4_p, 
    vaux5_n  => vaux5_n, 
    vaux5_p  => vaux5_p, 
    vaux6_n  => vaux6_n, 
    vaux6_p  => vaux6_p, 
    vaux7_n  => vaux7_n, 
    vaux7_p  => vaux7_p, 
    vaux15_n => vaux15_n,
    vaux15_p => vaux15_p,
    vaux0_n  => vaux0_n, 
    vaux0_p  => vaux0_p, 
    vaux12_p => vaux12_p,
    vaux12_n => vaux12_n,
    vaux13_p => vaux13_p,
    vaux13_n => vaux13_n,
    vaux14_p => vaux14_p,
    vaux14_n => vaux14_n 
);

process(CLK100MHZ)
variable clockcount: integer := 0;
variable seccount: integer := 0;
variable printing: integer range 0 to 1 := 0;
variable to_transmit: unsigned (16*numofger-1 downto 0) := (others => '0');
variable reg: integer := 0;
begin
    if rising_edge(CLK100MHZ) then
        actual_data1(11 downto 0) <= temp;
        actual_data2(11 downto 0) <= voltage;
        actual_data3(11 downto 0) <= voltage1;
        actual_data4(11 downto 0) <= voltage2;
        actual_data5(11 downto 0) <= voltage3; 
        actual_data6(11 downto 0) <= voltage4;
        actual_data7(11 downto 0) <= voltage5;
        actual_data8(11 downto 0) <= voltage6; 
        actual_data9(11 downto 0) <= voltage7;
        actual_data10(11 downto 0)<= voltage8;
        actual_data11(11 downto 0)<= voltage9;
        clockcount:=clockcount+1;
        if clockcount >= 100000000 then
            seccount:=seccount+1;
            clockcount:=0;
        elsif seccount >= time_b then
            seccount := 0;
            to_transmit := unsigned(actual_data1 & actual_data2 & actual_data3 & actual_data4 & actual_data5 & actual_data6 & actual_data7 & actual_data8 & actual_data9 & actual_data10 & actual_data11); 
            readytoprint <= first;
        elsif readytoprint = first and printing = 0 then
            if to_transmit(16*(numofger-reg)-1 downto 16*(numofger-reg)-4) < 10 then
                data(7 downto 4) <= "0011";
                data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-1 downto 16*(numofger-reg)-4));
            else
                data(7 downto 4) <= "0100";
                data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-1 downto 16*(numofger-reg)-4) - 9);
            end if;
            start<='1';
            printing:=1;
            readytoprint <= second;
        elsif (printing = 1 and done = '1' and active = '0') then
            start<='1';
            case readytoprint is
                when first =>
                    if to_transmit(16*(numofger-reg)-1 downto 16*(numofger-reg)-4) < 10 then
                        data(7 downto 4) <= "0011";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-1 downto 16*(numofger-reg)-4));
                    else
                        data(7 downto 4) <= "0100";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-1 downto 16*(numofger-reg)-4) - 9);
                    end if;
                    readytoprint <= second;
                when second =>
                    if to_transmit(16*(numofger-reg) - 5 downto 16*(numofger-reg) - 8) < 10 then
                        data(7 downto 4) <= "0011";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg) - 5 downto 16*(numofger-reg)-8));
                    else
                        data(7 downto 4) <= "0100";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg) - 5 downto 16*(numofger-reg)-8) - 9);
                    end if;
                    readytoprint <= third;
                when third =>
                    if to_transmit(16*(numofger-reg)-9 downto 16*(numofger-reg)-12) < 10 then
                        data(7 downto 4) <= "0011";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-9 downto 16*(numofger-reg)-12));
                    else
                        data(7 downto 4) <= "0100";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-9 downto 16*(numofger-reg)-12) - 9);
                    end if;
                    readytoprint <= forth;
                when forth =>
                    if to_transmit(16*(numofger-reg)-13 downto 16*(numofger-reg)-16) < 10 then
                        data(7 downto 4) <= "0011";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-13 downto 16*(numofger-reg)-16));
                    else
                        data(7 downto 4) <= "0100";
                        data(3 downto 0) <= std_logic_vector(to_transmit(16*(numofger-reg)-13 downto 16*(numofger-reg)-16) - 9);
                    end if;
                    if reg < numofger-1 then
                        readytoprint <= space;
                    else
                        readytoprint <= linefeed;
                    end if;
                when space =>
                    data <= x"20";
                    readytoprint <= first;
                    reg := reg + 1;
                when linefeed =>
                    data <= x"0A";
                    readytoprint <= carriagereturn;
                when carriagereturn =>
                    data <= x"0D";
                        readytoprint <= waiting;
                        printing := 0;
                        reg := 0;
                when others =>
                    printing := 0;
                    reg := 0;
                    readytoprint <= waiting;
            end case;
        else
            start <= '0';
        end if;
    end if;
end process;
end Behavioral;
