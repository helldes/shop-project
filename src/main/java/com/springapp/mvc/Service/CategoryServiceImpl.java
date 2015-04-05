package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.CategoryDao;
import com.springapp.mvc.Entity.Category;
import com.springapp.mvc.Service.Interface.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by helldes on 01.03.2015.
 */
@Service
public class CategoryServiceImpl extends GenericServiceImpl<Category> implements CategoryService {

    @Autowired
    CategoryDao categoryDao;

    @Override
    public Category getCategory(String nameCategory) {
        return categoryDao.getCategory(nameCategory);
    }

    @Override
    public List<Category> getCategories() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> getChildren(Category category) {
        return categoryDao.getChildren(category);
    }
}
