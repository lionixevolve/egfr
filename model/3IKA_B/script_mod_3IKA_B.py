from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('159', '162'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3IKA_B/to_model_3IKA_B',
	knowns = '3IKA_B', sequence = '3IKA_B_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
