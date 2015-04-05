package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Attribute;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Entity.ProductAttribute;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Component
public interface ProductAttributeService extends GenericService<ProductAttribute> {
    public List<ProductAttribute> getProductAttributeByProduct(Product product);
    public ProductAttribute getProductAttributeByProductAttribute(Attribute attribute, Product product);
}
