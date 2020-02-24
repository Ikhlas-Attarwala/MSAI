import os

# saves equalized images

import python_trans

for root_dir, dir, all_files in os.walk('people'):
	for file_name in all_files:
		if file_name.endswith('png') or file_name.endswith('jpg'):
			file_dir = os.path.join(root_dir, file_name)
			student_name = os.path.basename(os.path.dirname(file_dir)).replace('_', ' ').title()

			print(student_name)

			python_trans.norm_only(file_dir)