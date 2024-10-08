RTL_FILES  := src/top.sv src/dut.sv
TOP_MODULE := top
SIMV       := simv
FST_FLAG   := -fst
WAVES      := waves.fst
GTKWAVE    := $(shell which gtkwave)

.PHONY: run clean gtkwave
run: ${SIMV}
	./${SIMV} ${FST_FLAG} +waves:${WAVES}

clean:
	rm -f ${SIMV} ${WAVES}

gtkwave:
	${GTKWAVE} ${WAVES}

${SIMV}: ${RTL_FILES}
	iverilog -g2012 -s ${TOP_MODULE} -o $@ $^
