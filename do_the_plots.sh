#!/bin/bash
FOLDER="results/07-06-22_16-08-09"
ROOT="/home/sopi/Documents/Side_projects/behaviour-analysis"

POLY=("AsciidoctorConvertSmall" 
	  "AsciidoctorLoadFileSmall"
      "BlogRailsRoutesTwoRoutesTwoRequests"
      "Bounce"
      "DeltaBlue"
      "ERubiRails"
      "Havlak"
      "LeeBench"
      "NeuralNet"
      "OptCarrot"
      "PsychLoad"
      "SinatraHello"
)

containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

tar_file () {
    echo "COMPRESSING $1"
    tar --remove-files -I lz4 -cf "$1".tar.lz4 "$1"
}

untar_file () {
    echo "EXTRACTING $1 TO $2"
    tar -I lz4 -xf "$1"
}

for f in `ls ${ROOT}/${FOLDER}`; do
	BENCH_NAME=${f%%_*}
    
    containsElement $BENCH_NAME "${POLY[@]}"
    if [ $? -ne 1 ];
    then
        cd ${ROOT}/${FOLDER}/$f
	    echo "ENTERING ${ROOT}/${FOLDER}/$f"
	    untar_file ./parsed_${BENCH_NAME}.mylog.tar.lz4

        cd ${ROOT}
	    Rscript ${ROOT}/generate_plots.Rnw ${BENCH_NAME} ${FOLDER} ${ROOT}/${FOLDER}/$f/parsed_${BENCH_NAME}.mylog

        cd ${ROOT}/${FOLDER}/$f
	    tar_file parsed_${BENCH_NAME}.mylog
	    cd ${ROOT}
    fi
done