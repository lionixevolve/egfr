from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('18', '22'),
			self.residue_range('46', '48'),
			self.residue_range('162', '164'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/2EB2_A/to_model_2EB2_A',
	knowns = '2EB2_A', sequence = '2EB2_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
