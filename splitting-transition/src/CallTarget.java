import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class CallTarget implements Comparable<CallTarget> {
    public int address;
    public HashSet<String> receivers = new HashSet<>();
    public int startID;
    public int endID;
    public CacheType type;

    public CallTarget(int hash, int startID, int endID, String receiver) {
        this.address = hash;
        this.startID = startID;
        this.endID = endID;
        receivers.add(receiver);
    }

    public int intersect(HashSet<String> receivers) {
        Set<String> intersectSet = new HashSet<>(receivers);
        intersectSet.retainAll(this.receivers);
        return intersectSet.size();
    }

    public int union(HashSet<String> receivers) {
        Set<String> unionSet = new HashSet<>(receivers);
        unionSet.addAll(this.receivers);
        return unionSet.size();
    }

    public int getAddress() {
        return this.address;
    }

    public int numberReceivers() {
        return this.receivers.size();
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        } else if (o != null && this.getClass() == o.getClass()) {
            CallTarget that = (CallTarget)o;
            return this.address == that.address;
        } else {
            return false;
        }
    }

    @Override
    public int hashCode() {
        return Objects.hash(new Object[]{this.address});
    }

    @Override
    public int compareTo(CallTarget target) {
        return Integer.compare(this.startID, target.startID);
    }
}
