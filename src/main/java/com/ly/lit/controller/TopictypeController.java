package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ly.lit.entity.Reslinktype;
import com.ly.lit.entity.Resourcestype;
import com.ly.lit.entity.Topics;
import com.ly.lit.entity.Topictype;
import com.ly.lit.service.TopicsService;
import com.ly.lit.service.TopictypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-12
 */
@Controller
@RequestMapping("/topictype")
public class TopictypeController {

    @Autowired
    private TopictypeService topictypeService;

    @Autowired
    private TopicsService topicsService;

    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> list(){

        Map<String,Object> map = new HashMap<>();
        List<Topictype> list = topictypeService.list();
        map.put("code",0);
        map.put("msg","");
        map.put("count",list.size());
        map.put("data",list);

        return map;
    }

    @RequestMapping("/listpage")
    public String toList(){
        return "topictype/list";
    }


    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(Integer id){
        System.out.println(id);
        Topics topics = topicsService.getOne(new QueryWrapper<Topics>().eq("topic_type",id),false);

        if(topics != null){
            topics.setTopicType(null);
            topicsService.updateById(topics);
        }

        return topictypeService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/edit")
    public boolean edit(Topictype topictype){
        System.out.println(topictype);

        return topictypeService.saveOrUpdate(topictype);
    }

    @ResponseBody
    @RequestMapping("/add")
    public boolean add(Topictype topictype){
        System.out.println(topictype);

        return topictypeService.saveOrUpdate(topictype);
    }

}

