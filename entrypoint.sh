#!/bin/ba

# cd `dirname $0`
# git clone --recursive https://github.com/tianocore/edk2.git ./src/edk2 \
#  && (cd ./src/edk2 && git checkout --recurse-submodules 38c8be123aced4cc8ad5c7e0da9121a181b94251) \
#  && make -C ./src/edk2/BaseTools/Source/C

cd `dirname $0`
sh -x osbook.sh
cd $HOME/src
git clone --recursive https://github.com/tianocore/edk2.git edk2

cd edk2
git config --global --add safe.directory $HOME/src/edk2
git config --global --add safe.directory $HOME/src/edk2/ArmPkg/Library/ArmSoftFloatLib/berkeley-softfloat-3
git config --global --add safe.directory $HOME/src/edk2/BaseTools/Source/C/BrotliCompress/brotli
git config --global --add safe.directory $HOME/src/edk2/CryptoPkg/Library/OpensslLib/openssl
git config --global --add safe.directory $HOME/src/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli
git submodule update --init
git config --global --add safe.directory $HOME/src/edk2/MdeModulePkg/Universal/RegularExpressionDxe/oniguruma
git config --global --add safe.directory $HOME/src/edk2/RedfishPkg/Library/JsonLib/jansson
git config --global --add safe.directory $HOME/src/edk2/UnitTestFrameworkPkg/Library/CmockaLib/cmocka
git checkout --recurse-submodules 38c8be123aced4cc8ad5c7e0da9121a181b94251
make -C ./BaseTools/Source/C

ln -s $HOME/src/MikanLoaderPkg ./

shopt -s expand_aliases
source ./edksetup.sh
sed -i '/ACTIVE_PLATFORM/ s:= .*$:= MikanLoaderPkg/MikanLoaderPkg.dsc:' Conf/target.txt
sed -i '/TARGET_ARCH/ s:= .*$:= X64:' Conf/target.txt
sed -i '/TOOL_CHAIN_TAG/ s:= .*$:= CLANG38:' Conf/target.txt
sed -i '/CLANG38/ s/-flto//' Conf/tools_def.txt
build
