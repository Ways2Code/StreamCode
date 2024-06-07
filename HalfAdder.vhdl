LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY HalfAdder IS PORT ( 
    operand0, operand1 : IN STD_LOGIC;
    
    sum, carry : OUT STD_LOGIC
);
END ENTITY HalfAdder;

ARCHITECTURE RTL OF HalfAdder IS
BEGIN

    sum <= operand0 XOR operand1;
    carry <= operand0 AND operand1;

END ARCHITECTURE RTL;
