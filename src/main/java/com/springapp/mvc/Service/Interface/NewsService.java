package com.springapp.mvc.Service.Interface;

import com.springapp.mvc.Entity.News;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by helldes on 25.03.2015.
 */
@Component
public interface NewsService {
    public void addNews(News news);
    public List<News> getAllNews();
}
