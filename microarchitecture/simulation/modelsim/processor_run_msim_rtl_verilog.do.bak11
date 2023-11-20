transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/buffer.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/instructionDecode.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/registerBank.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/signExtend.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/controlUnit.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/immSrcControl.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/branchFlagControl.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/aluControl.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/memWriteControl.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/memToRegControl.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/regWriteControl.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/modeSelectorUnit.sv}

vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/instructionDecode_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  instructionDecode_tb

add wave *
view structure
view signals
run -all
