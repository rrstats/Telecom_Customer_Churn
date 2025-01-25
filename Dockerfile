FROM python:3.9-slim

RUN pip install pipenv
RUN pip install numpy pandas waitress scikit-learn


WORKDIR /app
COPY ["Pipfile", "Pipfile.lock", "./"]

RUN pipenv install --deploy --system

COPY ["predict.py", "model_C=1.0.bin", "./"]

EXPOSE 9696

ENTRYPOINT ["waitress-serve", "--host=0.0.0.0", "--port=9696", "predict:app"]