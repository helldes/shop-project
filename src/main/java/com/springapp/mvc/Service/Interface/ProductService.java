package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Category;
import com.springapp.mvc.Entity.Product;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by root on 11.03.2015.
 */
@Component
public interface ProductService extends GenericService<Product> {
    public List<Product> getProductsByCategory(Category category);
    public List<Product> getProducts();
}
