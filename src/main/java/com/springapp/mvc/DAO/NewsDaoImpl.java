package com.springapp.mvc.DAO;

import com.springapp.mvc.DAO.Interface.NewsDao;
import com.springapp.mvc.Entity.News;
import org.springframework.stereotype.Repository;

/**
 * Created by helldes on 25.03.2015.
 */
@Repository
public class NewsDaoImpl extends GenericDaoImpl<News> implements NewsDao{
}
