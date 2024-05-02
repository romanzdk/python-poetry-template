ARG PYTHON_VERSION=3.12.3
FROM python:$PYTHON_VERSION-bookworm

ARG POETRY_VERSION=1.8.2
ENV POETRY_VERSION=$POETRY_VERSION
ENV POETRY_HOME=/usr/local
ENV POETRY_VIRTUALENVS_CREATE=false
RUN curl -sSL https://install.python-poetry.org | python -

WORKDIR /usr/src/app

COPY poetry.lock pyproject.toml /usr/src/app/

RUN poetry install

COPY . /usr/src/app/

RUN chown -R nobody /usr/src/app/

RUN usermod --home /tmp nobody
USER nobody

ENV PYTHONPATH /usr/src/app

## Update this according to youer project needs
#CMD ["python", "-m", "example"]
