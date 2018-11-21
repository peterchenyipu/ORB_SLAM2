#!/usr/bin/env bash
echo "Configuring and building Thirdparty/DBoW2 ..."

cd Thirdparty/DBoW2
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make

cd ../../g2o

echo "Configuring and building Thirdparty/g2o ..."

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make

cd ../../../

echo "Uncompress vocabulary ..."

cd Vocabulary
TxtVocFile=./ORBvoc.txt
TxtVocSize="145250924"
if [ -e $TxtVocFile ]
then
    TXTVOCFILESIZE=$(stat -c%s "$TxtVocFile")
    if [ $TXTVOCFILESIZE -eq $TxtVocSize ]
    then
        echo "Vocabulary(txt) already exists"
    else
        echo "Uncompress vocabulary ..."
        tar -xf ORBvoc.txt.tar.gz
    fi
else
    echo "Uncompress vocabulary ..."
    tar -xf ORBvoc.txt.tar.gz
fi
cd ..

echo "Configuring and building ORB_SLAM2 ..."

mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make

cd ..
BinVocFile=./Vocabulary/ORBvoc.bin
BinVocSize="44365017"
if [ -e $BinVocFile ]
then
    BINVOCFILESIZE=$(stat -c%s "$BinVocFile")
    if [ $BINVOCFILESIZE -eq $BinVocSize ]
    then
        echo "Vocabulary(bin) already exists"
    else
        echo "Recreating binary vocabulary"
        ./tools/bin_vocabulary
    fi
else
    echo "Creating binary vocabulary"
    ./tools/bin_vocabulary
fi
