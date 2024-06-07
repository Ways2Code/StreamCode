LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FullAdder IS PORT (
    operand0, operand1, carryIn : IN STD_LOGIC;

    sum, carryOut : OUT STD_LOGIC
);
END ENTITY FullAdder;

ARCHITECTURE RTL OF FullAdder IS
    SIGNAL sSum0, sCarry0, sCarry1 : STD_LOGIC;

    COMPONENT HalfAdder IS PORT (
        operand0, operand1 : IN STD_LOGIC;
        sum, carry : OUT STD_LOGIC
    );
    END COMPONENT HalfAdder;
BEGIN

    halfAdder0 : HalfAdder PORT MAP (operand0, operand1, sSum0, sCarry0);
    halfAdder1 : HalfAdder PORT MAP (sSum0, carryIn, sum, sCarry1);
    carryOut <= sCarry0 OR sCarry1;
    
END ARCHITECTURE RTL;
