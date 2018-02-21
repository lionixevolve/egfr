from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '7'),
			self.residue_range('168', '172'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/5HIB_A/to_model_5HIB_A',
	knowns = '5HIB_A', sequence = '5HIB_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
