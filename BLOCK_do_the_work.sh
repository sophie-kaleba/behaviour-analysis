#!/bin/sh
FOLDER="results/07-06-22_16-08-09/CLOSURES"
ROOT="/home/sopi/Documents/Side_projects/behaviour-analysis"
ALL_FILES_FOLDER=${ROOT}/$FOLDER/all

tar_file () {
    echo "COMPRESSING $1"
    tar --remove-files -I lz4 -cf "$1".tar.lz4 "$1"
}

untar_file () {
    echo "EXTRACTING $1 TO $2"
    tar -I lz4 -xf "$1"
}

# for f in `ls ${ROOT}/${FOLDER}`; do
# 	BENCH_NAME=${f%%_*}
# 	cd ${ROOT}/${FOLDER}/$f
# 	echo "ENTERING ${ROOT}/${FOLDER}/$f"
# 	untar_file ./parsed_${BENCH_NAME}.mylog.tar.lz4  .

# 	cd ${ROOT}
#     Rscript ${ROOT}/BLOCK_generate_light_csv.Rnw ${BENCH_NAME} ${FOLDER} ${ROOT}/${FOLDER}/$f/parsed_${BENCH_NAME}.mylog

# 	cd ${ROOT}/${FOLDER}/$f
# 	tar_file parsed_${BENCH_NAME}.mylog
# 	cd ${ROOT}
# done


Rscript knit_merge.R BLOCK_merge_tables.Rnw block_tables.tex ${ROOT}/${FOLDER}/results