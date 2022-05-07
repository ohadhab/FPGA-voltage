library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main_tb is
end main_tb;

architecture Behavioral of main_tb is
component main is
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
        vaux14_n: in STD_LOGIC:='0');
end component;

signal CLK100MHZ : std_logic:='1';
signal uart_out : std_logic;
signal  vaux4_n : STD_LOGIC:='0';
signal  vaux4_p : STD_LOGIC;
signal  vaux5_n : STD_LOGIC:='0';
signal  vaux5_p : STD_LOGIC;
signal  vaux6_n : STD_LOGIC:='0';
signal  vaux6_p : STD_LOGIC;
signal  vaux7_n : STD_LOGIC:='0';
signal  vaux7_p : STD_LOGIC;
signal  vaux15_n: STD_LOGIC:='0';
signal  vaux15_p: STD_LOGIC;
signal  vaux0_n : STD_LOGIC:='0';
signal  vaux0_p : STD_LOGIC;
signal  vaux12_p: STD_LOGIC;
signal  vaux12_n: STD_LOGIC:='0';
signal  vaux13_p: STD_LOGIC;
signal  vaux13_n: STD_LOGIC:='0';
signal  vaux14_p: STD_LOGIC;
signal  vaux14_n: STD_LOGIC:='0';

begin
u1:main port map(CLK100MHZ=>CLK100MHZ,uart_out=>uart_out,
        vaux4_n =>vaux4_n ,
        vaux4_p =>vaux4_p ,
        vaux5_n =>vaux5_n ,
        vaux5_p =>vaux5_p ,
        vaux6_n =>vaux6_n ,
        vaux6_p =>vaux6_p ,
        vaux7_n =>vaux7_n ,
        vaux7_p =>vaux7_p ,
        vaux15_n=>vaux15_n,
        vaux15_p=>vaux15_p,
        vaux0_n =>vaux0_n ,
        vaux0_p =>vaux0_p ,
        vaux12_p=>vaux12_p,
        vaux12_n=>vaux12_n,
        vaux13_p=>vaux13_p,
        vaux13_n=>vaux13_n,
        vaux14_p=>vaux14_p,
        vaux14_n=>vaux14_n);

CLK100MHZ<=not CLK100MHZ after 5 ns;
process
begin
wait;
end process;
end Behavioral;