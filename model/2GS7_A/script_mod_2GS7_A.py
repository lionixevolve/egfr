from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('169', '172'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/2GS7_A/to_model_2GS7_A',
	knowns = '2GS7_A', sequence = '2GS7_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 10

a.make()
