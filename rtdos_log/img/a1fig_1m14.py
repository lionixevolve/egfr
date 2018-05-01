from pymol import cmd

cmd.load("./1M14_A.pdb")

cmd.set("cartoon_transparency", "0.5")
cmd.set("stick_radius", "0.5")

cmd.select("nlobe", "resi 1:95")
cmd.select("clobe", "resi 96:150+178:277")
cmd.select("aloop", "resi 151:177")
cmd.select("HRD", "resi 133:135")
cmd.select("K745", "resi 43")
cmd.select("E762", "resi 60")

cmd.hide("lines", "all")
cmd.show("cartoon", "all")

cmd.show("sticks", "K745")
#cmd.color("", "K745")
cmd.show("sticks", "E762")
#cmd.color("", "K745")


cmd.color("limon", "nlobe")
cmd.color("bluewhite", "clobe")
cmd.color("deepsalmon", "aloop")

cmd.set("cartoon_fancy_helices", 1)
cmd.set("ray_trace_mode",  1)
cmd.set("two_sided_lighting", "on")
cmd.set("reflect", 0)
cmd.set("ambient", 0.5)
cmd.set("ray_trace_mode",  0)
cmd.set('''ray_opaque_background''', '''off''')


cmd.set("label_size", "30")
cmd.label("resi 133 and name CA", "'HRD   '")
cmd.label("K745 and name CA", "'K745'")
cmd.label("E762 and name CA", "'        E762'")
cmd.label("resi 5 and name CA", "'N lobe'")
cmd.label("resi 230 and name CA", "'C lobe'")
cmd.label("resi 156 and name CA", "'            Activation'")
cmd.label("resi 169 and name CA", "'loop        '")
cmd.label("resi 51 and name CA", "'     αC'")
cmd.label("resi 52 and name CA", "'     Helix'")

cmd.set_view (\
     '''0.846367121,    0.315556258,   -0.429026186,\
     0.431824714,   -0.878101051,    0.206053212,\
    -0.311695248,   -0.359667838,   -0.879461229,\
     0.000307433,    0.000218758, -164.785781860,\
    29.518850327,    8.133912086,   56.190589905,\
   123.208457947,  206.596878052,  -20.000000000''' )


cmd.set("label_color", "black")
cmd.png("afig1_1m14.png", width=950, height=1100, dpi=600, ray=1)
