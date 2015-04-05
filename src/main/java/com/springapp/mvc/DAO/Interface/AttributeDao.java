package com.springapp.mvc.DAO.Interface;

import com.springapp.mvc.Entity.Attribute;

/**
 * Created by helldes on 20.03.2015.
 */
public interface AttributeDao extends GenericDao<Attribute>{
    public Attribute getAttribute(String nameAttribute);
}