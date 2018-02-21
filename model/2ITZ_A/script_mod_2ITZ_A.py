from modeller import *
from modeller.automodel import *    # Load the automodel class

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '../atom_files']

class MyModel(automodel):
	def select_atoms(self):
		return selection(self.residue_range('1', '6'),
			self.residue_range('170', '179'),)


a = MyModel(env, alnfile = '/home/german/labo/18/egfr/model/2ITZ_A/to_model_2ITZ_A',
	knowns = '2ITZ_A', sequence = '2ITZ_A_full',
	assess_methods=(assess.DOPE,
		assess.GA341))
a.starting_model= 1
a.ending_model  = 50

a.make()
