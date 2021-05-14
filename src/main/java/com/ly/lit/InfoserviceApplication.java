package com.ly.lit;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.ly.lit.mapper")
public class InfoserviceApplication {

    public static void main(String[] args) {
        SpringApplication.run(InfoserviceApplication.class, args);
    }

}
