from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '3'),
			self.residue_range('49', '55'),
			self.residue_range('164', '176'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/4I24_A/to_model_4I24_A',
            knowns = '4I24_A', sequence = '4I24_A_full')
a.starting_model= 1
a.ending_model  = 1

a.make()
