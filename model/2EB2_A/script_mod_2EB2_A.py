from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '7'),
			self.residue_range('26', '28'),
			self.residue_range('54', '54'),
			self.residue_range('170', '170'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/2EB2_A/to_model_2EB2_A',
            knowns = '2EB2_A', sequence = '2EB2_A_full')
a.starting_model= 1
a.ending_model  = 1

a.make()
