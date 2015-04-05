package com.springapp.mvc.DAO.Interface;

import java.io.Serializable;
import java.util.List;

/**
 * Created by helldes on 26.03.2015.
 */
public interface GenericDao<T extends Serializable> {
    void create(T t);
    T read(Integer id);
    void update(T t);
    void delete(T t);
    List<T> getAll();
}