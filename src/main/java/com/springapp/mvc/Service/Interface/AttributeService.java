package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Attribute;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by helldes on 20.03.2015.
 */
@Component
public interface AttributeService extends GenericService<Attribute> {
    public Attribute getAttributeByName(String nameAttribute);
    public List< Attribute> getAttributes();
}