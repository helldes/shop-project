package com.springapp.mvc.Util;

import java.util.Comparator;
import java.util.Map;

/**
 * Created by helldes on 06.04.2015.
 */
public class ComparatorSortMap implements Comparator<Map.Entry> {

    @Override
    public int compare(Map.Entry o1, Map.Entry o2) {
        Comparable c1 = (Comparable) o1.getValue();
        Comparable c2 = (Comparable) o2.getValue();
        return c2.compareTo(c1);
    }
}
