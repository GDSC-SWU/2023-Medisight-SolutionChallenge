# pip install opencv-contrib-python
# pip install --upgrade google-cloud-vision
# pip install pandas


import os
import io
from google.cloud import vision
from google.cloud.vision_v1 import types
import pandas as pd

credential_path = "privateKey.json"
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = credential_path


def detect_text(path: str) -> str:
    """Detects text in the file."""
    client = vision.ImageAnnotatorClient()
    with io.open(path, 'rb') as image_file:
        content = image_file.read()

    image = vision.Image(content=content)
    response = client.text_detection(image=image)
    texts = response.text_annotations

    df = pd.DataFrame(columns=['locale', 'description'])
    for text in texts:
        df = df.append(
            dict(
                locale=text.locale,
                description=text.description
            ),
            ignore_index=True
        )

    text: str = df['description'][0]

    return text
