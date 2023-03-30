import uvicorn
from fastapi import FastAPI, UploadFile, File
from ML.ocr import detect_text
from ML.positionguide import detect_hand
import re

app = FastAPI()


@app.post("/OCR/")
async def image_ocr(file: UploadFile = File(...)):
    file_location = f"files/{file.filename}"
    with open(file_location, "wb+") as file_object:
        file_object.write(file.file.read())

    try:
        text = detect_text(file_location)

        new_str = re.sub(r"[^\uAC00-\uD7A30-9]", "", text)
        a = re.search("기한[0-9]+", new_str)
        if (a == None):
            raise AttributeError
        num = re.search("[0-9]+", str(a.group()))
        date = str(num.group())

        if (len(date) == 8):
            return (date[0:4]+"년 "+date[4:6]+"월 "+date[6:]+"일")
        elif (len(date) == 6):
            return (date[0:2]+"년 "+date[2:4]+"월 "+date[4:]+"일")
    except:
        return

@app.post("/guide/")
async def guide_ocr(file: UploadFile = File(...)):
    file_location = f"files/{file.filename}"
    with open(file_location, "wb+") as file_object:
        file_object.write(file.file.read())

    try:
        result = detect_hand(file_location, file.filename)
        return {"result": result}
    except:
        return {"error": "오류가 발생했습니다."}



if __name__ == '__main__':
    uvicorn.run(app, host='127.0.0.1', port=8000)
