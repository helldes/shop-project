package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.RoleDao;
import com.springapp.mvc.Entity.Role;
import org.springframework.stereotype.Repository;

/**
 * Created by helldes on 10.03.2015.
 */
@Repository
public class RoleDaoImpl extends GenericDaoImpl<Role> implements RoleDao {

}
