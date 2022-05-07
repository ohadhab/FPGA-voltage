library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
Library UNISIM;
use UNISIM.vcomponents.all;

entity temp_vccint is
    Port ( clk100    : in STD_LOGIC;
           temp      : out STD_LOGIC_VECTOR (11 downto 0);
           voltage   : out STD_LOGIC_VECTOR (11 downto 0);
           voltage1  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage2  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage3  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage4  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage5  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage6  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage7  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage8  : out STD_LOGIC_VECTOR (11 downto 0);
           voltage9  : out STD_LOGIC_VECTOR (11 downto 0);
           vaux4_n  : in STD_LOGIC;
           vaux4_p  : in STD_LOGIC;
           vaux5_n  : in STD_LOGIC;
           vaux5_p  : in STD_LOGIC;
           vaux6_n  : in STD_LOGIC;
           vaux6_p  : in STD_LOGIC;
           vaux7_n  : in STD_LOGIC;
           vaux7_p  : in STD_LOGIC;
           vaux15_n : in STD_LOGIC;
           vaux15_p : in STD_LOGIC;
           vaux0_n  : in STD_LOGIC;
           vaux0_p  : in STD_LOGIC;
           vaux12_p : in STD_LOGIC;
           vaux12_n : in STD_LOGIC;
           vaux13_p : in STD_LOGIC;
           vaux13_n : in STD_LOGIC;
           vaux14_p : in STD_LOGIC;
           vaux14_n : in STD_LOGIC
           );
end temp_vccint;

architecture Behavioral of temp_vccint is
    signal address : std_logic_vector( 6 downto 0);
    signal reading : std_logic_vector(11 downto 0) := (others => '0');
    signal junk : std_logic_vector(3 downto 0) := (others => '0');
    signal muxaddr : std_logic_vector( 4 downto 0);
    signal channel : std_logic_vector( 4 downto 0);
    signal aux_channel_n : std_logic_vector( 15 downto 0) := (others => '0');
    signal aux_channel_p : std_logic_vector( 15 downto 0) := (others => '0');
    signal drdy : std_logic;
    signal den : std_logic;
    signal BUSY   : std_logic;
    signal EOC    : std_logic;
    signal EOS    : std_logic;
begin

aux_channel_p(0) <= vaux0_p;
aux_channel_n(0) <= vaux0_n;
aux_channel_p(4) <= vaux4_p;
aux_channel_n(4) <= vaux4_n;
aux_channel_p(5) <= vaux5_p;
aux_channel_n(5) <= vaux5_n;
aux_channel_p(6) <= vaux6_p;
aux_channel_n(6) <= vaux6_n;
aux_channel_p(7) <= vaux7_p;
aux_channel_n(7) <= vaux7_n;
aux_channel_p(12) <= vaux12_p;
aux_channel_n(12) <= vaux12_n;
aux_channel_p(13) <= vaux13_p;
aux_channel_n(13) <= vaux13_n;
aux_channel_p(14) <= vaux14_p;
aux_channel_n(14) <= vaux14_n;
aux_channel_p(15) <= vaux15_p;
aux_channel_n(15) <= vaux15_n;

process(clk100)
variable i: integer :=0;
variable waiting: boolean := false;
variable rrr: boolean := false;
variable clkwaits : integer :=0;
begin
    if rising_edge(clk100) then
        if clkwaits > 100 then
            waiting := false;
            i:=0;
            rrr:=false;
            clkwaits:=0;
            den <= '0';
        end if;
        if eoc = '1' then
            rrr:=true;
        end if;
        if den = '1' then
            den <= '0';
        end if;
        if i=0 and rrr=true then
            if waiting = false then
                address <= "0000000";--temp
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                temp <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=1;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=1 and rrr=true then
            if waiting = false then
                address <= "0000011";--vp-vn
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=2;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=2 and rrr=true then
            if waiting = false then
                address <= "0010100";--A0
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage1 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=3;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=3 and rrr=true then
            if waiting = false then
                address <= "0010101";--A1
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage2 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=4;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=4 and rrr=true then
            if waiting = false then
                address <= "0010110";--A2
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage3 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=5;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=5 and rrr=true then
            if waiting = false then
                address <= "0010111";--A3
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage4 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=6;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=6 and rrr=true then
            if waiting = false then
                address <= "0011111";--A4
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage5 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=7;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=7 and rrr=true then
            if waiting = false then
                address <= "0010000";--A5
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage6 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=8;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=8 and rrr=true then
            if waiting = false then
                address <= "0011100";--A6-A7
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage7 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=9;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=9 and rrr=true then
            if waiting = false then
                address <= "0011101";--A8-A9
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage8 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=10;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        elsif i=10 and rrr=true then
            if waiting = false then
                address <= "0011110";--A10-A11
                den <= '1';
                waiting := true;
            elsif drdy = '1' then
                voltage9 <= std_logic_vector(unsigned(reading));
                waiting := false;
                i:=0;
                clkwaits:=0;
            else
                clkwaits:=clkwaits+1;
            end if;
        else
            rrr:=false;
            clkwaits:=0;
            i:=0;
            waiting := false;
            den <= '0';
        end if;
    end if;
end process;

XADC_inst : XADC generic map (
--      -- INIT_40 - INIT_42: XADC configuration registers
        INIT_40 => X"3000", -- config reg 0
        INIT_41 => X"21FF", -- config reg 1
        INIT_42 => X"0400", -- config reg 2
--      -- INIT_48 - INIT_4F: Sequence Registers
        INIT_48 => X"7F01", -- Sequencer channel selection
        INIT_49 => X"F0F1", -- Sequencer channel selection
        INIT_4A => X"0000", -- Sequencer Average selection
        INIT_4B => X"0000", -- Sequencer Average selection
        INIT_4C => X"0000", -- Sequencer Bipolar selection
        INIT_4D => X"0000", -- Sequencer Bipolar selection
        INIT_4E => X"0000", -- Sequencer Acq time selection
        INIT_4F => X"0000", -- Sequencer Acq time selection
--      -- INIT_50 - INIT_58, INIT5C: Alarm Limit Registers
        INIT_50 => X"B5ED", -- Temp alarm trigger
        INIT_51 => X"57E4", -- Vccint upper alarm limit
        INIT_52 => X"A147", -- Vccaux upper alarm limit
        INIT_53 => X"CA33",  -- Temp alarm OT upper
        INIT_54 => X"A93A", -- Temp alarm reset
        INIT_55 => X"52C6", -- Vccint lower alarm limit
        INIT_56 => X"9555", -- Vccaux lower alarm limit
        INIT_57 => X"AE4E",  -- Temp alarm OT reset
        INIT_58 => X"5999",  -- Vccbram upper alarm limit
        INIT_5C => X"5111",  -- Vccbram lower alarm limit
--      -- Simulation attributes: Set for proper simulation behavior
      SIM_DEVICE       => "7SERIES",    -- Select target device (values)
      SIM_MONITOR_FILE => "D:\VHDL\electrical-project\beauty\beau\design.txt"  -- Analog simulation data file name
   ) port map (
      -- ALARMS: 8-bit (each) output: ALM, OT
      ALM          => open,             -- 8-bit output: Output alarm for temp, Vccint, Vccaux and Vccbram
      OT           => open,             -- 1-bit output: Over-Temperature alarm
      -- STATUS: 1-bit (each) output: XADC status ports
      BUSY         => BUSY,             -- 1-bit output: ADC busy output
      CHANNEL      => channel,          -- 5-bit output: Channel selection outputs
      EOC          => EOC,             -- 1-bit output: End of Conversion
      EOS          => EOS,             -- 1-bit output: End of Sequence
      JTAGBUSY     => open,             -- 1-bit output: JTAG DRP transaction in progress output
      JTAGLOCKED   => open,             -- 1-bit output: JTAG requested DRP port lock
      JTAGMODIFIED => open,             -- 1-bit output: JTAG Write to the DRP has occurred
      MUXADDR      => muxaddr,          -- 5-bit output: External MUX channel decode
      -- Auxiliary Analog-Input Pairs: 16-bit (each) input: VAUXP[15:0], VAUXN[15:0]
      VAUXN        => aux_channel_n,            -- 16-bit input: N-side auxiliary analog input
      VAUXP        => aux_channel_p,            -- 16-bit input: P-side auxiliary analog input
      -- CONTROL and CLOCK: 1-bit (each) input: Reset, conversion start and clock inputs
      CONVST       => '0',              -- 1-bit input: Convert start input
      CONVSTCLK    => '0',              -- 1-bit input: Convert start input
      RESET        => '0',              -- 1-bit input: Active-high reset
      -- Dedicated Analog Input Pair: 1-bit (each) input: VP/VN
      VN           => '0', -- 1-bit input: N-side analog input
      VP           => '0', -- 1-bit input: P-side analog input
      -- Dynamic Reconfiguration Port (DRP) -- hard set to read channel 6 (XADC4/XADC0)
      DO(15 downto 4) => reading,
      DO(3 downto 0)  => junk,
      DRDY            => drdy,
      DADDR           => address,  -- The address for reading
      DCLK            => clk100,
      DEN             => den,
      DI              => (others => '0'),
      DWE             => '0'
   );
end Behavioral;
