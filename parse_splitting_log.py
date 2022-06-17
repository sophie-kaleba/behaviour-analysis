import re
import sys

fin = sys.argv[1]
f_out = sys.argv[2]
split_targets = "truffle_split_targets_"+f_out

fout = open(f_out, 'wt')
split_fout = open(split_targets, 'wt')

# current delimiters
        # private static final String D_FORMAT = "%n%-40s: %10d";
        # private static final String D_LONG_FORMAT = "%n%-120s: %10d";
        # private static final String P_FORMAT = "%n%-40s: %9.2f%%";
        # private static final String DELIMITER_FORMAT = "%n--- %s";

def parse_splitting_statistics() :
    fp.readline() #get rid of the header
    for i in range(0, 10):
        fp.readline()

def parse_targets():
    line = fp.readline() #get rid of the header
    while "--- NODES" not in line:
        call_type = "Method"
        split_line = line.split(": ")
        line = fp.readline()
        if "block " in split_line[0]:
            call_type = "Block"
        split_fout.write(split_line[0].strip()+","+split_line[1].strip()+","+call_type+"\n")

def parse_nodes():
    fp.readline() #get rid of the header


with open(fin) as fp:
    while True:
        line = fp.readline()
        if "[engine] Splitting Statistics" in line:
            parse_splitting_statistics()
        if "--- SPLIT TARGETS" in line:
            parse_targets()
            break
        if "--- NODES" in line:
            parse_nodes()
            break
    fout.close()
    split_fout.close()
