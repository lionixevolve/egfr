from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '27'),
			self.residue_range('45', '48'),
			self.residue_range('62', '62'),
			self.residue_range('73', '78'),
			self.residue_range('183', '200'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3GOP_A/to_model_3GOP_A',
	knowns = '3GOP_A', sequence = '3GOP_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
