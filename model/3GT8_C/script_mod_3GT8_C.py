from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '4'),
			self.residue_range('165', '177'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3GT8_C/to_model_3GT8_C',
	knowns = '3GT8_C', sequence = '3GT8_C_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
