# Copyright Daniel Buckmaster (@crabmusket)
# https://github.com/crabmusket/nginx-12fa/blob/master/subenv

#!/bin/bash

infile=$1
outfile=$2
workingfile=${infile}.temp

if [ ! -e $infile ]; then
  exit 0
fi

cp $infile $workingfile
while read -r line; do
  # Split environment var into variable name and value
  var=$(cut -d '=' -f 1 <<< "$line")
  val=$(cut -d '=' -f 2- <<< "$line")
  vale=$(sed 's/\//\\\//g' <<< "$val")
  # Replace ${var} at the start of a line
  sed -i 's/^\${'"$var"'}/'"$vale"'/g' $workingfile
  # Replace x${var} unless x is a backslash
  sed -i 's/\([^\\]\)\${'"$var"'}/\1'"$vale"'/g' $workingfile
done <<< "$(env)"

# Replace ${...} with empty string since it wasn't in the env
sed -i 's/^\${\([^}]*\)}//g' $workingfile
sed -i 's/\([^\\]\)\${\([^}]*\)}/\1/g' $workingfile

# Replace \${...} with ${...}
sed -i 's/\\\${\([^}]*\)}/\${\1}/g' $workingfile

cp $workingfile $outfile
rm $workingfile
