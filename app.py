from scripts.test_model import *
import streamlit as st


model_path = './model/bert_emotions_6'
tokenizer, model = load_model(model_path)
classifier = classifier(tokenizer, model)

labels = ['anger', 'disgust', 'fear', 'joy', 'sadness', 'surprise']

st.title('Emotions Classifier')

to_classify = st.text_input('Write your text')

button = st.button('Check main emotion')


if button == True:
    results = classifier(to_classify)
    index = results[0]["label"][-1]
    st.write('Detected emotion: ', labels[int(index)])
    st.write(f'Confidence: {round(float(results[0]["score"])*100, 2)}%')