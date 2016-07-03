#!/bin/sh

set -ex

export BUILD="$PWD/vendor/libgit2/build"
export PCFILE="$BUILD/libgit2.pc"

FLAGS=$(pkg-config --static --libs $PCFILE) || exit 1
if [[ "$OSTYPE" = "msys" &&  !("-lws2_32" == *"${FLAGS}"*) ]]; then
  FLAGS="${FLAGS} -lws2_32"
fi
export CGO_LDFLAGS="$BUILD/libgit2.a -L$BUILD ${FLAGS}"
export CGO_CFLAGS="-I$PWD/vendor/libgit2/include"

$@
