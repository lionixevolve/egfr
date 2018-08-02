#!/bin/bash

julia pava.jl -p 1M14_A.pdb -v 1modo_1M14_A -t 60 -r 60 -o modo1_1M14_A --script

julia pava.jl -p 1M14_A.pdb -v 2modo_1M14_A -t 60 -r 60 -o modo2_1M14_A --script

# Agregar después al script:
# 
# cmd.select("nlobe", "resi 1:95")
# cmd.select("clobe", "resi 96:150+178:277")
# cmd.select("aloop", "resi 151:177")
# cmd.select("HRD", "resi 133:135")
# cmd.select("K745", "resi 43")
# cmd.select("E762", "resi 60")
# cmd.color("limon", "nlobe")
# cmd.color("bluewhite", "clobe")
# cmd.color("deepsalmon", "aloop")
# cmd.png("afig9_1m14.png", width=900, height=1100, dpi=600, ray=1)

exit 0
