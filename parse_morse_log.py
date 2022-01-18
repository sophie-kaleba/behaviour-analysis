import re
import os
import sys

fin = sys.argv[1]
f_out = sys.argv[2]

fout = open(f_out, 'wt')

with open(fin) as fp:
   line = fp.readline()
   while "INFO: " not in line :
       line = fp.readline()
   while line:
       line = re.sub(r'^.*?:', ' ', line)
       fout.write(line)
       line = fp.readline()

fout.close()