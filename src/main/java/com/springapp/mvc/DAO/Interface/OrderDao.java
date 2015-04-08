package com.springapp.mvc.DAO.Interface;

import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.User;

import java.util.Date;
import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
public interface OrderDao extends GenericDao<Orders>{
    public List<Orders> getOrderByStatus(int status);
    public List<Orders> getOrderByDate(Date date);
    public List<Orders> getOrdersByUser(User user);
    public List<Orders> getOrdersByPeriodDate (Date date1, Date date2);
}
