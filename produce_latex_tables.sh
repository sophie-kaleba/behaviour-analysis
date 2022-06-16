#!/bin/bash
FOLDER="./results/07-06-22_16-08-09"
ROOT="/home/sopi/Documents/Side_projects/behaviour-analysis"
ALL_FILES_FOLDER=$FOLDER/all

for f in `ls ${FOLDER}`; do
	BENCH_NAME=${f%%_*}
	cd ${FOLDER}/$f
	echo "ENTERING ${FOLDER}/$f"
	tar -I lz4 -xf ${FOLDER}/$f/parsed_${BENCH_NAME}.mylog.tar.lz4
	Rscript ${ROOT}/generate_light_csv.Rnw ${BENCH_NAME} ${FOLDER} ${FOLDER}/$f/parsed_${BENCH_NAME}.mylog
	tar --remove-files -I lz4 -cf ${FOLDER}/$f/parsed_${BENCH_NAME}.mylog.tar.lz4 ${FOLDER}/$f/parsed_${BENCH_NAME}.mylog
	cd ..
done

for fi in `ls ${ALL_FILES_FOLDER}`; do 
	Rscript knit_merge.R merge_tables.Rnw tables.tex ${ALL_FILES_FOLDER}
done
