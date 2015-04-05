package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.OrderDetailsDao;
import com.springapp.mvc.Entity.OrderDetails;
import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.Product;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Repository
public class OrderDetailsDaoImpl extends  GenericDaoImpl<OrderDetails> implements OrderDetailsDao{

    @Autowired
    SessionFactory sessionFactory;

    @Override
    public List<OrderDetails> getOrderDetailsByOrder(Orders orders) {
        return sessionFactory.getCurrentSession().createCriteria(OrderDetails.class).add(Restrictions.eq("pk.orders", orders)).list();
    }

    @Override
    public List<OrderDetails> getOrderDetailsByProduct(Product product) {
        return sessionFactory.getCurrentSession().createCriteria(OrderDetails.class).add(Restrictions.eq("pk.product", product)).list();
    }

}
