from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '3'),
			self.residue_range('51', '55'),
			self.residue_range('164', '174'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/5CNO_A/to_model_5CNO_A',
	knowns = '5CNO_A', sequence = '5CNO_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
