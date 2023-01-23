#!/bin/sh
set -ex

case $1 in
   debug)
       echo versions
       go version
       dlv version

       f=main.test

       echo "compiling into $f"
       go test -c -gcflags all="-N -l" github.com/zored/go_debug_playground -o "$f"

       echo "debugging from $f"
       dlv exec \
         --headless \
         --listen=:2345 \
         --api-version=2 \
         --accept-multiclient \
         --check-go-version=false \
         "$f" \
         -- \
         -test.timeout=9999h -test.count=1
   ;;
   *)
      exit 1
   ;;
esac