package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.AttributeDao;
import com.springapp.mvc.Entity.Attribute;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by helldes on 20.03.2015.
 */
@Repository
public class AttributeDaoImpl extends GenericDaoImpl<Attribute> implements AttributeDao {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public Attribute getAttribute(String nameAttribute) {
        String hql = "select attribute from Attribute category where attribute.name = :nameAttribute";
        return  (Attribute) sessionFactory.getCurrentSession().createQuery(hql).setString("nameAttribute", nameAttribute).uniqueResult();
    }

}
