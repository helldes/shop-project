package com.springapp.mvc.Util;

import com.springapp.mvc.Entity.Product;

import java.util.Comparator;
import java.util.Map;

/**
 * Created by helldes on 07.04.2015.
 */
public class MapValueComparator implements Comparator<Product> {

    Map<Product, Integer> base;
    public MapValueComparator(Map<Product, Integer> base) {
        this.base = base;
    }

    @Override
    public int compare(Product o1, Product o2) {
        if (base.get(o1) >= base.get(o2)) {
            return -1;
        } else {
            return 1;
        } // returning 0 would merge keys

    }
}