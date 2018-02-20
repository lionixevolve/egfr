from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '6'),
			self.residue_range('164', '178'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/5CAP_A/to_model_5CAP_A',
            knowns = '5CAP_A', sequence = '5CAP_A_full')
a.starting_model= 1
a.ending_model  = 1

a.make()