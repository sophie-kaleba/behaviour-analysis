import java.util.HashSet;
import java.util.Objects;
import java.util.Set;
import java.util.TreeSet;

public class CallTarget implements Comparable<CallTarget> {
    public int address;
    public TreeSet<Integer> ids = new TreeSet<>();
    public HashSet<String> receivers = new HashSet<>();
    public int startID;
    public CacheType type;

    public CallTarget(int hash) {
        this.address = hash;
        this.startID = -1;
    }

    public void addObservation(CallTarget.Call call) {
        this.ids.add(call.id);
        this.startID = ids.first();
        this.receivers.add(call.receiver);
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

    public static class Call {
        public int id;
        public String receiver;

        public Call(int id, String receiver) {
            this.id = id;
            this.receiver = receiver;
        }
    }
}
