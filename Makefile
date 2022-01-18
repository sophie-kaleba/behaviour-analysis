all: run parse knitr pdf reorganize clean

SYSTEM_RUBY = "/home/sopi/.rbenv/versions/2.7.3/bin/ruby"
JT="/home/sopi/Documents/Side_projects/truffleruby/tool/jt.rb"
RAW_INPUT = raw_${benchmark_name}.log
PARSED_INPUT = parsed_${benchmark_name}

run:
	$(SYSTEM_RUBY) $(JT) --use jvm-ce ruby --vm.Dpolyglot.log.file="raw_${benchmark_name}.log"  /home/sopi/Documents/Side_projects/truffleruby/bench/phase/harness-behaviour.rb ${benchmark_name} ${iterations} ${inner_iterations} 

parse:
	python3 parse_morse_log.py $(RAW_INPUT) $(PARSED_INPUT).mylog 

knitr:
	Rscript knit.R evaluation_with_plots.Rnw gen-eval.tex $(PARSED_INPUT).mylog ${benchmark_name} ${iterations} ${inner_iterations}  
	cp paper.tex $(PARSED_INPUT).tex

reorganize:
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
