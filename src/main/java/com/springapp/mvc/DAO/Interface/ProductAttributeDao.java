package com.springapp.mvc.DAO.Interface;

import com.springapp.mvc.Entity.Attribute;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Entity.ProductAttribute;

/**
 * Created by helldes on 24.03.2015.
 */
public interface ProductAttributeDao extends GenericDao<ProductAttribute>{
    public ProductAttribute getProductAttributeByProduct(Product product);
    public ProductAttribute getProductAttributeByProductAttribute(Attribute attribute, Product product);
}
