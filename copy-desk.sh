# Usage:
# ./copy-desk.sh <ship_name>

mkdir -p "../$1/lift" && cp -R -f desk/* ../$1/lift && echo "~$1" > ../$1/lift/desk.ship
