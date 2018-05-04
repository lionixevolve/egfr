from pymol.cgo import *
from pymol import cmd

cmd.set("cartoon_fancy_helices", 1)
cmd.set("cartoon_transparency", 0.2)
cmd.set("ray_trace_mode",  1)
cmd.set("two_sided_lighting", "on")
cmd.set("reflect", 0)
cmd.set("ambient", 0.5)
cmd.set("ray_trace_mode",  0)
cmd.set('''ray_opaque_background''', '''off''')
cmd.load("1M14_A.pdb")
cmd.load("3_modo1_1M14_A.pdb")
cmd.load("modevectors.py")
modevectors("1M14_A", "3_modo1_1M14_A", outname="modevectors", head=0.5, tail = 0.3, cut=0.5, headrgb = "1.0, 0.0, 0.2", tailrgb = "1.0, 0.0, 0.2") 

 
cmd.select("nlobe", "resi 1:95")
cmd.select("clobe", "resi 96:150+178:277")
cmd.select("aloop", "resi 151:177")
cmd.select("HRD", "resi 133:135")
cmd.select("K745", "resi 43")
cmd.select("E762", "resi 60")
cmd.color("limon", "nlobe")
cmd.color("bluewhite", "clobe")
cmd.color("deepsalmon", "aloop")

cmd.set_view (\
     '''0.734080613,    0.234402448,   -0.637322366,\
     0.464893073,   -0.857580781,    0.220061228,\
    -0.494974792,   -0.457829952,   -0.738506436,\
    -0.000086524,    0.000047307, -170.281890869,\
    26.372928619,    6.510026932,   56.808116913,\
    90.509712219,  250.067825317,  -20.000000000''' )

cmd.png("a9fig_1m14.png", width=900, height=1100, dpi=600, ray=1)
