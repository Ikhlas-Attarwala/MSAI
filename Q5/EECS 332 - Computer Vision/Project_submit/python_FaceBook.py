import numpy as np
import cv2
import pickle
import matplotlib.pyplot as plt

face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_alt2.xml')

recog = cv2.face.LBPHFaceRecognizer_create()

with open('PICKLEpeople.pickle', 'rb') as f:
	recog.read('fin_trained_people.yml')

# with open('PICKLEpeople_norm.pickle', 'rb') as f:
# 	recog.read('fin_trained_people_norm.yml')

# with open('PICKLEpeople_rot.pickle', 'rb') as f:
# 	recog.read('fin_trained_people_rot.yml')

# with open('PICKLEpeople_rot_norm.pickle', 'rb') as f:
# 	recog.read('fin_trained_people_rot_norm.yml')

	name_dict = pickle.load(f)
	names = {v:k for k,v in name_dict.items()}

acc_scores = []
cap = cv2.VideoCapture(0)
while(True):
	ret, frame = cap.read()
	gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	faces = face_cascade.detectMultiScale(gray, scaleFactor=1.5, minNeighbors=5)

	for (left, top, right, bot) in faces:
		width = left + right
		height = top + bot

		bounding_box = frame[top:height, left:width]
		bounding_box_gray = gray[top:height, left:width]

		id, accuracy = recog.predict(bounding_box_gray)
		print(names[id], ':', accuracy)
		if names[id] == 'Ikhlas Attarwala':
			acc_scores.append(accuracy)
			print(True)
		font = cv2.FONT_ITALIC
		box_name = names[id]
		cv2.rectangle(frame, (left, top), (width, height), (255, 0, 0), 2)
		cv2.putText(frame, box_name, (left, top), font, 1, (255, 0, 0), 2, cv2.LINE_AA)

	cv2.imshow('frame', frame)

	# quit on pressing 'q'
	if cv2.waitKey(20) & 0xFF == ord('q'):
		break

cap.release()
cv2.destroyAllWindows()

# line
plt.subplot(2,2,1)

list_ind = []
list_score = []
for index,score in enumerate(acc_scores):
	list_ind.append(index)
	list_score.append(score)
plt.plot(list_ind, list_score)
plt.title('Confidence per recognition')
plt.ylabel('Confidence %')
plt.xlabel('Time in # of measurements')

# # time
# plt.subplot(2,2,2)
# starttime = time.time()
# sec = []
# max_index = []
# c = 1
# while c < 6:
# 	sec.append(c)
# 	max_index.append(list_ind[-1])
# 	c += 1
# 	time.sleep(1.0 - ((time.time() - starttime) % 1))
# print('...........................................................................................................')
# plt.plot(sec, max_index)
# plt.title('Measurements Recorded wrt. Time')
# plt.ylabel('# of Measurements Recorded')
# plt.xlabel('Time in seconds')

# hist
plt.subplot(2,2,2)
plt.hist(list_score)
plt.title('Histogram of Confidence Scores')
plt.ylabel('Count')
plt.xlabel('Confidence %')

# comparison
plt.subplot(2,2,3)
x = ['low', 'mean', 'median', 'high']
low = np.min(list_score)
mean = np.mean(list_score)
median = np.median(list_score)
high = np.max(list_score)
scores = [low, mean, median, high]
x_pos = [i for i, _ in enumerate(x)]
plt.bar(x_pos, scores)
plt.title('Confidence Scores')
plt.ylabel('Score')
plt.xlabel('Measure of')
plt.xticks(x_pos, x)

plt.show()