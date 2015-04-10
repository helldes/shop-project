package com.springapp.mvc;

import com.springapp.mvc.Configuration.ServerCustomization;
import com.springapp.mvc.DTO.*;
import com.springapp.mvc.Entity.*;
import ma.glasnost.orika.MapperFacade;
import ma.glasnost.orika.MapperFactory;
import ma.glasnost.orika.impl.DefaultMapperFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.web.ServerProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Configuration
@EnableAutoConfiguration
@ComponentScan
public class ShopProjectLauncher {

    public static void main(String[] args) throws Exception {
        String webPort = System.getenv("PORT");
        if (webPort == null || webPort.isEmpty()) {
            webPort = "8080";
        }
        System.setProperty("server.port", webPort);



        SpringApplication.run(ShopProjectLauncher.class, args);
    }
    @Bean
    public MultipartResolver multipartResolver() {
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
        multipartResolver.setDefaultEncoding("utf-8");
        return multipartResolver;
    }

    @Bean
    public ServerProperties getServerProperties() {
        return new ServerCustomization();
    }

    @Bean
    public MapperFacade mapper() {
        final MapperFactory mapperFactory = new DefaultMapperFactory.Builder().build();
        mapperFactory.classMap(Brand.class, BrandDTO.class).byDefault().register();
        mapperFactory.classMap(Attribute.class, AttributeDTO.class).byDefault().register();
        mapperFactory.classMap(Category.class, CategoryDTO.class).field("parent.id", "parent").byDefault().register();
        mapperFactory.classMap(User.class, UserDTO.class).field("role.id", "role").byDefault().register();
        mapperFactory.classMap(News.class, NewsDTO.class).byDefault().register();
        mapperFactory.classMap(Product.class, ProductDTO.class)
                .field("brand.id", "brand")
                .field("category.id", "category").byDefault().register();

        return mapperFactory.getMapperFacade();
    }
}
