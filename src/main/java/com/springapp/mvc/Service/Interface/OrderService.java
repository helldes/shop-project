package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.User;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Component
public interface OrderService extends GenericService<Orders> {
    public List<Orders> getOrdersByUser(User user);
    public List<Orders> getOrderByStatus(int status);
    public List<Orders> getOrderByDate(Date date);
}
