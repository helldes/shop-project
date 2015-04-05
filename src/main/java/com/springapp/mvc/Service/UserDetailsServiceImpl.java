package com.springapp.mvc.Service;

import com.springapp.mvc.Service.Interface.UserService;
import com.springapp.mvc.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

//import org.springframework.security.core.userdetails.User;

/**
 * Created by helldes on 24.02.2015.
 */

@Service
public class UserDetailsServiceImpl implements UserDetailsService{

    @Autowired
    UserService userService;

    @Override public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        for (  User user : userService.getUsers()) {
            if (user.getLogin().equals(username)) {
                String password=user.getPassword();
              //  List<GrantedAuthority> authorities= Collections.<GrantedAuthority>singletonList(new SimpleGrantedAuthority(userService.getRole(user).getName()));
                return new org.springframework.security.core.userdetails.User(username,password,toGrantedAuthorities(userService.getRoles(user.getRole())));
            }
        }
        throw new UsernameNotFoundException("User was not found");
    }

    public  List<GrantedAuthority> toGrantedAuthorities(Collection<String> roles){
        ArrayList<GrantedAuthority> authorities=new ArrayList<GrantedAuthority>();
        if (roles != null) {
            for (    String roleName : roles) {
                authorities.add(new SimpleGrantedAuthority(roleName));
            }
        }
        return authorities;
    }

}
