package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.RoleDao;
import com.springapp.mvc.Service.Interface.RoleService;
import com.springapp.mvc.Entity.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by helldes on 10.03.2015.
 */
@Service
public class RoleServiceImpl extends GenericServiceImpl<Role> implements RoleService {

    @Autowired
    RoleDao roleDao;

    @Override
    public List<Role> getRoles() {
        return roleDao.getAll();
    }
}
