__clean() {
    find -E . -regex ".*$1" -print0 | xargs -0 rm -rf
}

py_clean() {
    __clean "(__pycache__|\.pyc|\.pyo$|.mypy_cache|.pytest_cache|.benchmarks|.ruff_cache)"
}
