#!/bin/sh
#./macro_def.sh
#echo $SUBI
echo $MACRO_1

#vfile_name="SYS_PC_PSEUDO_SPI_INTF_SCAN_TEST.v"
#vfile_name="SYS_PC_MEM_LOOP_8BIT_TEST.v"
#vfile_name="SYS_PC_WRT_SRAM_SUM10_VG_TEST.v"
#vfile_name="I_MEMORY_CF_TASK_8BIT.v"
#vfile_name="SYS_PC_PAUSE_CPU_RESUME_VG_TEST.v"
vfile_name="I_MEMORY_CF_OSCD_TASK_8BIT.v"
tcase_name="testcase_6.txt"
finst_name="testcase_6.bin"
echo $vfile_name
echo $finst_name

# (1) extract commonds from verilog tb;
cat $vfile_name | grep 'tmpi_datain = {' > $tcase_name

# (2) extract MACROs and bits between '{' and '}' from commonds
cat $tcase_name | awk -F "[{}]" '{ for (i=2; i<NF; i+=2) print $i }' > $finst_name
#sed -i "s|gr1|${gr1}|g" $finst_name
#exit

# (3) replace MACROs with bits
for ((i=1;i<=32;i++)); do
    TMPA="INSTR_${i}"
    MAC_NAME=${!TMPA}
    TMPB="MACRO_${i}"
    MAC_BITS=${!TMPB}
    #echo $MAC_NAME $MAC_BITS
    #sed -i "s|${MAC_NAME},|${MAC_BITS},|g" $finst_name
    sed -i "s|\<${MAC_NAME}\>|${MAC_BITS}|g" $finst_name
done

for ((j=0;j<=7;j++)); do
    TMPC="gr${j}"
    REG_BITS=${!TMPC}
    #echo $TMPC $REG_BITS
    sed -i "s|$TMPC|${REG_BITS}|g" $finst_name 
done

# (4) remove the '_','`','3'b', and ','
sed -i "s/_//g" $finst_name
#sed -i "s/,//g" $finst_name
sed -i "s/\`//g" $finst_name
sed -i "s/[0-9]\+'b//g" $finst_name
sed -i "s/ //g" $finst_name
sed -i "s/,//g" $finst_name
