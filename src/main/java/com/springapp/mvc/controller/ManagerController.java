package com.springapp.mvc.controller;

import com.springapp.mvc.Entity.News;
import com.springapp.mvc.Entity.OrderDetails;
import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Service.Interface.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * Created by helldes on 25.03.2015.
 */
@Controller
@RequestMapping("/orders")
public class ManagerController {
    @Autowired
    OrderDetailsService orderDetailsService;

    @Autowired
    ProductService productService;

    @Autowired
    OrderService orderService;

    @Autowired
    UserService userService;

    @Autowired
    NewsService newsService;

    @RequestMapping(value = "/orders_get", method = RequestMethod.GET)
    public String getOrders(ModelMap model) {
        model.addAttribute("ordersDone", orderService.getOrderByStatus(1));
        model.addAttribute("ordersInWork", orderService.getOrderByStatus(0));
        model.addAttribute("ordersDetails", orderDetailsService.getAllOrderDetails());
        model.addAttribute("users", userService.getUsers());
        return "orders";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getOrderDetailsById(@PathVariable int id,
                                      ModelMap modal
    ) {
        List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByOrder(orderService.read(id));
        modal.addAttribute("listOrderDetails", listOrderDetails);
        return "showOrderDetails";

    }

    @RequestMapping(value = "/news_add", method = RequestMethod.POST)
    public String addNews(
            @RequestParam String title,
            @RequestParam String description
    ) {
        News news = new News();
        news.setTitle(title);
        news.setDescription(description);
        newsService.addNews(news);
        return null;
    }

    @RequestMapping(value = "/product/{id}", method = RequestMethod.GET)
    public String getOrderDetailsByIdAllProduct(@PathVariable int id,
                                                ModelMap modal
    ) {
        List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByOrder(orderService.read(id));
        modal.addAttribute("listOrderDetails2", listOrderDetails);
        return "editOrder";

    }

    @RequestMapping(value = "/deleteDetail", method = RequestMethod.POST)
    public
    @ResponseBody
    String delete(
            @RequestParam int idProduct,
            @RequestParam int idOrder
    ) {
        Orders orders = orderService.read(idOrder);

        List<OrderDetails> list = orderDetailsService.getOrderDetailsByOrder(orders);
        for (OrderDetails orderDetails : list) {
            if (orderDetails.getProduct().getId() == idProduct) {
                orderDetailsService.delete(orderDetails);
                return "OK";
            }
        }
        return "DONE";
    }

    @RequestMapping(value = "/statistic_CountBuyProduct/", method = RequestMethod.GET)
    public String getStatisticByCountBuyProduct(ModelMap modal  ) {
        Map map = new HashMap();
            List<Product> listProduct = productService.getProducts();
        for (Product product : listProduct) {
            List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByProduct(product);
            int count = 0;
            for (OrderDetails orderDetails : listOrderDetails) {
                count += orderDetails.getQuantity();
            }
            map.put(product, count);
        }
        List<Map> mapList = new ArrayList(map.entrySet());
        Collections.sort(mapList, new Comparator() {
            public int compare(Object o1, Object o2) {
                Map.Entry e1 = (Map.Entry) o1;
                Map.Entry e2 = (Map.Entry) o2;
                Comparable c1 = (Comparable) e1.getValue();
                Comparable c2 = (Comparable) e2.getValue();
                return c2.compareTo(c1);
            }
        });
        modal.addAttribute("mapStaticticByCount",mapList);
        return "statisticByCount";
    }
    /*
    @RequestMapping(value = "/statistic_ManyBuyProduct/", method = RequestMethod.GET)
    public String getStatisticByMoneyBuyProduct(
            ModelMap modal
    ) {
        Map map = new HashMap();
        List<Product> listProduct = productService.getProducts();
        for (Product product : listProduct) {
            List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByProduct(product);
            int count = 0;
            for (OrderDetails orderDetails : listOrderDetails) {
                count += orderDetails.getQuantity();
            }
            map.put(product, count);
        }
        Map mapResult = new HashMap();

        List<Map> mapList = new ArrayList(map.entrySet());
        Collections.sort(mapList, new Comparator() {
            public int compare(Object o1, Object o2) {
                Map.Entry e1 = (Map.Entry) o1;
                Map.Entry e2 = (Map.Entry) o2;
                Comparable c1 = (Comparable) e1.getValue();
                Comparable c2 = (Comparable) e2.getValue();
                return c2.compareTo(c1);
            }
        });
        modal.addAttribute("mapStaticticByCount",mapList);
        return "statisticByCount";
    }*/
}
