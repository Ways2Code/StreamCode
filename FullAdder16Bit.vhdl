LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY FullAdder16Bit IS PORT (
    operand0, operand1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    carryIn : IN STD_LOGIC;

    sum: OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    carryOut : OUT STD_LOGIC
);
END ENTITY FullAdder16Bit;

ARCHITECTURE RTL OF FullAdder16Bit IS
    SIGNAL sCarries: STD_LOGIC_VECTOR(16 DOWNTO 0);

    COMPONENT FullAdder IS PORT (
        operand0, operand1, carryIn : IN STD_LOGIC;
        sum, carryOut : OUT STD_LOGIC
    );
    END COMPONENT FullAdder;
BEGIN

    sCarries(0) <= carryIn;
    carryOut <= sCarries(16);    

    genFullAdder: FOR ii IN 0 TO 15 GENERATE
        faInstance: FullAdder PORT MAP (operand0(ii), operand1(ii), sCarries(ii), sum(ii), sCarries(ii + 1));
    END GENERATE genFullAdder;

END ARCHITECTURE RTL;
