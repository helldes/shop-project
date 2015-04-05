package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.BrandDao;
import com.springapp.mvc.Entity.Brand;
import com.springapp.mvc.Service.Interface.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by root on 11.03.2015.
 */
@Service
public class BrandServiceImpl extends GenericServiceImpl<Brand> implements BrandService {

   @Autowired
    BrandDao brandDao;

    @Override
    public List<Brand> getBrands() {
        return brandDao.getAll();
    }

}
