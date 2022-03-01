import re
import sys

fin = sys.argv[1]
f_out = sys.argv[2]
split_summary = "split_"+f_out

fout = open(f_out, 'wt')
split_fout = open(split_summary, 'wt')


with open(fin) as fp:
    while True:
        line = fp.readline()
        if ("INFO: " not in line) and ("Splitting Statistics" not in line) : #ignore extraneous log at the beggining of the file
            line = fp.readline()
        if "INFO: " in line : #info is contained in line
            line = re.sub(r'^.*?:', ' ', line)
            fout.write(line)
            #line = fp.readline()
        if "Splitting Statistics" in line : #starting the splitting summary 
            while True:
                split_fout.write(line)
                line = fp.readline()
                if not line:
                    break
        if not line:
                    break

    fout.close()
    split_fout.close()
