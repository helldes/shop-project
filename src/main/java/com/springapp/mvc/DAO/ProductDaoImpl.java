package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.ProductDao;
import com.springapp.mvc.Entity.Category;
import com.springapp.mvc.Entity.Product;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by root on 10.03.2015.
 */
@Repository
public class ProductDaoImpl extends GenericDaoImpl<Product> implements ProductDao {

    @Autowired
    SessionFactory sessionFactory;


    @Override
    public Product getProduct(String NameProduct) {
        String hql = "select product from Product product where product.name = :NameProduct";
        return  (Product) sessionFactory.getCurrentSession().createQuery(hql).setString("NameProduct", NameProduct).uniqueResult();
    }


    @Override
    public List<Product> getProductsByCategory(Category category) {
        return sessionFactory.getCurrentSession().createCriteria(Product.class).add(Restrictions.eq("category", category)).list();
    }

}
