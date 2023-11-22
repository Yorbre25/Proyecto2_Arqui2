transcript on
if ![file isdirectory processor_iputf_libs] {
	file mkdir processor_iputf_libs
}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

###### Libraries for IPUTF cores 
vlib processor_iputf_libs/sram_0
vmap sram_0 ./processor_iputf_libs/sram_0
###### End libraries for IPUTF cores 
###### MIF file copy and HDL compilation commands for IPUTF cores 


vlog "C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/SRAM/simulation/submodules/SRAM_sram_0.v" -work sram_0
vlog "C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/SRAM/simulation/SRAM.v"                               


vlog -sv -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/SRAM_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -L sram_0 -voptargs="+acc"  SRAM_tb

add wave *
view structure
view signals
run -all
