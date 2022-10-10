import sys

def main(argv):
    f_tables = argv[1]

    f_out = argv[2]
    fout = open(f_out, 'wt')

    f_new_headers = open("./header.tex", "r")
    new_headers = f_new_headers.read().split("\n\n\n")
    current_header = 0

    with open(f_tables) as fp:
        while True:
            line = fp.readline()
            if not line:
                break

            if ("\\begin{tabular" in line) : #that's a header we want to process
                top_rule = fp.readline()
                old_header = fp.readline()
                mid_rule = fp.readline()

                if ("CallerPolymorphism" in new_headers[current_header]):
                    tab_header = line.split("}{")
                    fout.write(tab_header[0]+"}{\paperheight}{"+tab_header[1]+top_rule+old_header+mid_rule)
                else:
                    fout.write(new_headers[current_header]+"\n")
                current_header += 1
            elif ("\\bottomrule" in line) :
                fout.write("\hline")
            else:
                fout.write(line)

        fout.close()
        f_new_headers.close()

if __name__ == "__main__":
    main(sys.argv)
