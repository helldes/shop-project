package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.ProductDao;
import com.springapp.mvc.Entity.Category;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Service.Interface.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by root on 11.03.2015.
 */
@Service
public class ProductServiceImpl extends GenericServiceImpl<Product> implements ProductService {

    @Autowired
    ProductDao productDao;

    @Override
    public List<Product> getProductsByCategory(Category category) {
        return productDao.getProductsByCategory(category);
    }

    @Override
    public List<Product> getProducts() {
        return productDao.getAll();
    }
}
