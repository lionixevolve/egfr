from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '6'),
			self.residue_range('25', '27'),
			self.residue_range('51', '55'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3UG1_A/to_model_3UG1_A',
	knowns = '3UG1_A', sequence = '3UG1_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
