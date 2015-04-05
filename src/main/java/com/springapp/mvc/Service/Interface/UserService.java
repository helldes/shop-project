package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Role;
import com.springapp.mvc.Entity.User;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;

/**
 * Created by helldes on 24.02.2015.
 */
@Component
public interface UserService extends GenericService<User> {
    public User getUser(String loginUser);
    public List<User> getUsers();
    public Role getRole(User user);
    public Set<String> getRoles(Role role);
    public void disableUser(User user);
    public Boolean checkUserByLoginPhoneNumber(String loginUser);

}
