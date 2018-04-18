from pymol import cmd,stored
stored.list = []
cmd.iterate("(wacho)", "stored.list.append(index)")
print stored.list
