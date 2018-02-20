from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '6'),
			self.residue_range('25', '27'),
			self.residue_range('52', '52'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3VJN_A/to_model_3VJN_A',
            knowns = '3VJN_A', sequence = '3VJN_A_full')
a.starting_model= 1
a.ending_model  = 50

a.make()
