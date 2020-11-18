#!/bin/bash

check_ret() {
    if [ $1 -ne 0 ]; then
        echo ""
        echo "!!! FAIL: $3"
        echo "********************************************************************************"
        echo ""
        exit $1
    else
        echo ""
        echo "*** SUCCESS: $2"
        echo "********************************************************************************"
        echo ""
    fi
}

python3 -m pylint --version
check_ret $? "pylint --version"

python3 -m pylint --rcfile=.pylintrc setup.py
check_ret $? "pylint setup.py"

cd sea5kg_cpplint
check_ret $? "change directory to sea5kg_cpplint"

python3 -m pylint --rcfile=../.pylintrc *.py
check_ret $? "pylint in sea5kg_cpplint"

cd ../tests
check_ret $? "change directory to ../tests"

python3 -m pylint --rcfile=../.pylintrc *.py
check_ret $? "pylint in tests"

python3 -m pytest -rAs .
check_ret $? "pytest"

