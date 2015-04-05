package com.springapp.mvc.DAO.Interface;

import com.springapp.mvc.Entity.Role;
import com.springapp.mvc.Entity.User;

/**
 * Created by helldes on 24.02.2015.
 */
public interface UserDao extends GenericDao<User> {
    public User getUserByLogin(String login);
    public Role getRole(User user);

}
