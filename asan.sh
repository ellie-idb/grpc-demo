#!/bin/bash

dub build -c=asan --compiler=ldc2 -b=release-debug

if [[ $? -eq 0 ]]; then
	ASAN_SYMBOLIZER_PATH=`which llvm-symbolizer` ./hello-world-server
fi
