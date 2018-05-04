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
cmd.load("3W32_A.pdb")
cmd.load("3_modo1_3W32_A.pdb")
cmd.load("modevectors.py")

modevectors("3W32_A", "3_modo1_3W32_A", outname="modevectors", head=1.0, tail = 0.3, cut=0.5, headrgb = "1.0, 0.0, 0.2", tailrgb = "1.0, 0.0, 0.2") 

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
    -0.000087790,    0.000049151, -170.278991699,\
    28.221431732,    7.799482346,   55.593132019,\
    -0.724745035,  341.302307129,  -20.000000000''' )

cmd.png("b9fig_3w32.png", width=900, height=1100, dpi=600, ray=1)

