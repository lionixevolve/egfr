#!/usr/bin/env julia

modos = readdlm(ARGS[1])
writedlm(ARGS[2], modos[:, 1])
writedlm(ARGS[3], modos[:, 2])
