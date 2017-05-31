#!/bin/sh
# bits for instruction types
NOP="5'b0_0000"
HALT="5'b0_0001"
LOAD="5'b0_0010"
STORE="5'b0_0011"
SLL="5'b0_0100"
LFSR="5'b0_0101"
SRL="5'b0_0110"
#SRA="5'b0_0111"
ADD="5'b0_1000"
ADDI="5'b0_1001"
SUB="5'b0_1010"
SUBI="5'b0_1011"
CMP="5'b0_1100"
AND="5'b0_1101"
OR="5'b0_1110"
XOR="5'b0_1111"
LDIH="5'b1_0000"
#ADDC="5'b1_0001"
#SUBC="5'b1_0010"
SUIH="5'b1_0011"
LIOA="5'b1_0100"
LIOB="5'b1_0101"
LIOS="5'b1_0110"
SET="5'b1_0111"
JUMP="5'b1_1000"
JMPR="5'b1_1001"
BZ="5'b1_1010"
BNZ="5'b1_1011"
BN="5'b1_1100"
BNN="5'b1_1101"
BC="5'b1_1110"
BNC="5'b1_1111"

# bits for general memory
gr0="3'b000"
gr1="3'b001"
gr2="3'b010"
gr3="3'b011"
gr4="3'b100"
gr5="3'b101"
gr6="3'b110"
gr7="3'b111"

# MACROs for instruction types (for loop)
MACRO_1="$NOP"
MACRO_2="$HALT"
MACRO_3="$LOAD"
MACRO_4="$STORE"
MACRO_5="$SLL"
MACRO_6="$LFSR"
MACRO_7="$SRL"
MACRO_8="$SRA"
MACRO_9="$ADD"
MACRO_10="$ADDI"
MACRO_11="$SUB"
MACRO_12="$SUBI"
MACRO_13="$CMP"
MACRO_14="$AND"
MACRO_15="$OR"
MACRO_16="$XOR"
MACRO_17="$LDIH"
MACRO_18="$ADDC"
MACRO_19="$SUBC"
MACRO_20="$SUIH"
MACRO_21="$LIOA"
MACRO_22="$LIOB"
MACRO_23="$LIOS"
MACRO_24="$SET"
MACRO_25="$JUMP"
MACRO_26="$JMPR"
MACRO_27="$BZ"
MACRO_28="$BNZ"
MACRO_29="$BN"
MACRO_30="$BNN"
MACRO_31="$BC"
MACRO_32="$BNC"

# global declaration
export MACRO_1
export MACRO_2
export MACRO_3
export MACRO_4
export MACRO_5
export MACRO_6
export MACRO_7
export MACRO_8
export MACRO_9
export MACRO_10
export MACRO_11
export MACRO_12
export MACRO_13
export MACRO_14
export MACRO_15
export MACRO_16
export MACRO_17
export MACRO_18
export MACRO_19
export MACRO_20
export MACRO_21
export MACRO_22
export MACRO_23
export MACRO_24
export MACRO_25
export MACRO_26
export MACRO_27
export MACRO_28
export MACRO_29
export MACRO_30
export MACRO_31
export MACRO_32

# name for instructions
INSTR_1="NOP"
INSTR_2="HALT"
INSTR_3="LOAD"
INSTR_4="STORE"
INSTR_5="SLL"
INSTR_6="LFSR"
INSTR_7="SRL"
INSTR_8="SRA"
INSTR_9="ADD"
INSTR_10="ADDI"
INSTR_11="SUB"
INSTR_12="SUBI"
INSTR_13="CMP"
INSTR_14="AND"
INSTR_15="OR"
INSTR_16="XOR"
INSTR_17="LDIH"
INSTR_18="ADDC"
INSTR_19="SUBC"
INSTR_20="SUIH"
INSTR_21="LIOA"
INSTR_22="LIOB"
INSTR_23="LIOS"
INSTR_24="SET"
INSTR_25="JUMP"
INSTR_26="JMPR"
INSTR_27="BZ"
INSTR_28="BNZ"
INSTR_29="BN"
INSTR_30="BNN"
INSTR_31="BC"
INSTR_32="BNC"

# global declaration
export INSTR_1
export INSTR_2
export INSTR_3
export INSTR_4
export INSTR_5
export INSTR_6
export INSTR_7
export INSTR_8
export INSTR_9
export INSTR_10
export INSTR_11
export INSTR_12
export INSTR_13
export INSTR_14
export INSTR_15
export INSTR_16
export INSTR_17
export INSTR_18
export INSTR_19
export INSTR_20
export INSTR_21
export INSTR_22
export INSTR_23
export INSTR_24
export INSTR_25
export INSTR_26
export INSTR_27
export INSTR_28
export INSTR_29
export INSTR_30
export INSTR_31
export INSTR_32

# global declaration
export gr0
export gr1
export gr2
export gr3
export gr4
export gr5
export gr6
export gr7

# invoke the extraction process sh
#echo $SUBI
./extra_inst.sh

