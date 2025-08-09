from typing import Union

from fastapi import FastAPI
from .model_loader import *

app = FastAPI()

model_path = "./model/bert_emotions_6"
tokenizer, model = load_model(model_path)
classifier = create_classifier(tokenizer, model)


@app.get("/")
def read_root():
    return {
        "Hello" : "Word!"
    }

@app.post("/classify")
def classify(text: str):
    return classifier(text)

