import imutils
import numpy as np
from PIL import Image
import python_equalizer


def rot_img(file_dir):
	"""

	:param file_dir: STR
	:return: list of arrays of rotated images by 15 deg.
	"""
	img = Image.open(file_dir)
	arr = np.asarray(img)
	all_rots = []
	for ang in np.arange(0, 360, 15):
		rot_arr = imutils.rotate_bound(arr, ang)
		all_rots.append(rot_arr)
	return all_rots


def save_rot(file_dir, list_of_arrays, dir_string='_rot'):
	"""

	:param file_dir: STR
	:param list_of_arrays: output of rot_img()
	:param dir_string: STR
	:return: saves all images in a list
	"""
	_rot = file_dir[:6] + dir_string + file_dir[6:]
	for index, each in enumerate(list_of_arrays):
		to_save = Image.fromarray(each)
		rot_string = _rot[:-4] + '_' + str(index) + _rot[-4:]
		to_save.save(rot_string)


def norm_only(file_dir):
	"""

	:param file_dir: STR
	:return: uses histogram equalization to adjust
	intensities of image so they are distributed
	more uniformally.
	"""
	_rot_norm = file_dir[:6] + '_norm' + file_dir[6:]
	to_save = python_equalizer.final(file_dir)
	to_save.save(_rot_norm)