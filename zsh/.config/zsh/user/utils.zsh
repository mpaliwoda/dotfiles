__clean() {
    find . | grep -E "$1" | xargs rm -rf
}

py_clean() {
    __clean "(__pycache__|\.pyc|\.pyo$|.mypy_cache|.pytest_cache|.benchmarks|.ruff_cache)"
}
