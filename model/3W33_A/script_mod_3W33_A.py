from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '2'),
			self.residue_range('49', '53'),
			self.residue_range('163', '174'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3W33_A/to_model_3W33_A',
            knowns = '3W33_A', sequence = '3W33_A_full')
a.starting_model= 1
a.ending_model  = 1

a.make()
