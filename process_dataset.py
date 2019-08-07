import glob
import os
from shutil import copyfile
import cv2
from detect_face import detect_faces
import shutil

def remove_old_set(emotions):
    """
    Removes old images produced from dataset.
    :param emotions: List of emotions names.
    """
    print("Removing old dataset")
    for emotion in emotions:
        filelist = glob.glob("data/sorted_set/%s/*" % emotion)
        for f in filelist:
            os.remove(f)


def harvest_dataset(emotions):
    """
    Copies photos of participants in sessions to new folder.
    :param emotions: List of emotions names.
    """
    print("Harvesting dataset")
    participants = glob.glob('data/source_emotions/*')  # returns a list of all folders with participant numbers

    for participant in participants:
        neutral_added = False

        for sessions in glob.glob("%s/*" % participant):  # s tore list of sessions for current participant
            for files in glob.glob("%s/*" % sessions):
                current_session = files[20:-30]
                file = open(files, 'r')

                # emotions are encoded as a float, readline as float, then convert to integer
                str_ = file.readline().strip()
                emotion = int(float(str_))
                images = glob.glob("data/source_images/%s/*" % current_session)

                # get path for last image in sequence, which contains the emotion
                source_filename = images[-1].split('/')[-1]
                print(source_filename)
                # do same for emotion containing image
                destination_filename = "data/sorted_set/%s" % (emotions[emotion])
                print("data/source_images%s" % (source_filename))
                print(destination_filename)
                # copy file
                shutil.copy("data/source_images%s" % (source_filename), destination_filename)

                if not neutral_added:
                    # do same for neutral image
                    source_filename = images[0].split('/')[-1]

                    # generate path to put neutral image
                    destination_filename = "data/sorted_set/neutral"
                    # copy file
                    shutil.copy("data/source_images%s" % (source_filename), destination_filename)
                    neutral_added = True


def extract_faces(emotions):
    """
    Crops faces in emotions images.
    :param emotions: List of emotions names.
    """
    print("Extracting faces")
    for emotion in emotions:

        photos = glob.glob('data/sorted_set/%s/*' % emotion)

        for file_number, photo in enumerate(photos):
            frame = cv2.imread(photo)
            normalized_faces = detect_faces(frame)
            os.remove(photo)

            for face in normalized_faces:
                try:
                    cv2.imwrite("data/sorted_set/%s/%s.png" % (emotion, file_number + 1), face[0])  # write image
                except:
                    print("error in processing %s" % photo)


if __name__ == '__main__':
    emotions = ['neutral', 'anger', 'contempt', 'disgust', 'fear', 'happy', 'sadness', 'surprise']
    remove_old_set(emotions)
    harvest_dataset(emotions)
    extract_faces(emotions)