LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY TBMultiplierController IS
END ENTITY TBMultiplierController;

ARCHITECTURE Behavioral OF TBMultiplierController IS

    COMPONENT MultiplierController IS PORT ( 
        operand0, operand1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        multiply : IN STD_LOGIC;
        clk : IN STD_LOGIC;

        product : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        done : OUT STD_LOGIC
    );
    END COMPONENT MultiplierController;
    
    SIGNAL s_operand0 : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_operand1 : STD_LOGIC_VECTOR (7 DOWNTO 0) := (OTHERS => '0');
    SIGNAL s_multiply : STD_LOGIC := '0';
    SIGNAL s_clk : STD_LOGIC := '0';
    SIGNAL s_product : STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL s_done : STD_LOGIC;
    
    CONSTANT PERIOD: TIME := 10 NS;

BEGIN

    -- uut
    UUT: MultiplierController PORT MAP (s_operand0, s_operand1, s_multiply, s_clk, s_product, s_done);
    
    -- process to simulate the clk
    PROCESS
    BEGIN
        WAIT FOR PERIOD / 2;
        s_clk <= NOT s_clk;
    END PROCESS;
    
    -- process to do calculation
    PROCESS
    BEGIN
        WAIT FOR PERIOD / 2;
        s_operand0 <= x"0B";
        s_operand1 <= x"07";
        s_multiply <= '1';
        WAIT FOR PERIOD;
        s_multiply <= '0';
        WAIT FOR PERIOD * 10;

        s_operand0 <= x"5A";
        s_operand1 <= x"A5";
        s_multiply <= '1';
        WAIT FOR PERIOD;
        s_multiply <= '0';
        WAIT FOR PERIOD * 10;

        s_operand0 <= x"10";
        s_operand1 <= x"10";
        s_multiply <= '1';
        WAIT FOR PERIOD;
        s_multiply <= '0';
        WAIT FOR PERIOD * 10;

        s_operand0 <= x"FF";
        s_operand1 <= x"FF";
        s_multiply <= '1';
        WAIT FOR PERIOD;
        s_multiply <= '0';
        WAIT FOR PERIOD * 10;

        s_operand0 <= x"01";
        s_operand1 <= x"F1";
        s_multiply <= '1';
        WAIT FOR PERIOD;
        s_multiply <= '0';
        WAIT FOR PERIOD * 10;

        s_operand0 <= x"00";
        s_operand1 <= x"F1";
        s_multiply <= '1';
        WAIT FOR PERIOD;
        s_multiply <= '0';
        WAIT FOR PERIOD * 9;

        WAIT FOR PERIOD / 2;
        
    END PROCESS;

END ARCHITECTURE Behavioral;
