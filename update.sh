#!/bin/bash

VERSION=$1
SHA=$2

eval "cat <<EOF
$(<comply.rb.template)
EOF
" > comply.rb

git add comply.rb
git commit -m "updated to version $VERSION"
git push
