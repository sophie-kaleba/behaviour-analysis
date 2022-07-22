import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class Benchmark {
    public List<CallSite> sites = new ArrayList();
    public String name;

    public Benchmark(String name) {
        this.name = name;
    }

    public void addSite(CallSite currentSite, CallTarget currentTarget) {
        if (!this.sites.contains(currentSite)) {
            this.sites.add(currentSite);
        }

        this.sites.get(this.sites.indexOf(currentSite)).addTarget(currentTarget);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (o != null && this.getClass() == o.getClass()) {
            Benchmark benchmark = (Benchmark)o;
            return Objects.equals(this.name, benchmark.name);
        } else {
            return false;
        }
    }

    public int hashCode() {
        return Objects.hash(new Object[]{this.name});
    }
}
