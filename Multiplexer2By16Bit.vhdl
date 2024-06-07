LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Multiplixer2By16Bit IS PORT ( 
    in0, in1 : in STD_LOGIC_VECTOR (15 DOWNTO 0);
    
    sel : in STD_LOGIC;
    q : out STD_LOGIC_VECTOR (15 DOWNTO 0)
);
END ENTITY Multiplixer2By16Bit;

ARCHITECTURE RTL OF multiplixer2By16Bit IS

BEGIN

    PROCESS(in0, in1, sel)
    BEGIN
        IF sel = '0' THEN
            q <= in0;
        ELSE
            q <= in1;
        END IF;
    END PROCESS;

END ARCHITECTURE RTL;