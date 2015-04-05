package com.springapp.mvc.Service;

import com.springapp.mvc.DAO.Interface.NewsDao;
import com.springapp.mvc.Service.Interface.NewsService;
import com.springapp.mvc.Entity.News;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by helldes on 25.03.2015.
 */
@Service
public class NewsServiceImpl implements NewsService {

    @Autowired
    NewsDao newsDao;

    @Override
    public void addNews(News news) {
    newsDao.create(news);
    }


    @Override
    public List<News> getAllNews() {
        return newsDao.getAll();
    }
}
