all: run parse

SYSTEM_RUBY = "/home/sopi/.rbenv/versions/3.0.0/bin/ruby"
JT="/home/sopi/Documents/Side_projects/truffleruby/tool/jt.rb"
RAW_INPUT = raw_${benchmark_name}.log
PARSED_INPUT = parsed_${benchmark_name}
SPLIT_SUMMARY = split_$(PARSED_INPUT)
FLAGS = --splitting
MODE = ""
FOLDER = ""

run:
	echo "[RUNNING ${benchmark_name} ...]"
	$(SYSTEM_RUBY) $(JT) --use jvm-ce ruby --vm.Dpolyglot.log.file=/dev/null $(FLAGS) --coverage --coverage.Output=lcov --coverage.OutputFile=./coverage/${benchmark_name}.info  /home/sopi/Documents/Side_projects/truffleruby/bench/phase/harness-behaviour.rb ${benchmark_name} ${iterations} ${inner_iterations} 
	echo "[RUNNING... DONE]"

parse:
	echo "[REPORT COVERAGE...]"
	lcov --summary ./coverage/${benchmark_name}.info >> ./reports/${benchmark_name}_cov.txt 2>&1
	lcov --list ./coverage/${benchmark_name}.info >> ./reports/${benchmark_name}_cov.txt 2>&1
	python3 parsing_sophie.py ./reports/${benchmark_name}_cov.txt ./reports/parsed_reports/global/${benchmark_name}_global.csv ./reports/parsed_reports/detailed/${benchmark_name}_detailed.csv  
	echo "[REPORT COVERAGE... DONE]"