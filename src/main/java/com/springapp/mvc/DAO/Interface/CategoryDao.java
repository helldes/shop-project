package com.springapp.mvc.DAO.Interface;

import com.springapp.mvc.Entity.Category;

import java.util.List;

/**
 * Created by helldes on 01.03.2015.
 */
public interface CategoryDao extends GenericDao<Category>{
    public Category getCategory(String nameCategory);
    public List<Category> getChildren(Category category);
}
