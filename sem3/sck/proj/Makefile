help:
	$(info )
	$(info ---------------------------------------------------------------------------------)
	$(info !																				)
	$(info ! Wywolania make:																)
	$(info !   1. Przeprowadzenie symulacji VERILOG modelu ktory jest w katalogu ./MODEL	)
	$(info !      a TESTBENCH z pobudzeniami znajduje sie w katalogu ./TESTBENCH			)
	$(info ! 																				)
	$(info !            make sim_model 														)
	$(info ! 																				)
	$(info !																				)
	$(info ---------------------------------------------------------------------------------)
	$(info )

sim_model:
		make sim_model -C ./WORK -f Makefile.sim
		
gates:
		make gates -C ./WORK -f Makefile.gates

sim_gates_slow:
		make sim_gates_slow -C ./WORK -f Makefile.gates

sim_gates_fast:
		make sim_gates_fast -C ./WORK -f Makefile.gates


.PHONY: help