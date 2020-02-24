import cv2
PADDING = 50

def process_frame(img, frame, face_cascade):
    bounding = False
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
        
        img = cv2.rectangle(frame,(x1, y1),(x2, y2),(255,0,0),2)
    return img

#def save_image(part_image, name):
#    img_name = "images/"+name+str(random.randrage(0,100))
#    cv2.imwrite(img_name,part_image)
#    print("{} written".format(img_name)

          
def main():
    
    cam = cv2.VideoCapture(0)

    cv2.namedWindow("test")

    img_counter = 0

    while True:
        ret, frame = cam.read()
        cv2.imshow("test", frame)
        face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
        img = frame
#        img = process_frame(img, frame, face_cascade)
        if not ret:
            break
        k = cv2.waitKey(1)
#        cv2.imshow("preview", img)
        if k%256 == 27:
            # ESC pressed
            print("Escape hit, closing...")
            break
        elif k%256 == 32:
            # SPACE pressed
            img_name = "images/Nico{}.png".format(img_counter)
            cv2.imwrite(img_name, frame)
            print("{} written!".format(img_name))
            img_counter += 1

    cam.release()


if __name__=='__main__':
    main()
