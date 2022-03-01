all: run parse knitr pdf reorganize clean

SYSTEM_RUBY = "/home/sopi/.rbenv/versions/3.0.0/bin/ruby"
JT="/home/sopi/Documents/Side_projects/truffleruby/tool/jt.rb"
RAW_INPUT = raw_${benchmark_name}.log
PARSED_INPUT = parsed_${benchmark_name}
SPLIT_SUMMARY = split_$(PARSED_INPUT)
FLAGS = --splitting
MODE = ""

run:
	echo "[RUNNING ${benchmark_name} ...]"
	$(SYSTEM_RUBY) $(JT) --use jvm-ce ruby --vm.Dpolyglot.log.file="raw_${benchmark_name}.log"  $(FLAGS)  /home/sopi/Documents/Side_projects/truffleruby/bench/phase/harness-behaviour.rb ${benchmark_name} ${iterations} ${inner_iterations} 
	echo "[RUNNING... DONE]"

parse:
	echo "[PARSING ...]"
	python3 parse_morse_log.py $(RAW_INPUT) $(PARSED_INPUT).mylog 
	echo "[PARSING... DONE]"
	
knitr:
	echo "[GENERATING TEX FILE ...]"
	Rscript knit.R $(MODE)evaluation_with_plots.Rnw gen-eval.tex $(PARSED_INPUT).mylog ${benchmark_name} ${iterations} ${inner_iterations}  
	cp $(MODE)paper.tex $(PARSED_INPUT).tex
	echo "[GENERATING TEX FILE... DONE]"

reorganize:
	mv $(SPLIT_SUMMARY).mylog latest/$(SPLIT_SUMMARY).mylog
	mv $(PARSED_INPUT).tex latest/$(PARSED_INPUT).tex
	mv $(RAW_INPUT) latest/$(RAW_INPUT)
	mv $(PARSED_INPUT).mylog latest/$(PARSED_INPUT).mylog
	mv $(PARSED_INPUT).pdf latest/$(PARSED_INPUT).pdf
	mv gen-eval.tex latest/gen-eval.tex

clean:
	rm *.aux
	rm *.out
	rm *.log

pdf:
	pdflatex $(PARSED_INPUT).tex
	pdflatex $(PARSED_INPUT).tex
