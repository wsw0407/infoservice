package com.ly.lit.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class WebController {


    @RequestMapping("/index")
    public String toIndex(){

        return "index";
    }

    @RequestMapping("/users/index")
    public String toUserIndex(){
        return "/users/index";
    }

    @RequestMapping("/yqhot")
    public String yqhot(){
        return "yqhot";
    }


    @RequestMapping("/test")
    public String toTest(){
        return "user/test";
    }

    @RequestMapping("/testText")
    public String testText(){
        return "test/testText";
    }

    @RequestMapping("/testSelect")
    public String testSelect(){
        return "test/testSelect";
    }

}
