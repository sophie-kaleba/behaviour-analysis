import java.util.Iterator;
import java.util.Objects;
import java.util.TreeSet;

public class CallSite {
    public String sourceSection;
    public String symbol;
    public TreeSet<CallTarget> targets = new TreeSet<>();

    public CallSite(String sourceSection, String symbol) {
        this.sourceSection = sourceSection;
        this.symbol = symbol;
    }

    public void addTarget(CallTarget target, CallTarget.Call call) {
        Iterator<CallTarget> it = this.targets.iterator();
        
        CallTarget currentCT;
        do {
            if (!it.hasNext()) {
                target.addObservation(call);
                this.targets.add(target);
                return;
            }

            currentCT = (CallTarget)it.next();
        } while(!currentCT.equals(target));

        currentCT.addObservation(call);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (o != null && this.getClass() == o.getClass()) {
            CallSite callSite = (CallSite)o;
            return Objects.equals(this.sourceSection, callSite.sourceSection) && Objects.equals(this.symbol, callSite.symbol);
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return Objects.hash(new Object[]{this.sourceSection, this.symbol, this.targets});
    }
}
