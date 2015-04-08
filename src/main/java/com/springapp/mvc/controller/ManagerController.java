package com.springapp.mvc.controller;

import com.springapp.mvc.DTO.NewsDTO;
import com.springapp.mvc.Entity.News;
import com.springapp.mvc.Entity.OrderDetails;
import com.springapp.mvc.Entity.Orders;
import com.springapp.mvc.Entity.Product;
import com.springapp.mvc.Service.Interface.*;
import ma.glasnost.orika.MapperFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

    @Autowired
    MapperFacade mapper;

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
    public @ResponseBody String addNews(@RequestBody NewsDTO dto
    ) {
        newsService.create(mapper.map(dto, News.class));
        return "ok";
    }

    @RequestMapping(value = "/product/{id}", method = RequestMethod.GET)
    public String getOrderDetailsByIdAllProduct(@PathVariable int id,
                                                ModelMap model
    ) {
        List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByOrder(orderService.read(id));
        model.addAttribute("listOrderDetails2", listOrderDetails);
        model.addAttribute("IdOrder", id);
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

    @RequestMapping(value = "/statistic_CountBuyProduct", method = RequestMethod.GET)
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

    @RequestMapping(value = "/saveDetail", method = RequestMethod.POST)
    public
    @ResponseBody
    String save(
            @RequestParam String address,
            @RequestParam int idOrder
    ) {
        Orders orders = orderService.read(idOrder);
        orders.setCustomAddress(address);

        List<OrderDetails> list = orderDetailsService.getOrderDetailsByOrder(orders);
        if (list.size() == 0 ) {
            orders.setTotalPrice(0.0);
        } else {
            double newSum = 0.0;
            for (OrderDetails orderDetails : list) {
                newSum += orderDetails.getProduct().getPrice() * orderDetails.getQuantity();
            }
            orders.setTotalPrice(newSum);
        }
        orderService.update(orders);
        return "DONE";
    }

    @RequestMapping(value = "/changeQuantity", method = RequestMethod.POST)
    public
    @ResponseBody
    String changeQuantity(
            @RequestParam int idProduct,
            @RequestParam int idOrder,
            @RequestParam int countQuantity
    ) {
        Orders orders = orderService.read(idOrder);

        List<OrderDetails> list = orderDetailsService.getOrderDetailsByOrder(orders);
        for (OrderDetails orderDetails : list) {
            if (orderDetails.getProduct().getId() == idProduct) {
                orderDetails.setQuantity(countQuantity);
                orderDetailsService.update(orderDetails);
                return "OK";
            }
        }
        return "DONE";
    }

    @RequestMapping(value = "/search", method = RequestMethod.POST)
    public String searchOrder(
            HttpServletRequest request,
            @RequestParam int sel,
            @RequestParam int idOrder,
            @RequestParam String date1,
            @RequestParam String date2
    ) {

        request.getSession().setAttribute("resultSearch", null);
        // search by number Order
        if (sel == 1) {
            List<Orders> resultList = new LinkedList();
            request.getSession().setAttribute("resultSearch", resultList.add(orderService.read(idOrder)));
            return "redirect:/orders/search";
        }

        return null;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String showSearchOrder( @RequestParam int sel,
                                   @RequestParam int idOrder,
                                   @RequestParam String date1,
                                   @RequestParam String date2,
                                   ModelMap model
    ) throws ParseException {
        // search by number Order
        model.addAttribute("ordersDone", new LinkedList<Orders>());
        model.addAttribute("ordersDetails", orderDetailsService.getAllOrderDetails());
        model.addAttribute("users", userService.getUsers());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        switch (sel){
            case 1: {
                List<Orders> resultList = new LinkedList();
                resultList.add(orderService.read(idOrder));
                model.addAttribute("ordersInWork", resultList);
                return "orders";
            }
            case 2:{
                Date dateController1 = sdf.parse(date1);
                Date dateTemp = sdf.parse(date2);
                Date dateController2 = new Date(dateTemp.getTime() + (1000 * 60 * 60 * 24));

                System.out.print(dateTemp);
                System.out.print(dateController2);
                model.addAttribute("ordersInWork", orderService.getOrdersByPeriodDate(dateController1, dateController2));
                return "orders";
            }
            case 3:{
                Date dateController1 = sdf.parse(date1);
                Date dateController2 = new Date(dateController1.getTime() + (1000 * 60 * 60 * 24));
                model.addAttribute("ordersInWork",orderService.getOrdersByPeriodDate(dateController1, dateController2));
                return "orders";
            }

        }
        return null;
    }

    @RequestMapping(value = "/done/{id}", method = RequestMethod.GET)
    public String ordersDoneById(@PathVariable int id,
                                 ModelMap model
    ) {
        Orders orders = orderService.read(id);
        orders.setStatus(1);
        orderService.update(orders);
        model.addAttribute("ordersDone", orderService.getOrderByStatus(1));
        model.addAttribute("ordersInWork", orderService.getOrderByStatus(0));
        model.addAttribute("ordersDetails", orderDetailsService.getAllOrderDetails());
        model.addAttribute("users", userService.getUsers());
        return "orders";

    }

    @RequestMapping(value = "/news_delete/{id}", method = RequestMethod.GET)
    public String deleteNews(@PathVariable int id
    ) {
        newsService.delete(newsService.read(id));
        return "editOrder";

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
