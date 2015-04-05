package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.UserDao;
import com.springapp.mvc.Entity.Role;
import com.springapp.mvc.Entity.User;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * Created by helldes on 24.02.2015.
 */
@Repository
public class UserDaoImpl extends GenericDaoImpl<User> implements UserDao {

    @Autowired
    SessionFactory sessionFactory;


    @Override
    public User getUserByLogin(String login) {
        String hql = "select user from User user where user.login = :login";
        return  (User) sessionFactory.getCurrentSession().createQuery(hql).setString("login", login).uniqueResult();
    }

    @Override
    public Role getRole(User user) {
        return user.getRole();
    }

}
