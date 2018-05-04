from pymol import cmd

cmd.load("./1M14_A.pdb")

cmd.set_view (\
     ''' 0.847476959,    0.312563360,   -0.429026186,\
     0.428718925,   -0.879621565,    0.206053212,\
    -0.312964320,   -0.358564079,   -0.879461229,\
     0.000346251,    0.000221314, -170.217346191,\
    28.520931244,    7.739858627,   56.579563141,\
   128.644897461,  212.033325195,  -20.000000000''' )


cmd.set("transparency", "0.3")
cmd.set("surface_quality", "1")

cmd.select("nlobe", "resi 1:95")
cmd.select("clobe", "resi 96:150+178:277")
cmd.select("aloop", "resi 151:177")
cmd.color("limon", "nlobe")
cmd.color("bluewhite", "clobe")
cmd.color("deepsalmon", "aloop")

cmd.select("pocket", "resi 16+17+18+19+20+21+22+24+41+43+60+64+73+86+88+89+90+91+92+94+95+97+98+101+134+135+137+139+140+142+152+153+154+155+156+171+172+173+174+175+176+177+178+179+183+184+187+189+204+211+212+218+219")
cmd.show("surface", "pocket")
cmd.color("deepteal", "pocket")

cmd.hide("lines", "all")
cmd.show("cartoon", "all")

cmd.set("cartoon_fancy_helices", 1)
cmd.set("ray_trace_mode",  1)
cmd.set("two_sided_lighting", "on")
cmd.set("reflect", 0)
cmd.set("ambient", 0.5)
cmd.set("ray_trace_mode",  0)
cmd.set('''ray_opaque_background''', '''off''')

#cmd.png("cfig1_1m14.png", width=900, height=1100, dpi=600, ray=1)
