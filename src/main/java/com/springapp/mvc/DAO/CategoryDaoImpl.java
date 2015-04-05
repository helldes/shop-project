package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.CategoryDao;
import com.springapp.mvc.Entity.Category;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by helldes on 01.03.2015.
 */
@Repository
public class CategoryDaoImpl extends GenericDaoImpl<Category> implements CategoryDao {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public Category getCategory(String nameCategory) {
        String hql = "select category from Category category where category.name = :nameCategory";
        return  (Category) sessionFactory.getCurrentSession().createQuery(hql).setString("nameCategory", nameCategory).uniqueResult();
    }

    @Override
    public List<Category> getChildren(Category category) {
        return sessionFactory.getCurrentSession().createCriteria(Category.class)
                .add(Restrictions.eq("parent", category))
                .list();
    }

}
