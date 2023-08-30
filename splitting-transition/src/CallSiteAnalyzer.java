import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

public class CallSiteAnalyzer {
    public static List<Benchmark> benchmarks = new ArrayList<>();
    public static List<String[]> dataLines = new ArrayList<>();

    public CallSiteAnalyzer() {
    }

    public static void main(String[] args) throws IOException {
        BufferedReader csvReader = new BufferedReader(new FileReader(args[0]));
        csvReader.readLine();

        String row;
        while ((row = csvReader.readLine()) != null) {
            String[] data = row.split(",");
            parseRow(data);
        }
        analyzeRun();
        printToCsv(args[1]);
        csvReader.close();
    }

    public static void analyzeRun() {
        for (Benchmark benchmark: benchmarks) {
            for (CallSite site: benchmark.sites) {

                for (CallTarget ct : site.getTargets()) {
                    setTargetStatus(ct);
                }

                Object[] targets = site.targets.toArray();
                // The call-site has been split so there is more than 1 target
                for (int i = 1; i < targets.length; ++i) {
                    CallTarget prev_ct = (CallTarget) targets[i - 1];
                    CallTarget ct = (CallTarget) targets[i];
                    analyzeTransition(prev_ct, ct, site, benchmark);
                }
            }
        }
    }

    private static void analyzeTransition(CallTarget prev_ct, CallTarget ct, CallSite site, Benchmark benchmark) {
        int union = prev_ct.union(ct.receivers);
        int intersect = prev_ct.intersect(ct.receivers);
        dataLines.add(new String[]{
                site.sourceSection,
                site.symbol,
                Integer.toString(prev_ct.startID),
                Integer.toString(ct.endID),
                prev_ct.type.toString(),
                ct.type.toString(),
                Integer.toString(prev_ct.numberReceivers()),
                Integer.toString(ct.numberReceivers()),
                Integer.toString(union),
                Integer.toString(intersect),
                benchmark.name});
    }

    public static void setTargetStatus(CallTarget ct) {
        if (ct.receivers.size() == 1) {
            ct.type = CacheType.MONOMORPHIC;
        } else if (ct.receivers.size() > 1 && ct.receivers.size() <= 8) {
            ct.type = CacheType.POLYMORPHIC;
        } else {
            ct.type = CacheType.MEGAMORPHIC;
        }
    }

    public static void parseRow(String[] row) {
        String benchmark = row[0];
        String sourceSection = row[1];
        String symbol = row[2];
        int targetAddress = Integer.parseInt(row[3]);
        int startID = Integer.parseInt(row[4]);
        int endID = Integer.parseInt(row[5]);
        String receiver = row[6];

        Benchmark currentBenchmark = new Benchmark(benchmark);
        CallSite currentSite = new CallSite(sourceSection, symbol);
        CallTarget currentTarget = new CallTarget(targetAddress, startID, endID, receiver);
        if (!benchmarks.contains(currentBenchmark)) {
            benchmarks.add(currentBenchmark);
        }
        benchmarks.get(benchmarks.indexOf(currentBenchmark)).addSite(currentSite, currentTarget);
    }

    public static void printToCsv(String filename) throws IOException {
        File csvOutputFile = new File(filename);

        try (PrintWriter pw = new PrintWriter(csvOutputFile)) {
            dataLines.stream().map(CallSiteAnalyzer::convertToCSV).forEach(pw::println);
        }
        csvOutputFile.exists();
    }

    public static String convertToCSV(String[] data) {
        return Stream.of(data).collect(Collectors.joining(","));
    }
}
