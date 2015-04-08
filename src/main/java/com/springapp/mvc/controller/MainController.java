package com.springapp.mvc.controller;

import com.springapp.mvc.DTO.UserDTO;
import com.springapp.mvc.Entity.*;
import com.springapp.mvc.Service.Interface.*;
import com.springapp.mvc.Util.ComparatorSortPriceAZ;
import com.springapp.mvc.Util.ComparatorSortPriceZA;
import com.springapp.mvc.Util.HechText;
import com.springapp.mvc.Util.MapValueComparator;
import ma.glasnost.orika.MapperFacade;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.security.NoSuchAlgorithmException;
import java.util.*;


@Controller
@RequestMapping("/")
public class MainController {

    @Autowired
    UserService userService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    ProductService productService;

    @Autowired
    OrderService orderService;

    @Autowired
    OrderDetailsService orderDetailsService;

    @Autowired
    NewsService newsService;

    @Autowired
    RoleService roleService;

    @Autowired
    MapperFacade mapper;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage(Model model,
                            @RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "logout", required = false) String logout) {

        if (error != null) {
            model.addAttribute("error", "Invalid username and password!");
        }

        if (logout != null) {
            model.addAttribute("msg", "You've been logged out successfully.");
        }
        return "login";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String printWelcome(ModelMap model) {
        model.addAttribute("categorysForUser", categoryService.getCategories());
        model.addAttribute("listNews", newsService.getAllNews());
        return "main";
    }

    @RequestMapping(value = "/categories/{id_path}", method = RequestMethod.GET)
    public String get(@PathVariable Integer id_path,
                      ModelMap model
    ) {
        model.addAttribute("category", categoryService.read(id_path));

        if (categoryService.read(id_path).getParent() == null) {
            Category parentCategory = categoryService.read(id_path);
            List<Category> list = categoryService.getChildren(parentCategory);
            List<Product> products = new LinkedList<Product>();
            for (Category category : list) {
                products.addAll(productService.getProductsByCategory(category));
            }
            if (products.size() == 0) {
                return "noProduct";
            } else {
                model.addAttribute("ProductsByCategory", products);
                return "showProducts";
            }
        } else {
            if (productService.getProductsByCategory(categoryService.read(id_path)).size() != 0) {
                model.addAttribute("ProductsByCategory", productService.getProductsByCategory(categoryService.read(id_path)));
                return "showProducts";
            } else {
                return "noProduct";
            }
        }
    }


    @RequestMapping(value = "/sortProducts/{idSelect}/{idCategory}", method = RequestMethod.GET)
    public String productsSortBy(
            @PathVariable int idSelect,
            @PathVariable int idCategory,
            ModelMap model
    ) {
        model.addAttribute("category", categoryService.read(idCategory));
        switch (idSelect) {
            case 0: {
                return "redirect:/categories/" + idCategory;
            }
            case 1: {
                if (categoryService.read(idCategory).getParent() == null) {
                    Category parentCategory = categoryService.read(idCategory);
                    List<Category> list = categoryService.getChildren(parentCategory);
                    List<Product> products = new LinkedList<Product>();

                    Comparator comparator = new ComparatorSortPriceAZ();
                    for (Category category : list) {
                        products.addAll(productService.getProductsByCategory(category));
                    }
                    Collections.sort(products, comparator);
                    model.addAttribute("ProductsByCategory", products);
                    return "showProducts";
                } else {
                    List<Product> products = productService.getProductsByCategory(categoryService.read(idCategory));

                    Comparator comparator = new ComparatorSortPriceAZ();
                    Collections.sort(products, comparator);
                    model.addAttribute("ProductsByCategory", products);
                    return "showProducts";
                }

            }
            case 2: {
                if (categoryService.read(idCategory).getParent() == null) {
                    Category parentCategory = categoryService.read(idCategory);
                    List<Category> list = categoryService.getChildren(parentCategory);
                    List<Product> products = new LinkedList<Product>();
                    Comparator comparator = new ComparatorSortPriceZA();
                    for (Category category : list) {
                        products.addAll(productService.getProductsByCategory(category));
                    }
                    Collections.sort(products, comparator);
                    model.addAttribute("ProductsByCategory", products);
                    return "showProducts";
                } else {
                    List<Product> products = productService.getProductsByCategory(categoryService.read(idCategory));
                    Comparator comparator = new ComparatorSortPriceZA();
                    Collections.sort(products, comparator);
                    model.addAttribute("ProductsByCategory", products);
                    return "showProducts";
                }
            }
            case 3: {
                Map map = new HashMap();
                MapValueComparator bvc = new MapValueComparator(map);
                TreeMap<Product, Integer> sorted_map = new TreeMap<Product, Integer>(bvc);
                if (categoryService.read(idCategory).getParent() == null) {
                    Category parentCategory = categoryService.read(idCategory);
                    List<Category> list = categoryService.getChildren(parentCategory);
                    List<Product> products = new LinkedList<Product>();
                    for (Category category : list) {
                        products.addAll(productService.getProductsByCategory(category));
                    }
                    for (Product product : products) {
                        List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByProduct(product);
                        int count = 0;
                        for (OrderDetails orderDetails : listOrderDetails) {
                            count += orderDetails.getQuantity();
                        }
                        map.put(product, count);
                    }
                    sorted_map.putAll(map);
                    Set<Product> setProduct = new LinkedHashSet<>();
                    setProduct.addAll(sorted_map.keySet());
                    model.addAttribute("ProductsByCategory", setProduct);
                    return "showProducts";
                } else {
                    List<Product> products = productService.getProductsByCategory(categoryService.read(idCategory));
                    /*products*/
                    for (Product product : products) {
                        List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByProduct(product);
                        int count = 0;
                        for (OrderDetails orderDetails : listOrderDetails) {
                            count += orderDetails.getQuantity();
                        }
                        map.put(product, count);
                    }
                    sorted_map.putAll(map);
                    Set<Product> setProduct = new LinkedHashSet<>();
                    setProduct.addAll(sorted_map.keySet());
                    model.addAttribute("ProductsByCategory", setProduct);
                    return "showProducts";
                }
            }
        }
        return null;
    }


    @RequestMapping(value = "/user_registration", method = RequestMethod.POST)
    public String createUser(
            @RequestBody UserDTO dto
    ) {
        User user = mapper.map(dto, User.class);
        user.setDisable(false);
        user.setRole(roleService.read(3));
        userService.create(user);

        return "main";
    }

    @RequestMapping(value = "/login_check", method = RequestMethod.POST)
    public
    @ResponseBody
    String loginCheck(
            @RequestParam String loginUserModal
    ) {
        try {
            User user = userService.getUser(loginUserModal);

            if (user.getLogin().equals(loginUserModal)) {
                return "true";
            }
        } catch (Exception e) {
            return "false";
        }
        return "false";
    }

    @RequestMapping(value = "/helloUser", method = RequestMethod.GET)
    public String hellouser_jsp(ModelMap model) {
        return "helloUser";
    }

    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public String accessDenied(ModelMap model) {
        return "403";
    }

    @RequestMapping(value = "/404", method = RequestMethod.GET)
    public String notFound(ModelMap model) {
        return "404";
    }

    @RequestMapping(value = "/500", method = RequestMethod.GET)
    public String serverError(ModelMap model) {
        return "500";
    }

    @RequestMapping(value = "/otherError", method = RequestMethod.GET)
    public String otherError(ModelMap model) {
        return "otherError";
    }


    @RequestMapping(value = "/boxSum/{id}", method = RequestMethod.GET)
    public String boxSum(@PathVariable int id,
                         ModelMap model, HttpServletRequest request
    ) {
        HttpSession session = request.getSession();
        Product product = productService.read(id);
        if (session.getAttribute("shoppingCart") == null) {
            Set<Product> set = new HashSet<Product>();
            set.add(product);
            session.setAttribute("shoppingCart", set);
        } else {
            int i = 0;
            Set<Product> set = (Set<Product>) session.getAttribute("shoppingCart");
            for (Product product_value : set) {
                if (product_value.getId() == id) {
                    i = 1;
                    break;
                }
            }
            if (i == 0) {
                set.add(product);
            }
            session.setAttribute("shoppingCart", set);
        }

        return "boxSum";
    }

    @RequestMapping(value = "/ShopCart_get", method = RequestMethod.GET)
    public String Cart(ModelMap model) {
        return "boxSum";
    }


    @RequestMapping(value = "/cardDelProduct/{id}", method = RequestMethod.GET)
    public String cardDelProduct(@PathVariable int id,
                                 HttpServletRequest request
    ) {
        HttpSession session = request.getSession();
        Set<Product> set = (Set<Product>) session.getAttribute("shoppingCart");
        for (Product product_value : set) {
            if (product_value.getId() == id) {
                set.remove(product_value);
                session.setAttribute("shoppingCart", set);
                break;
            }
        }

        return "boxSum";
    }

    @RequestMapping(value = "/getOrder", method = RequestMethod.POST)
    public
    @ResponseBody
    String GetOrder(
            HttpServletRequest request,
            HttpServletResponse response
    ) {


        HttpSession session = request.getSession();

        Set<Product> set = (Set<Product>) session.getAttribute("shoppingCart");
        String letter = "";

        Double totalPrice = 0.0;
        for (Product product_value : set) {
            String str = request.getParameter(("count" + product_value.getId()));
            String tempcount = request.getParameter(("count" + product_value.getId()));
            letter += " | Price:  " + product_value.getPrice() + "  ,COUNT:  " + tempcount;
            totalPrice += product_value.getPrice() * Integer.parseInt(tempcount);
        }
        String phoneNumber = request.getParameter("phoneNumber");
        letter += "  ||| Phone  " + phoneNumber;
        session.removeAttribute("shoppingCart");

/* MAIL SENDER
//        mailSender sslSender = new mailSender("rublebubleandr@gmail.com", "");
//        sslSender.send("From GeekHub Shop", letter, "rublebubleandr@gmail.com", "task5gh@yandex.ru");
*/
        if (phoneNumber.equals("0")) {
            User user = userService.getUser(request.getUserPrincipal().getName());
            Orders order = new Orders();
            order.setUser(user);
            order.setStatus(0);
            order.setCustomAddress(user.getAddress());
            order.setTotalPrice(totalPrice);
            orderService.create(order);
            OrderDetails orderDetails = new OrderDetails();
            for (Product product : set) {
                orderDetails.setProduct(product);
                orderDetails.setOrders(order);
                orderDetails.setQuantity(Integer.parseInt(request.getParameter(("count" + product.getId()))));
                orderDetailsService.create(orderDetails);
            }
        } else {
            try {
                if (userService.checkUserByLoginPhoneNumber(phoneNumber)) {
                    User user = userService.getUser(phoneNumber);
                    Orders order = new Orders();
                    order.setUser(user);
                    order.setStatus(0);
                    order.setCustomAddress(user.getAddress());
                    order.setTotalPrice(totalPrice);
                    orderService.create(order);
                    OrderDetails orderDetails = new OrderDetails();
                    for (Product product : set) {
                        orderDetails.setProduct(product);
                        orderDetails.setOrders(order);
                        orderDetails.setQuantity(Integer.parseInt(request.getParameter(("count" + product.getId()))));
                        orderDetailsService.create(orderDetails);
                    }
                } else {
                    User user = new User();
                    user.setLogin(phoneNumber);
                    user.setPhone(phoneNumber);
                    user.setAddress("address none");
                    user.setPassword(HechText.hechText(phoneNumber));
                    user.setDisable(true);
                    userService.create(user);
                    Orders order = new Orders();
                    order.setUser(user);
                    order.setStatus(0);
                    order.setCustomAddress(user.getAddress());
                    order.setTotalPrice(totalPrice);
                    orderService.create(order);
                    OrderDetails orderDetails = new OrderDetails();
                    for (Product product : set) {
                        orderDetails.setProduct(product);
                        orderDetails.setOrders(order);
                        orderDetails.setQuantity(Integer.parseInt(request.getParameter(("count" + product.getId()))));
                        orderDetailsService.create(orderDetails);
                    }
                }
            } catch (NoSuchAlgorithmException e) {
                e.printStackTrace();
            }
        }
        return "main";
    }
/*

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public
    @ResponseBody
    String handleFileUpload(@RequestParam("name") String name,
                            @RequestParam("file") MultipartFile file,
                            HttpServletRequest request
    ) {
        try {
            byte[] bytes = file.getBytes();
            // Create the file on server
            String str2 = request.getSession().getServletContext().getRealPath("/sources") + "\\img\\";
            File serverFile = new File(str2 + name + ".jpg");
            BufferedOutputStream stream = new BufferedOutputStream(
                    new FileOutputStream(serverFile));
            stream.write(bytes);
            stream.close();
        } catch (Exception e) {
            return "You failed to upload " + name + " => " + e.getMessage();
        }
        return null;
    }
*/
    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public String getAbout() {
        return "about";
    }

    @RequestMapping(value = "/orderUser/{id}", method = RequestMethod.GET)
    public String showOrdersByUser(@PathVariable int id,
                                   ModelMap model
    ) {
        model.addAttribute("orders", orderService.getOrdersByUser(userService.read(id)));
        return "ordersUser";
    }

    @RequestMapping(value = "/orderDetails/{id}", method = RequestMethod.GET)
    public String getOrderDetailsByIdAllProduct(@PathVariable int id,
                                                ModelMap modal
    ) {
        List<OrderDetails> listOrderDetails = orderDetailsService.getOrderDetailsByOrder(orderService.read(id));
        modal.addAttribute("listOrderDetails", listOrderDetails);
        return "showOrderDetails";

    }

    @RequestMapping(value = "/getUserData/{id}", method = RequestMethod.GET)
    public String showDataUser(@PathVariable int id,
                               ModelMap model
    ) {
        model.addAttribute("userData", userService.read(id));
        return "userData";
    }

    @RequestMapping(value = "/user_saveData", method = RequestMethod.POST)
    public
    @ResponseBody
    String saveUserData(
            @RequestBody UserDTO dto
    ) {
        User user = mapper.map(dto, User.class);
        user.setRole(roleService.read(3));
        user.setPassword(userService.read(user.getId()).getPassword());
        userService.update(user);

     /*   User user = mapper.map(dto, User.class);
        user.setDisable(false);
        user.setRole(roleService.read(3));
        userService.create(user);
*/
        return "Done";
    }

    @RequestMapping(value = "/news_get", method = RequestMethod.GET)
    public String getNews(
            ModelMap model
    ) {
        model.addAttribute("listNews", newsService.getAllNews());
        return "editOrder";
    }

}