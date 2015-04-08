package com.springapp.mvc.Util;

import com.springapp.mvc.Entity.Product;

import java.util.Comparator;

/**
 * Created by helldes on 06.04.2015.
 */
public class ComparatorSortPriceZA implements Comparator<Product> {
    @Override
    public int compare(Product o1, Product o2) {
        if (o1.getPrice() < o2.getPrice()) return 1;
        if (o1.getPrice() == o2.getPrice()) return 0;
        return -1;
    }
}
