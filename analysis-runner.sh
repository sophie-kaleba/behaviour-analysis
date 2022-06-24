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
	  #"CD" see bottom -> Should be analyzed on the big boy
	  "DeltaBlue" 
	  "FannkuchRedux"
	  #"Havlak" see bottom -> Should be analyzed on the big boy
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

YJIT=(#"HexaPdfSmall" -> Should be analyzed on the big boy
	  "LiquidCartParse" 
	  "LiquidCartRender" 
	  "LiquidMiddleware"
	  "LiquidParseAll"
	  "LiquidRenderBibs"
	  "MailBench"
	  #"RubykonBench" Too big
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
		#"ChunkyOperationsCompose" -> Should be analyzed on the big boy
		"ChunkyOperationsReplace"
)

PSD=("PsdColorCmykToRgb"
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
	 #"PsdRendererBlenderCompose" -> Should be analyzed on the big boy
	 #"PsdRendererClippingmaskApply" -> Should be analyzed on the big boy
	 #"PsdRendererMaskApply" -> Should be analyzed on the big boy
	 "PsdUtilClamp"
	 "PsdUtilPad2"
	 "PsdUtilPad4"
)

# FOLDER=$(date "+%d-%m-%y_%H-%M-%S")
# mkdir results/$FOLDER
FOLDER="07-06-22_16-08-09"

# for b in ${TRUBY[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

# for b in ${AWFY[@]}; do
# 	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
# 	wait $!
# done

for b in ${YJIT[@]}; do
	make benchmark_name=$b iterations="1" inner_iterations="1" FOLDER=$FOLDER all
	wait $!
done

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

#must have more memory
# make benchmark_name="Havlak" iterations="1" inner_iterations="1" FLAGS="--splitting --vm.Xss6m" FOLDER=$FOLDER all

# is special regarding the number of inner iterations
# make benchmark_name="CD" iterations="1" inner_iterations="250" FOLDER=$FOLDER all
