import re
import sys

fin = sys.argv[1]
f_out = sys.argv[2]
split_summary = "split_"+f_out

fout = open(f_out, 'wt')
split_fout = open(split_summary, 'wt')


with open(fin) as fp:
   line = fp.readline()
   while "INFO: " not in line : #ignore extraneous log at the beggining of the file
       line = fp.readline()
   while "INFO: " in line : #info is contained in line
       line = re.sub(r'^.*?:', ' ', line)
       fout.write(line)
       line = fp.readline()
   if "Splitting Statistics" in line : #starting the splitting summary 
       while line:
        split_fout.write(line)
        line = fp.readline()

fout.close()
split_fout.close()