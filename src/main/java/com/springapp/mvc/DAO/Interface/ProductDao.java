package com.springapp.mvc.DAO.Interface;

import com.springapp.mvc.Entity.Category;
import com.springapp.mvc.Entity.Product;

import java.util.List;

/**
 * Created by root on 10.03.2015.
 */
public interface ProductDao extends GenericDao<Product> {
    public Product getProduct(String NameProduct);
    public List<Product> getProductsByCategory(Category category);
}


