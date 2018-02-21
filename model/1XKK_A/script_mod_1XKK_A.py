from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('32', '35'),
			self.residue_range('48', '51'),
			self.residue_range('165', '172'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/1XKK_A/to_model_1XKK_A',
	knowns = '1XKK_A', sequence = '1XKK_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 10

a.make()
