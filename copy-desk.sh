# Usage:
# ./copy-desk.sh <ship_name>

mkdir -p "../$1/lift" && cp -R -f desk/* ../$1/lift && echo "~$1" > ../$1/lift/desk.ship


# Pulling relevant files from base
cp -R -f ../$1/base/mar/noun.hoon ../$1/lift/mar/noun.hoon
cp -R -f ../$1/base/mar/kelvin.hoon ../$1/lift/mar/kelvin.hoon

 # Pulling relevant files from garden
cp -R -f ../$1/garden/lib/docket.hoon ../$1/lift/lib/docket.hoon
cp -R -f ../$1/garden/sur/docket.hoon ../$1/lift/sur/docket.hoon
cp -R -f ../$1/garden/sur/treaty.hoon ../$1/lift/sur/treaty.hoon

