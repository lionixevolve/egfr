from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('160', '174'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3GT8_A/to_model_3GT8_A',
	knowns = '3GT8_A', sequence = '3GT8_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 10

a.make()
