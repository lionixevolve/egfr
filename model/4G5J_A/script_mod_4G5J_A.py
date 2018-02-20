from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '7'),
			self.residue_range('26', '29'),
			self.residue_range('52', '61'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/4G5J_A/to_model_4G5J_A',
            knowns = '4G5J_A', sequence = '4G5J_A_full')
a.starting_model= 1
a.ending_model  = 50

a.make()
