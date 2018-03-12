from pymol import cmd

cmd.load("modevectors.py")
cmd.load("./cut_avg_1m14.pdb")
cmd.load("disp_avg_1m14.pdb")
cmd.load("pock_1m14_1.pdb")

cmd.set_view ( '''0.634891212,    0.608652472,    0.475852638,\
    -0.286199570,   -0.386813581,    0.876609623,\
     0.717629075,   -0.692744732,   -0.071385831,\
    -0.000408612,    0.000077665, -172.362731934,\
    42.636550903,   40.164215088,   40.002758026,\
   130.975585938,  213.611175537,  -20.000000000''' )


modevectors("cut_avg_1m14", "disp_avg_1m14", head=.7, tail=0.2, head_length=1.2, headrgb="1.0,0.0,0.0", tailrgb="1.0,0.0,0.0", cutoff=1.7)

cmd.color("deepsalmon", "pock_1m14_1")
cmd.color("skyblue", "cut_avg_1m14")
cmd.set("cartoon_fancy_helices", 1)
cmd.set("ray_trace_mode",  1)
cmd.set("two_sided_lighting", "on")
cmd.set("reflect", 0)
cmd.set("ambient", 0.5)
cmd.set("ray_trace_mode",  0)
cmd.set('''ray_opaque_background''', '''off''')

cmd.png("4c-porc_1m14.png", width=1800, height=1100, dpi=600, ray=1)
