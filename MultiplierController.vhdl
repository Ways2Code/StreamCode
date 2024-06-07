LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY MultiplierController IS PORT ( 
    operand0, operand1 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    multiply : IN STD_LOGIC;
    clk : IN STD_LOGIC;

    product : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
    done : OUT STD_LOGIC
);
END ENTITY MultiplierController;

ARCHITECTURE RTL OF MultiplierController IS

    COMPONENT FullAdder16Bit IS PORT ( 
        operand0, operand1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        carryIn : IN STD_LOGIC;

        sum: out STD_LOGIC_VECTOR(15 DOWNTO 0);
        carryOut: out STD_LOGIC
    );
    END COMPONENT FullAdder16Bit;

    COMPONENT Serializer8BitLSB IS PORT ( 
        data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        load, compute : IN STD_LOGIC;
        clk : IN STD_LOGIC;

        q : OUT STD_LOGIC
    );
    END COMPONENT Serializer8BitLSB;
    
    COMPONENT shiftRegister16BitLSB IS PORT ( 
        data : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        load, compute : IN STD_LOGIC;
        clk : IN STD_LOGIC;

        q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
    END COMPONENT shiftRegister16BitLSB;
    
    COMPONENT multiplixer2By16Bit IS PORT ( 
        in0, in1 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        sel : IN STD_LOGIC;

        q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
    END COMPONENT  multiplixer2By16Bit;
    
    COMPONENT Register16Bit IS PORT ( 
        d : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        rst : IN STD_LOGIC;
        clk : IN STD_LOGIC;

        q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
    );
    END COMPONENT Register16Bit;  

    SIGNAL sLoad, sCompute : STD_LOGIC;
    CONSTANT sZeroes : STD_LOGIC_VECTOR(15 DOWNTO 0) := x"0000";
    CONSTANT sZero: STD_LOGIC := '0';
    SIGNAL sA : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL sB: STD_LOGIC;
    SIGNAL sRst: STD_LOGIC := '1';
   
    SIGNAL sShifted, sShiftedBuf: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL sSum: STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL sSelMux1: STD_LOGIC;
    SIGNAL sFullAdderA, sFullAdderBuf: STD_LOGIC_VECTOR(15 DOWNTO 0);
    
    TYPE MultiplierState IS (WAITING, LOADING, STEP1, STEP2, STEP3, STEP4, STEP5, STEP6, STEP7, STEP8, FINALSTEP);
    SIGNAL state: MultiplierState := WAITING;
BEGIN
    shiftRegister: shiftRegister16BitLSB PORT MAP (operand0, sLoad, sCompute, clk, sA);
    serializer: serializer8BitLSB PORT MAP (operand1, sLoad, sCompute, clk, sB);
    mux0: multiplixer2By16Bit PORT MAP (sZeroes, sA, sB, sShifted);
    mux1: multiplixer2By16Bit PORT MAP (sZeroes, sSum, sSelMux1, sFullAdderA);
    fa: FullAdder16Bit PORT MAP (sFullAdderBuf, sShiftedBuf, sZero, sSum, OPEN);
    fullAdderBuf: Register16Bit PORT MAP(sFullAdderA, sRst, clk, sFullAdderBuf);
    shiftedBuf: Register16Bit PORT MAP(sShifted, sRst, clk, sShiftedBuf);

    PROCESS (clk)
    BEGIN
        IF RISING_EDGE(clk) THEN
            CASE state IS
                WHEN WAITING =>
                    sRst <= '1';
                    sCompute <= '0';
                    sSelMux1 <= '0';
                    done <= '0';
                    IF multiply = '1' THEN
                        state <= LOADING;
                        sLoad <= '1';
                    ELSE
                        sLoad <= '0';
                    END IF;
                WHEN LOADING =>
                    sLoad <= '0';
                    state <= STEP1;
                WHEN STEP1 =>
                    sCompute <= '1';
                    sRst <= '0';
                    state <= STEP2;
                WHEN STEP2 =>  
                    sSelMux1 <= '1';
                    state <= STEP3;
                WHEN STEP3 =>  
                    state <= STEP4;
                WHEN STEP4 =>  
                    state <= STEP5;
                WHEN STEP5 =>  
                    state <= STEP6;
                WHEN STEP6 =>  
                    state <= STEP7;
                WHEN STEP7 => 
                    state <= STEP8;
                WHEN STEP8 => 
                    state <= FINALSTEP;
                WHEN FINALSTEP =>  
                    done <= '1';
                    state <= WAITING;
            END CASE;
        END IF;
    END PROCESS;

    product <= sSum;

END ARCHITECTURE RTL;
