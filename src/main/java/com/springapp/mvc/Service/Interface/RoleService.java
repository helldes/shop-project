package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Role;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by helldes on 10.03.2015.
 */
@Component
public interface RoleService extends  GenericService<Role>{
    public List<Role> getRoles();
}
