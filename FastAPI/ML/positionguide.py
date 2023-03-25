# -*- coding: utf-8 -*-

from ultralytics import YOLO
import torch
import os
from pathlib import Path
import shutil

def detect_hand(path: str, inputFileName: str) -> str:
  try:
    dir, fname = os.path.split(os.path.realpath(__file__))
    torchPath = Path(dir) / "content/hand.pt"
    model = YOLO(torchPath)
    imagePath = Path(dir).parent / path
    results = model.predict(source=imagePath, conf=0.25, save = True, save_txt = True)

    txtPath = "runs/detect/predict/labels/" + inputFileName[:-4] + ".txt"

    try:
        # 감지한 내용을 담은 txt 파일 읽기 (왼 / 오 여부가 나타나있음)
        with open(Path(dir).parent / txtPath, "r") as f:
            lis = f.readlines()

    except FileNotFoundError:
        # predict 파일 제거 및 초기화
        shutil.rmtree(Path(dir).parent / "runs/detect/predict")
        # 인식이 아예 되지 않아서 파일이 존재하지 않을 때
        return "인식이 잘 되지 않습니다. 촬영 상태를 확인해주세요."

    li = lis[0].split()
    ind = int(li[0])

    # print(ind)

    # cx, cy = boxes[0][0], boxes[0][1]
    # print(cx, cy)

    boxes = torch.tensor(results[0].boxes.xywh)

    # predict 파일 제거 및 초기화
    shutil.rmtree(Path(dir).parent / "runs/detect/predict")

    #boxes
    return hand_position(boxes, ind)

  except Exception as e:
    print(e)


# 손 위치에 따른 가이드
def hand_position(boxes, ind):
  
  cx, cy = boxes[0][0], boxes[0][1]

  if (ind == 0 or ind == 2) and cx < 300: # 왼손일 때 왼쪽으로 치우쳐진 경우
    return "손을 오른쪽으로 천천히 움직여주세요."
  
  elif (ind == 0 or ind == 2) and cx > 1300:  # 왼손일 때 오른쪽으로 치우쳐진 경우
    return "손을 왼쪽으로 천천히 움직여주세요."

  elif (ind == 1 or ind == 3) and cx > 1300: # 오른손일 때 오른쪽으로 치우쳐진 경우
    return "손을 왼쪽으로 천천히 움직여주세요."

  elif (ind == 1 or ind == 3) and cx < 300: # 오른손일 때 왼쪽으로 치우쳐진 경우
    return "손을 오른쪽으로 천천히 움직여주세요."

  else : # 인식이 잘 된 경우
    return "카메라 초점이 맞지 않습니다."
