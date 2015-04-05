package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.OrderDao;
import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.User;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Repository
public class OrderDaoImpl extends GenericDaoImpl<Orders> implements OrderDao {

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public List<Orders> getOrderByStatus(int status) {
        return sessionFactory.getCurrentSession().createCriteria(Orders.class)
                .add(Restrictions.eq("status", status))
                .list();
    }

    @Override
    public List<Orders> getOrderByDate(Date date) {
        return sessionFactory.getCurrentSession().createCriteria(Orders.class)
                .add(Restrictions.eq("date", date))
                .list();
    }

    @Override
    public List<Orders> getOrdersByUser(User user) {
        return sessionFactory.getCurrentSession().createCriteria(Orders.class)
                .add(Restrictions.eq("user", user))
                .list();
    }
}
