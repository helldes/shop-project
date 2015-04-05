package com.springapp.mvc.Configuration;

import com.springapp.mvc.Service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

        @Autowired
        UserDetailsServiceImpl userDetailsServiceImpl;

        @Autowired
        public void registerGlobalAuthentication(AuthenticationManagerBuilder auth) throws Exception {
            auth.userDetailsService(userDetailsServiceImpl);//  passwordEncoder(getShaPasswordEncoder());
        }


    @Override
    public void configure(HttpSecurity http) throws Exception {

        http
                .authorizeRequests().antMatchers("/admin/**")
                    .access("hasRole('ADMIN')")
                .and()
                .authorizeRequests().antMatchers("/orders/**")
                     .access("hasRole('MANAGER')")
                .and()
                .authorizeRequests().antMatchers("/**").permitAll()
                .and().formLogin()
                .loginPage("/login")
                    .loginProcessingUrl("/j_spring_security_check")
                .failureUrl("/login?error")
                    .usernameParameter("j_username")
                    .passwordParameter("j_password")
         .and().logout().logoutUrl("/j_spring_security_logout")
         .and().logout().logoutSuccessUrl("/")
         .and().exceptionHandling().accessDeniedPage("/403").and().csrf().disable();
    }

 /*   @Bean
    public ShaPasswordEncoder getShaPasswordEncoder(){
        return new ShaPasswordEncoder();
    }
*/
}
