package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.RoleDao;
import com.springapp.mvc.DAO.Interface.UserDao;
import com.springapp.mvc.Entity.Role;
import com.springapp.mvc.Entity.User;
import com.springapp.mvc.Service.Interface.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author vladimirb
 * @since 3/11/14
 */
@Service
public class UserServiceImpl extends GenericServiceImpl<User> implements UserService {

    @Autowired
    UserDao userDao;

    @Autowired
    RoleDao roleDao;

    public User getUserById(Integer id) {
        return userDao.read(id);
    }

    @Override
    public List<User> getUsers() {
        return userDao.getAll();
    }

    public void deleteUser(User user) {
        userDao.delete(user);
    }

    @Override
    public User getUser(String login) {
        return userDao.getUserByLogin(login);
    }

    @Override
    public Role getRole(User user) {
        return user.getRole();
    }

    @Override
    public Set<String> getRoles(Role role) {
        Set<String> roles = new HashSet<String>();

        if (role.getName().equals("ADMIN")) {
            roles.add("USER");
            roles.add("MANAGER");
            roles.add("ADMIN");
        } else if (role.getName().equals("MANAGER")) {
            roles.add("USER");
            roles.add("MANAGER");
        }
        return roles;
    }

    @Override
    public void disableUser(User user) {
        userDao.update(user);
    }

    @Override
    public Boolean checkUserByLoginPhoneNumber(String loginUser) {
        try {
            if (userDao.getUserByLogin(loginUser) == null) {
                return false;
            } else {
                return true;
            }
        } catch (Exception e) {
            return false;
        }

    }
}
