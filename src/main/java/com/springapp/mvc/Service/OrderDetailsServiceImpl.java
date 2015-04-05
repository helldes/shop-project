package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.OrderDao;
import com.springapp.mvc.DAO.Interface.OrderDetailsDao;
import com.springapp.mvc.DAO.Interface.ProductDao;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Service.Interface.OrderDetailsService;
import com.springapp.mvc.Entity.OrderDetails;
import com.springapp.mvc.Entity.Orders;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by helldes on 24.03.2015.
 */
@Service
public class OrderDetailsServiceImpl extends GenericServiceImpl<OrderDetails> implements OrderDetailsService{

    @Autowired
    OrderDetailsDao orderDetailsDao;

    @Autowired
    ProductDao productDao;

    @Autowired
    OrderDao orderDao;

    @Override
    public List<OrderDetails> getAllOrderDetails() {
        return orderDetailsDao.getAll();
    }

    @Override
    public List<OrderDetails> getOrderDetailsByOrder(Orders orders) {
        return orderDetailsDao.getOrderDetailsByOrder(orders);
    }

    @Override
    public List<OrderDetails> getOrderDetailsByProduct(Product product) {
        return orderDetailsDao.getOrderDetailsByProduct(product);
    }
}
