import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
import java.util.TreeSet;

public class CallSite {
    public String sourceSection;
    public String symbol;
    public int siteID;
    public ArrayList<CallTarget> targets = new ArrayList<>();

    public CallSite(String sourceSection, String symbol, int ID) {
        this.sourceSection = sourceSection;
        this.symbol = symbol;
        this.siteID = ID;
    }

    public ArrayList<CallTarget> getTargets() {
        return this.targets;
    }

    public void addTarget(CallTarget target) {
        boolean found = false;
        Iterator<CallTarget> it = this.targets.iterator();

        while (it.hasNext()) {
            CallTarget currentCallTarget = it.next();
            if (currentCallTarget.address == target.address)
            {
                found = true;
                currentCallTarget.receivers.addAll(target.receivers);
            }
        }

        if (!found) targets.add(target);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (o != null && this.getClass() == o.getClass()) {
            CallSite callSite = (CallSite)o;
            return Objects.equals(this.sourceSection, callSite.sourceSection) && Objects.equals(this.symbol, callSite.symbol) && Objects.equals(this.siteID, callSite.siteID);
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return Objects.hash(new Object[]{this.sourceSection, this.symbol, this.siteID, this.targets});
    }
}
