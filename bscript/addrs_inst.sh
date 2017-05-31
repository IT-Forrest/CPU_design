#!/bin/sh

#vfile_name="SYS_PC_PSEUDO_SPI_INTF_SCAN_TEST.v"
#vfile_name="SYS_PC_MEM_LOOP_8BIT_TEST.v"
#vfile_name="SYS_PC_WRT_SRAM_SUM10_VG_TEST.v"
#vfile_name="SYS_PC_WRT_SRAM_SUM10_VG_TEST.v"
vfile_name="I_MEMORY_CF_OSCD_TASK_8BIT.v"


#grep 'tmpi_datain.*DEFAULT_PC_ADDR' SYS_PC_WRT_SRAM_SUM10_VG_TEST.v -wc
addrs_max=$(grep 'tmpi_datain.*DEFAULT_PC_ADDR' ${vfile_name} -wc)
echo $addrs_max
index=1;

addrs_entry=`grep -n 'tmpi_datain.*DEFAULT_PC_ADDR' ${vfile_name}`
#echo $addrs_entry
#exit
IFS=$'\n'
for entry in $addrs_entry; do
#for entry in `grep -n 'tmpi_datain.*DEFAULT_PC_ADDR' ${vfile_name}`; do
    #echo $entry
    line=`echo $entry | awk -F":" '{print $1}'`
    #echo $entry | sed "s/[0-9]* *+ *DEFAULT_PC_ADDR/${index} + DEFAULT_PC_ADDR/"
    sed -e "$line s/[0-9]* *+ *DEFAULT_PC_ADDR/${index} + DEFAULT_PC_ADDR/" -i $vfile_name
    index=$(($index + 1))
done
unset IFS
exit

