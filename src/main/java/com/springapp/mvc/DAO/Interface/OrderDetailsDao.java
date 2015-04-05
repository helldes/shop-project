package com.springapp.mvc.DAO.Interface;

import com.springapp.mvc.Entity.OrderDetails;
import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.Product;

import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
public interface OrderDetailsDao extends GenericDao<OrderDetails>{
    public List<OrderDetails> getOrderDetailsByOrder(Orders orders);
    public List<OrderDetails> getOrderDetailsByProduct(Product product);
}
