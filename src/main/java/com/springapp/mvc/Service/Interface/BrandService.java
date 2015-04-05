package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.Brand;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by root on 11.03.2015.
 */
@Component
public interface BrandService extends GenericService<Brand>{
    public List<Brand> getBrands();
}
