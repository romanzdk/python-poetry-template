import nox
from nox_poetry import Session, session

nox.options.sessions = ["cq"]
nox.options.error_on_missing_interpreters = False
nox.options.reuse_existing_virtualenvs = True

python_versions = ["3.12"]


@session(python=python_versions)
def test(session: Session) -> None:
    session.install(".")
    session.run("pytest")


@nox.session(python=python_versions)
def cq(session: Session) -> None:
    session.install("ruff")
    session.run("ruff", "check", "--unsafe-fixes", "--fix", ".")
    session.run("ruff", "format", ".")
