from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '6'),
			self.residue_range('52', '53'),
			self.residue_range('166', '179'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/5HIC_A/to_model_5HIC_A',
            knowns = '5HIC_A', sequence = '5HIC_A_full')
a.starting_model= 1
a.ending_model  = 50

a.make()
