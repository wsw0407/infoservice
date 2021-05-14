package com.ly.lit.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("personal")
public class PersonController {


    @RequestMapping("topics")
    public String personaltopics(){

        return "users/frontTopics";
    }

    @RequestMapping("personClass")
    public String personClass(){

        return "users/personClass";
    }


}
