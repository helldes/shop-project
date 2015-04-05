package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Category;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by helldes on 01.03.2015.
 */
@Component
public interface CategoryService extends GenericService<Category> {
    public Category getCategory(String nameCategory);
    public List<Category> getCategories();
    public List<Category> getChildren(Category category);
}
