import os
import cv2
import numpy as np
from PIL import Image
import pickle

face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_alt2.xml')

def func(root='people', down=False):
	id_num = 1
	name_dict = {}
	list_of_ids = []
	list_of_bounds = []

	for root_dir, dir, all_files in os.walk(root):
		for file_name in all_files:
			if file_name.endswith('png') or file_name.endswith('jpg'):
				file_dir = os.path.join(root_dir, file_name)
				student_name = os.path.basename(os.path.dirname(file_dir)).replace('_', ' ').title()

				if student_name not in name_dict:
					name_dict[student_name] = id_num
					id_num += 1

				id_number = name_dict[student_name]

				# grayscale conversion
				gray_img = Image.open(file_dir).convert('L')
				# downsampling filter
				final_img = gray_img.resize((500, 500), Image.ANTIALIAS)

				if down == False:
					# work
					arr = np.array(gray_img, 'uint8')
				else:
					arr = np.array(final_img, 'uint8')
				# arr = np.array(final_img, 'uint8')
				faces = face_cascade.detectMultiScale(arr)
				for (left, top, right, bot) in faces:
					width = left + right
					height = top + bot

					bounding_box = arr[top:height, left:width]
					list_of_bounds.append(bounding_box)
					list_of_ids.append(id_number)
	return name_dict, list_of_bounds, list_of_ids





# YML files
# using gray images

# def training(root='people'):
# def training(root='people_norm'):
# def training(root='people_rot'):
# def training(root='people_rot_norm'):
# 	recognizer = cv2.face.LBPHFaceRecognizer_create()
# 	out1, out2, out3 = func(root)
# 	recognizer.train(out2, np.asarray(out3))
# 	string = 'fin_trained_' + root + '.yml'
# 	recognizer.save(string)
#
# training()

# or with downsampling

# def training(root='people', down=True):
# def training(root='people_norm', down=True):
# def training(root='people_rot', down=True):
# def training_down(root='people_rot_norm', down=True):
# 	out1, out2, out3 = func(root)
# 	recognizer.train(out2, np.asarray(out3))
# 	string = 'fin_trained_' + root + '.yml'
# 	recognizer.save(string)
#
# training_down()




# pickling

# with open('PICKLEpeople.pickle', 'wb') as f:
# 	pickle.dump(func(root='people', down=False)[0], f)
# with open('PICKLEpeople_norm.pickle', 'wb') as f:
# 	pickle.dump(func(root='people_norm', down=False)[0], f)
# with open('PICKLEpeople_rot.pickle', 'wb') as f:
# 	pickle.dump(func(root='people_rot', down=False)[0], f)
# with open('PICKLEpeople_rot_norm.pickle', 'wb') as f:
# 	pickle.dump(func(root='people_rot_norm', down=False)[0], f)
