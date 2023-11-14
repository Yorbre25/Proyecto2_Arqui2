transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/sinROM.v}
vlog -vlog01compat -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/cosROM.v}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/execScalar.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/flagRegister.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/SetFlags.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/Operator.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/Mux.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/ALU.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/buffer.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/mux21.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/operatorsAluMux.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/mux41.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/exec.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/ALUMux.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/execVect.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/ALUVect.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/ALUElement.sv}

vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/exec_tb.sv}
vlog -sv -work work +incdir+C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture {C:/Users/yraul/OneDrive/Documentos/GitHub/Proyecto2_Arqui2/microarchitecture/exec.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  exec_tb

add wave *
view structure
view signals
run -all
