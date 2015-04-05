package com.springapp.mvc.controller;

import com.springapp.mvc.Service.Interface.UserService;
import com.springapp.mvc.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by helldes on 27.02.2015.
 */
@Controller
@RequestMapping("/login")
public class SecurityController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String mainLogin(ModelMap model, HttpServletRequest request) {
        String userName = request.getUserPrincipal().getName();

        User user = userService.getUser(userName);

        if (user.getRole().getName().equals("ADMIN")){
            return "admin";
        } else {
            if (user.getRole().getName().equals("MANAGER")){
                return "managerPage";
            }
        }
        model.addAttribute("user", user);
        return "userPage";
    }
}
