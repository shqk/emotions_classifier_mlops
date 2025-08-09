FROM python:3.12

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./src /code/src
COPY ./model/bert_emotions_6 /code/model/bert_emotions_6

CMD ["fastapi", "run", "src/main.py", "--port", "80"]