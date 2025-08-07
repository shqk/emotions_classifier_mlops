import os
import sys
import torch
from transformers import AutoTokenizer, AutoModelForSequenceClassification, pipeline

def load_model(model_path):
    if not os.path.exists(model_path):
        print('Error, the path does not exist')

    try:
        tokenizer = AutoTokenizer.from_pretrained(model_path)
        model = AutoModelForSequenceClassification.from_pretrained(model_path)

        print("Import succeeded")

        return tokenizer, model

    except Exception as e:
        print(f"Error: Could not load the model : {e}")
        return None, None

def create_classifier(tokenizer, model):
    return pipeline(
        "text-classification",
        model=model,
        tokenizer=tokenizer,
    )