# Welcome to Cloud Functions for Firebase for Python!
# To get started, simply uncomment the below code or create your own.
Deploy with `firebase deploy`

import io
import pathlib
from PIL import Image
from firebase_functions import https_fn
from firebase_admin import initialize_app 
from firebase_functions import firestore_fn, https_fn
from firebase_admin import initialize_app, firestore
from firebase_functions import storage_fn
import google.cloud.firestore
from google.cloud import vision

app = initialize_app()
from firebase_admin import storage


@storage_fn.on_object_finalized()
def readImage(event: storage_fn.CloudEvent[storage_fn.StorageObjectData]):
    bucket_name = event.data.bucket
    file_path = pathlib.PurePath(event.data.name)
    content_type = event.data.content_type
    bucket = storage.bucket(bucket_name)

    with io.open(file_path, 'rb') as image_file:
        content = image_file.read()
    image = vision.Image(content=content)
    
