package com.ly.lit.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
//@EnableWebMvc
@ComponentScan
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/images/**")
                .addResourceLocations("/WEB-INF/upload/images/");
        registry.addResourceHandler("/img/**")
                .addResourceLocations("/WEB-INF/upload/img/");
//        registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/css/");
//        registry.addResourceHandler("/images/**").addResourceLocations("/WEB-INF/images/");
    }

}
