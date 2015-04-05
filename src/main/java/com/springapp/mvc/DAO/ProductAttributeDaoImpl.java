package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.ProductAttributeDao;
import com.springapp.mvc.Entity.Attribute;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Entity.ProductAttribute;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Repository
public class ProductAttributeDaoImpl extends GenericDaoImpl<ProductAttribute>implements ProductAttributeDao {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public List<ProductAttribute> getProductAttributeByProduct(Product product) {
        return sessionFactory.getCurrentSession().createCriteria(ProductAttribute.class).add(Restrictions.eq("pk.product", product)).list();
    }

    @Override
    public ProductAttribute getProductAttributeByProductAttribute(Attribute attribute, Product product) {
        return (ProductAttribute)sessionFactory.getCurrentSession().createCriteria(ProductAttribute.class)
                .add(Restrictions.eq("pk.attribute", attribute))
                .add(Restrictions.eq("pk.product", product))
                .uniqueResult();
    }
}
