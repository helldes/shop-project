package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.ProductAttributeDao;
import com.springapp.mvc.Entity.Attribute;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Entity.ProductAttribute;
import com.springapp.mvc.Service.Interface.ProductAttributeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Service
public class ProductAttributeServiceImpl extends GenericServiceImpl<ProductAttribute> implements ProductAttributeService {

    @Autowired
    ProductAttributeDao productAttributeDao;

    @Override
    public List<ProductAttribute> getProductAttributeByProduct(Product product) {
        return null;
    }

    @Override
    public ProductAttribute getProductAttributeByProductAttribute(Attribute attribute, Product product) {
       return productAttributeDao.getProductAttributeByProductAttribute(attribute, product);
    }
}
