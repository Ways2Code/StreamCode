LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Register16Bit IS PORT ( 
    d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
    rst : IN STD_LOGIC;
    clk : IN STD_LOGIC;

    q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
);
END ENTITY Register16Bit;

ARCHITECTURE RTL OF Register16Bit IS
    SIGNAL reg16 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
BEGIN

    PROCESS(clk)
    BEGIN
        IF RISING_EDGE(clk) THEN
            IF rst = '1' THEN
                reg16 <= (OTHERS => '0');
            ELSE
                reg16 <= d;
            END IF;
        END IF;
    END PROCESS;
    
    q <= reg16;

END ARCHITECTURE RTL;