#!/bin/bash

LIST=("BlogRailsRoutesTwoRoutesTwoRequests" "ERubiRails" "OptCarrot" "LiquidCartParse" "LiquidCartRender" "LiquidMiddleware" "AsciidoctorConvertSmall" "AsciidoctorLoadFileSmall" "DeltaBlue" "Richards" "Json" "Bounce" "List" "Mandelbrot" "NBody" "Permute" "Queens" "Sieve" "Storage" "Towers")
SLIST=("NBody" "Permute" "Queens" "Sieve" "Storage" "Towers")

for b in ${SLIST[@]}; do
	make benchmark_name=$b iterations="1" inner_iterations="1" all
	sleep 2m
done

make benchmark_name="CD" iterations="1" inner_iterations="250" all
