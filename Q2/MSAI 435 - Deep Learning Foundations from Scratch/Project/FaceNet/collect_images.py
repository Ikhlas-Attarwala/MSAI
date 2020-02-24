from multiprocessing.dummy import Pool
import cv2
import os
import glob
import numpy as np
from numpy import genfromtxt
from fr_utils import *
from inception_blocks_v2 import *
import random
import subprocess

PADDING = 50
ready_to_detect_identity = True

def web_cam_face_recognizer():

    """
    Runs a loop that extracts images from the computer's webcam and determines whether or not
    it contains the face of a person in our database.

    If it contains a face, an audio message will be played welcoming the user.
    If not, the program will process the next frame from the webcam
    """
    global ready_to_detect_identity

    cv2.namedWindow("preview")
    vc = cv2.VideoCapture(0)

    face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
    
    while vc.isOpened():
        _, frame = vc.read()
        img = frame

        # We do not want to detect a new identity while the program is in the process of identifying another person
        if ready_to_detect_identity:
            img = process_frame(img, frame, face_cascade)   
        
        key = cv2.waitKey(100)
        cv2.imshow("preview", img)

        if key == 27:
            # exit on ESC
            break
    cv2.destroyWindow("preview")


def process_frame(img, frame, face_cascade):
    """
    Determine whether the current frame contains the faces of people from our database
    """
    global ready_to_detect_identity
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, 1.3, 5)

    # Loop through all the faces detected and determine whether or not they are in the database
    identities = []
    for (x, y, w, h) in faces:
        x1 = x-PADDING
        y1 = y-PADDING
        x2 = x+w+PADDING
        y2 = y+h+PADDING

        img = cv2.rectangle(frame, (x1, y1), (x2, y2), (255, 0, 0), 2)

        identity = find_identity(frame, x1, y1, x2, y2)

        if identity is not None:
            identities.append(identity)

    if identities:
        cv2.imwrite('example.png', img)

        ready_to_detect_identity = False
        pool = Pool(processes=1) 
        # We run this as a separate process so that the camera feedback does not freeze
        pool.apply_async(welcome_users, [identities])
    return img


def save_image(part_image):
    global name
    img_name = "images/"+name+"{}.png".format(random.randrange(0, 100))
    cv2.imwrite(img_name, part_image)
    print("{} written!".format(img_name))

def find_identity(frame, x1, y1, x2, y2):
    
    """
        Determine whether the face contained within the bounding box exists in our database
        x1,y1_____________
        |                 |
        |                 |
        |_________________x2,y2
        """
    
    height, width, channels = frame.shape
    # The padding is necessary since the OpenCV face detector creates the bounding box around the face and not the head
    part_image = frame[max(0, y1):min(height, y2), max(0, x1):min(width, x2)]
    save_image(part_image)



if __name__ == "__main__":
    name = input("What would you like us to call you?\n")
    web_cam_face_recognizer()

# ### References:
# 
# - Florian Schroff, Dmitry Kalenichenko, James Philbin (2015). [FaceNet: A Unified Embedding for Face Recognition
# and Clustering](https://arxiv.org/pdf/1503.03832.pdf)
# - Yaniv Taigman, Ming Yang, Marc'Aurelio Ranzato, Lior Wolf (2014). [DeepFace: Closing the gap to human-level
# performance in face verification](https://research.fb.com/wp-content/uploads/2016/11/deepface-closing-the-gap-to-human
# -level-performance-in-face-verification.pdf)
# - The pretrained model we use is inspired by Victor Sy Wang's implementation and was loaded using his code:
# https://github.com/iwantooxxoox/Keras-OpenFace.
# - Our implementation also took a lot of inspiration from the official FaceNet github repository:
# https://github.com/davidsandberg/facenet
# 
