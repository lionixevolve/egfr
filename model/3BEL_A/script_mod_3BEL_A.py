from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '1'),
			self.residue_range('33', '36'),
			self.residue_range('47', '52'),
			self.residue_range('166', '173'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/3BEL_A/to_model_3BEL_A',
            knowns = '3BEL_A', sequence = '3BEL_A_full')
a.starting_model= 1
a.ending_model  = 1

a.make()