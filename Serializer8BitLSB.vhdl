LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Serializer8BitLSB IS PORT ( 
    data : IN STD_LOGIC_VECTOR (7 downto 0);
    load, compute : IN STD_LOGIC;
    clk : IN STD_LOGIC;

    q : OUT STD_LOGIC
);
END ENTITY Serializer8BitLSB;

ARCHITECTURE RTL OF Serializer8BitLSB IS
    SIGNAL sReg8: STD_LOGIC_VECTOR(7 DOWNTO 0) := x"00";
BEGIN
    PROCESS (clk)
    BEGIN
        IF RISING_EDGE(clk) THEN
            IF load = '1' THEN
                sReg8 <= data;
            ELSIF compute = '1' THEN
                sReg8 <= '0' & sReg8(7 DOWNTO 1);
            END IF;
        END IF;
    END PROCESS;
    
    q <= sReg8(0);

END ARCHITECTURE RTL;
