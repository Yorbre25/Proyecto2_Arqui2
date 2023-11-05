transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/sinROM.v}
vlog -vlog01compat -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/cosROM.v}
vlog -sv -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/mux21.sv}
vlog -sv -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/mux41.sv}
vlog -sv -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/execVect.sv}
vlog -sv -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/ALUVect.sv}
vlog -sv -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/ALUElement.sv}

vlog -sv -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/ALUVect_tb.sv}
vlog -vlog01compat -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/sinROM.v}
vlog -vlog01compat -work work +incdir+C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture {C:/TEC/Arqui2/Proyecto2_Arqui2/microarchitecture/cosROM.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  ALUVect_tb

add wave *
view structure
view signals
run -all
