import math
import sys


def get_groups(main_lines):
    groups = []
    cur_group = []
    for l in main_lines:
        if l == '':
            groups.append(cur_group)
            cur_group = []
            continue
        cur_group.append(l)
    groups.append(cur_group[:-2])
    return groups


def get_start_str(start_lines):
    output_data = []

    output_data.append(start_lines[0][start_lines[0].rfind('/') + 1:-5])

    lines_line = start_lines[2]
    lines_line_split = lines_line[13:-7].split(" ")
    output_data += [lines_line_split[3], lines_line_split[0][:-1]]

    func_line = start_lines[3]
    func_line_split = func_line[13:-11].split(" ")
    output_data += [func_line_split[3], func_line_split[0][:-1]]

    return ' '.join(output_data)


def parse_bench_group(group):
    def parse_bench_line(l):
        return l[l.index('|') + 1:- (len(l) - l.rindex('|'))].replace('|', ' ').replace('%', '').split()

    g_data = [group[0][1:-1]]
    sum_line_covered, sum_line_full = 0, 0
    sum_func_covered, sum_func_full = 0, 0
    for l in group[1:]:
        bench_line = parse_bench_line(l)
        sum_line_full += int(bench_line[1])
        sum_line_covered += math.floor(int(bench_line[1]) * float(bench_line[0]) / 100)
        sum_func_full += int(bench_line[3])
        sum_func_covered += math.floor(int(bench_line[3]) * float(bench_line[2]) / 100)

    g_data += [str(x) for x in [sum_line_covered, sum_line_full, sum_func_covered, sum_func_full]]
    return ' '.join(g_data)


def main(argv):
    start_idx = 0
    f = open(argv[1], "r")
    lines = [l.strip() for l in f.readlines()]

    for l in lines:
        # sometimes the header is longer
        start_idx +=1
        if (l.startswith('======================')):
            break
    
    main_lines = lines[start_idx:]
    start_str = get_start_str(lines[:4])

    groups = get_groups(main_lines)
    g_str_list = [parse_bench_group(g) for g in groups]

    f = open(argv[2], "x")
    f.write(start_str)

    f = open(argv[3], "x")
    f.write('\n'.join(g_str_list))


if __name__ == "__main__":
    main(sys.argv)
