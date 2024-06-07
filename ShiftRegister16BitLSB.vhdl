LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY ShiftRegister16BitLSB IS PORT ( 
    data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    load, compute : IN STD_LOGIC;
    clk : IN STD_LOGIC;

    q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
);
END ENTITY ShiftRegister16BitLSB;

ARCHITECTURE RTL OF ShiftRegister16BitLSB IS
    SIGNAL sReg16 : STD_LOGIC_VECTOR (15 DOWNTO 0) := x"0000";
BEGIN

    PROCESS (clk)
    BEGIN
        IF RISING_EDGE(clk) THEN
            IF load = '1' THEN
                sReg16 <= x"00" & data;
            ELSIF compute = '1' THEN
                sReg16 <= sReg16(14 DOWNTO 0) & '0';
            END IF;
        END IF;
    END PROCESS;
    
    q <= sReg16;

END ARCHITECTURE RTL;
