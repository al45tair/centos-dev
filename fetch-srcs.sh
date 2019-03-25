function progress() {
    message=$1
    frequency=$2
    echo -n "$message... -"
    ch='-'
    every=0
    while read line
    do
	every=$((every + 1))
	if [ $every -eq $frequency ]; then
	    every=0
	    case $ch in
		'-') ch='\';;
		'\') ch='|';;
		'|') ch='/';;
		'/') ch='-';;
	    esac
	    echo -ne "\r$message... $ch"
	fi
    done
    echo -e "\r$message... done"
}

# Fetch GCC
cd /src
gccver=`echo $GCCVER | tr . _`
svn co svn://gcc.gnu.org/svn/gcc/tags/gcc_${gccver}_release gcc | progress "Fetching GCC" 100
cd gcc
./contrib/download_prerequisites

# Fetch Python
cd /src
curl -L -O https://www.python.org/ftp/python/$PYTHONVER/Python-$PYTHONVER.tgz
tar xzf Python-$PYTHONVER.tgz

# Fetch Cmake
cd /src
curl -L -O https://github.com/Kitware/CMake/releases/download/v$CMAKEVER/cmake-$CMAKEVER.tar.gz
tar xzf cmake-$CMAKEVER.tar.gz

# Fetch LLVM
cd /src
branch=`echo release/$LLVMVER | sed 's/\([0-9][0-9]*\)\.[0-9][0-9]*\.[0-9][0-9]*/\1.x/g'`
git clone -n https://github.com/llvm/llvm-project.git
cd llvm-project
git checkout llvmorg-$LLVMVER
