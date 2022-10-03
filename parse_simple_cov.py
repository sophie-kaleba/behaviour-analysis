import sys

def parse_file(filename):
    f = open(filename, "r")
    lines = [l.strip() for l in f.readlines()]

    main_lines = lines[6:-1]

    stat_sum = [0, 0]
    fn_sum = [0, 0]
    for l in main_lines:
        bench_name, stat_data_str, _, fn_data_str = l.split('|')
        stat_data = [int(x) for x in stat_data_str.strip().split(' ')[1:]]
        fn_data = [int(x) for x in fn_data_str.strip().split(' ')[1:]]

        stat_sum = list(map(sum, zip(stat_sum, stat_data)))
        fn_sum = list(map(sum, zip(fn_sum, fn_data)))

    fo = open(sys.argv[2], "x")  
    fo.write(f"{sys.argv[3]} {stat_sum[0]} {stat_sum[1]} {fn_sum[0]} {fn_sum[1]}")


if __name__ == "__main__":
    parse_file(sys.argv[1])