package com.springapp.mvc.Configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBean;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;
import java.util.Properties;

/**
 * @author vladimirb
 * @since 3/12/14
 */
@Configuration
@EnableTransactionManagement
@PropertySource("classpath:hibernate.properties")
public class HibernateConfig {

	static final String DRIVER_CLASS_NAME = "com.mysql.jdbc.Driver";

	static final Properties hibernateProperties = new Properties() {
		{
			setProperty("hibernate.dialect", "org.hibernate.dialect.MySQL5Dialect");
			setProperty("hibernate.hbm2ddl.auto", "update");
			setProperty("hibernate.show_sql", "true");
			setProperty("hibernate.current_session_context_class", "org.springframework.orm.hibernate4.SpringSessionContext");
		}
	};

	@Value("${connection.url}")
	String dbUrl;

	@Value("${connection.username}")
	String dbUser;

	@Value("${connection.password}")
	String dbPass;

	@Bean
	public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}

	@Bean
	public LocalSessionFactoryBean sessionFactory() {
		final LocalSessionFactoryBean sessionFactory = new LocalSessionFactoryBean();
		sessionFactory.setDataSource(dataSource());
		sessionFactory.setPackagesToScan("com.springapp.mvc.Entity");
		sessionFactory.setHibernateProperties( hibernateProperties );
		return sessionFactory;
	}

	@Bean
	public HibernateTransactionManager transactionManager() {
		HibernateTransactionManager txManager = new HibernateTransactionManager();
		txManager.setSessionFactory(sessionFactory().getObject());
		return txManager;
	}

	@Bean
	public DataSource dataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource(dbUrl, dbUser, dbPass);
		dataSource.setDriverClassName( DRIVER_CLASS_NAME );
		return dataSource;
	}
}
