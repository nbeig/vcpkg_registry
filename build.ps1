set VCPKG_DEFAULT_TRIPLET=x64-windows

if(Test-Path -Path "./vcpkg") {
    echo "vcpkg folder exist."
    Set-Location ${PWD}/vcpkg
	echo "Current path"
	echo "${PWD}"
} else {
    echo "cloning vcpkg"
    git.exe clone https://github.com/microsoft/vcpkg
    Set-Location ${PWD}/vcpkg
	echo "Current path"
	echo "${PWD}"
    ./bootstrap-vcpkg.bat
}

./vcpkg.exe install

