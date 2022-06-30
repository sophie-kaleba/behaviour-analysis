#!/bin/bash

TRUBY=("Acid"
	  "AsciidoctorConvertSmall" 
	  "AsciidoctorLoadFileSmall"
	  "ImageDemoConv"
	  "ImageDemoSobel"
	  "OptCarrot"
	  "MatrixMultiply"
	  "Pidigits"
	  "RedBlack"
	  "SinatraHello"
)

AWFY=("BinaryTrees"
	  "Bounce"
	  #"CD" see bottom
	  "DeltaBlue" 
	  "FannkuchRedux"
	  #"Havlak" see bottom
	  "Json"
	  "LeeBench"
	  "List"
	  "Mandelbrot"
	  "NBody"
	  "NeuralNet"
	  "Permute"
	  "PsychLoad"
	  "Queens"
	  "Richards"
	  "Sieve"
	  "SpectralNorm"
	  "Storage"
	  "Towers"
)

YJIT=("HexaPdfSmall"
	  "LiquidCartParse" 
	  "LiquidCartRender" 
	  "LiquidMiddleware"
	  "LiquidParseAll"
	  "LiquidRenderBibs"
	  "MailBench"
	  "RubykonBench"
)

RAILS=("BlogRailsRoutesTwoRoutesTwoRequests"
	   "ERubiRails" 
)

 CHUNKY=("ChunkyCanvasResamplingBilinear"
	    "ChunkyCanvasResamplingNearestNeighbor"
		"ChunkyCanvasResamplingSteps"
		"ChunkyCanvasResamplingStepsResidues"
		"ChunkyColorA"
		"ChunkyColorB"
		"ChunkyColorComposeQuick"
		"ChunkyColorG"
		"ChunkyColorR"
		"ChunkyDecodePngImagePass"
		"ChunkyOperationsCompose"
		"ChunkyOperationsReplace"
)

PSD=(
	"PsdColorCmykToRgb"
	 "PsdComposeColorBurn"
	 "PsdComposeColorDodge"
	 "PsdComposeDarken"
	 "PsdComposeDifference"
	 "PsdComposeExclusion"
	 "PsdComposeHardLight"
	 "PsdComposeHardMix"
	 "PsdComposeLighten"
	 "PsdComposeLinearBurn"
	 "PsdComposeLinearDodge"
	 "PsdComposeLinearLight"
	 "PsdComposeMultiply"
	 "PsdComposeNormal"
	 "PsdComposeOverlay"
	 "PsdComposePinLight"
	 "PsdComposeScreen"
	 "PsdComposeSoftLight"
	 "PsdComposeVividLight"
	 "PsdImageformatLayerrawParseRaw"
	 "PsdImageformatRleDecodeRleChannel"
	 "PsdImagemodeCmykCombineCmykChannel"
	 "PsdImagemodeGreyscaleCombineGreyscaleChannel"
	 "PsdImagemodeRgbCombineRgbChannel"
	 "PsdRendererBlenderCompose"
	 "PsdRendererClippingmaskApply"
	 "PsdRendererMaskApply"
	 "PsdUtilClamp"
	 "PsdUtilPad2"
	 "PsdUtilPad4"
)

BIG=("SinatraHello"
	"MailBench"
	"ERubiRails"
	"BlogRailsRoutesTwoRoutesTwoRequests"
	"PsdImagemodeGreyscaleCombineGreyscaleChannel"
	"ChunkyCanvasResamplingNearestNeighbor"
)

# for b in ${TRUBY[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

# for b in ${AWFY[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

# for b in ${YJIT[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

# for b in ${RAILS[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

# for b in ${CHUNKY[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

# for b in ${PSD[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

# for b in ${BIG[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER parse
# 	wait $!
# done

#must have more memory
#make benchmark_name="Havlak" iterations="1" inner_iterations="1" FLAGS="--vm.Xss6m" FOLDER=$FOLDER all

# is special regarding the number of inner iterations
# make benchmark_name="CD" iterations="1" inner_iterations="250" FOLDER=$FOLDER all

Rscript knit.R generate_cov_table.Rnw metrics_tables.tex 
