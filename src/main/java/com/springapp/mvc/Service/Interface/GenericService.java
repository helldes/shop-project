package com.springapp.mvc.Service.Interface;

import org.springframework.stereotype.Component;

/**
 * Created by helldes on 02.04.2015.
 */
@Component
public interface GenericService<T>{
    void create(T t);
    T read(Integer id);
    void update(T t);
    void delete(T t);
}
