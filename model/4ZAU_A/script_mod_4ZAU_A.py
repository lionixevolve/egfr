from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('44', '54'),
			self.residue_range('160', '164'),
			self.residue_range('170', '173'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/4ZAU_A/to_model_4ZAU_A',
	knowns = '4ZAU_A', sequence = '4ZAU_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
