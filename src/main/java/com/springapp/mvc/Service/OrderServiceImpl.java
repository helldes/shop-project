package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.OrderDao;
import com.springapp.mvc.Service.Interface.OrderService;
import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Service
public class OrderServiceImpl extends GenericServiceImpl<Orders> implements OrderService {

    @Autowired
    OrderDao orderDao;

    @Override
    public List<Orders> getOrdersByUser(User user) {
        return orderDao.getOrdersByUser(user);
    }

    @Override
    public List<Orders> getOrderByStatus(int status) {
        return orderDao.getOrderByStatus(status);
    }

    @Override
    public List<Orders> getOrderByDate(Date date) {
        return orderDao.getOrderByDate(date);
    }

    @Override
    public List<Orders> getOrdersByPeriodDate(Date date1, Date date2) {
        return orderDao.getOrdersByPeriodDate(date1, date2);
    }
}
