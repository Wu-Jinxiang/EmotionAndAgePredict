from cv2 import WINDOW_NORMAL
import cv2
from detect_face import detect_faces
from image_enhance import nparray_as_image, draw_with_alpha
import time
import tensorflow as tf
from model import select_model, get_checkpoint

GENDER_LIST =['Male','Female']
AGE_LIST = ['(0, 2)','(4, 6)','(8, 12)','(15, 20)','(25, 32)','(38, 43)','(48, 53)','(60, 100)']

def classify_AG(sess,label_list,softmax_output,images,face):
    face_227x227 = tf.image.resize_images(face, (227, 227))
    batch_results = sess.run(softmax_output, feed_dict={images:face_227x227.eval()})
    best_i = np.argmax(batch_results[0])
    best_choice = (label_list[best_i], batch_results[0][best_i])
    return best_choice

def _load_emoticons(emotions):
    """
    Loads emotions images from graphics folder.
    :param emotions: Array of emotions names.
    :return: Array of emotions graphics.
    """
    return [nparray_as_image(cv2.imread('graphics/%s.png' % emotion, -1), mode=None) for emotion in emotions]

import numpy as np
    
def show_webcam_and_run(model, emoticons, window_size=None, window_name='webcam', update_time=10):
    """
    Shows webcam image, detects faces and its emotions in real time and draw emoticons over those faces.
    :param model: Learnt emotion detection model.
    :param emoticons: List of emotions images.
    :param window_size: Size of webcam image window.
    :param window_name: Name of webcam image window.
    :param update_time: Image update time interval.
    """
    cv2.namedWindow(window_name, WINDOW_NORMAL)
    if window_size:
        width, height = window_size
        cv2.resizeWindow(window_name, width, height)

    vc = cv2.VideoCapture(0)
    if vc.isOpened():
        read_value, webcam_image = vc.read()
    else:
        print("webcam not found")
        return
    fcount = 0
    assign_sta = 0
    
    while read_value:
        #a,cropped_face = detect_faces(webcam_image)
        for normalized_face, (x, y, w, h),cropped_face in detect_faces(webcam_image):
            prediction = model.predict(normalized_face)  # do prediction
            if cv2.__version__ != '3.1.0':
                prediction = prediction[0]
            
            if fcount == 1: 
                tf.reset_default_graph()
                with tf.Session().as_default() as sess:
                    images = tf.placeholder(tf.float32, [1,None, None, 3])
                    model_fn = select_model('bn')
                    logits = model_fn(8, images, 1, False)
                    checkpoint_path = 'run-2236'
                    requested_step = '29000'
                    model_checkpoint_path, global_step = get_checkpoint(checkpoint_path, requested_step, 'checkpoint')
                    saver = tf.train.Saver()
                    saver.restore(sess, model_checkpoint_path)
                    softmax_output = tf.nn.softmax(logits)
                    crp_s = np.shape(cropped_face)
                    cropped_face = cropped_face.reshape((1,crp_s[0],crp_s[1],crp_s[2]))
                    best_choice_age = classify_AG(sess,AGE_LIST,softmax_output,images,cropped_face)
                    
            elif fcount == 2: 
                tf.reset_default_graph()
                with tf.Session().as_default() as sess:
                    images = tf.placeholder(tf.float32, [1,None, None, 3])
                    model_fn = select_model('bn')
                    logits = model_fn(2, images, 1, False)
                    checkpoint_path = 'run-13408'
                    requested_step = '29000'
                    model_checkpoint_path, global_step = get_checkpoint(checkpoint_path, requested_step, 'checkpoint')
                    saver = tf.train.Saver()
                    saver.restore(sess, model_checkpoint_path)
                    softmax_output = tf.nn.softmax(logits)
                    crp_s = np.shape(cropped_face)
                    cropped_face = cropped_face.reshape((1,crp_s[0],crp_s[1],crp_s[2]))
                    best_choice_gender = classify_AG(sess,GENDER_LIST,softmax_output,images,cropped_face)
            else:
                pass
            if fcount<89:
                fcount = fcount + 1
            else:
                fcount = 0
            print('assign_sta:',assign_sta)
            image_to_draw = emoticons[prediction]
            draw_with_alpha(webcam_image, image_to_draw, (x, y, w, h))
            if assign_sta==1:
                cv2.putText(webcam_image,"Age: %s, prob = %.2f" % best_choice_age, (60,100), cv2.FONT_HERSHEY_SIMPLEX, 
                0.9,(32,48,252), 2, cv2.LINE_AA)
            elif assign_sta==2:
                cv2.putText(webcam_image,"Age: %s, prob = %.2f" % best_choice_age, (60,100), cv2.FONT_HERSHEY_SIMPLEX, 
                0.9,(32,48,252), 2, cv2.LINE_AA)
                cv2.putText(webcam_image,"Gender: %s" % best_choice_gender[0], (60,150), cv2.FONT_HERSHEY_SIMPLEX, 
                0.9,(32,48,252), 2, cv2.LINE_AA)
            if assign_sta<2:
                assign_sta = assign_sta + 1
            else:
                pass
            
        cv2.imshow(window_name, webcam_image)
        read_value, webcam_image = vc.read()
        key = cv2.waitKey(update_time)
        if key == 27:  # exit on ESC
            break

        
    cv2.destroyWindow(window_name)
    
if __name__ == '__main__':
    emotions = ['neutral', 'anger', 'disgust', 'happy', 'sadness', 'surprise']
    emoticons = _load_emoticons(emotions)

    # load model
    fisher_face = cv2.face.FisherFaceRecognizer_create()
    fisher_face.read('models/emotion_detection_model.xml')

    # use learnt model
    window_name = 'WEBCAM (press ESC to exit)'
    show_webcam_and_run(fisher_face, emoticons, window_size=(1600, 1200), window_name=window_name, update_time=8)