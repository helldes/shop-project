package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.AttributeDao;
import com.springapp.mvc.Service.Interface.AttributeService;
import com.springapp.mvc.Entity.Attribute;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by helldes on 20.03.2015.
 */
@Service
public class AttributeServiceImpl extends GenericServiceImpl<Attribute> implements AttributeService {

    @Autowired
    AttributeDao attributeDao;

    @Override
    public Attribute getAttributeByName(String nameAttribute) {
        return attributeDao.getAttribute(nameAttribute);
    }

    @Override
    public List<Attribute> getAttributes() {
        return attributeDao.getAll();
    }

}
