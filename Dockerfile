FROM python:3.9 as build

WORKDIR /tmp


RUN pip install poetry

COPY pyproject.toml /tmp/

RUN poetry export -f requirements.txt --output requirements.txt --without-hashes


FROM python:3.9.7-bullseye

WORKDIR /usr/src/app

COPY --from=build /tmp/requirements.txt /usr/src/app/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /usr/src/app/requirements.txt

COPY api.py /usr/src/app/

CMD ["uvicorn", "api:app", "--host", "0.0.0.0", "--port", "5000"]

