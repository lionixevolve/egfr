from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('48', '52'),
			self.residue_range('159', '173'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/5CNN_A/to_model_5CNN_A',
	knowns = '5CNN_A', sequence = '5CNN_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
