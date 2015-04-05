package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.OrderDetails;
import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.Product;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Component
public interface OrderDetailsService extends GenericService<OrderDetails> {
    public List<OrderDetails> getAllOrderDetails();
    public List<OrderDetails> getOrderDetailsByOrder(Orders orders);
    public List<OrderDetails> getOrderDetailsByProduct(Product product);
}
