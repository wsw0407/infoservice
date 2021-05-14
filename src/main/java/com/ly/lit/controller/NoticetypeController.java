package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ly.lit.entity.Noticelinktype;
import com.ly.lit.entity.Noticetype;
import com.ly.lit.entity.Reslinktype;
import com.ly.lit.entity.Resourcestype;
import com.ly.lit.service.NoticelinktypeService;
import com.ly.lit.service.NoticetypeService;
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
 * @since 2021-04-16
 */
@Controller
@RequestMapping("/noticetype")
public class NoticetypeController {

    @Autowired
    private NoticetypeService noticetypeService;

    @Autowired
    private NoticelinktypeService noticelinktypeService;


    @ResponseBody
    @RequestMapping("/listAll")
    public List<Noticetype> listAll(){
        return noticetypeService.list();
    }


    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> list(){

        Map<String,Object> map = new HashMap<>();
        List<Noticetype> list = noticetypeService.list();
        map.put("code",0);
        map.put("msg","");
        map.put("count",list.size());
        map.put("data",list);

        return map;
    }

    @RequestMapping("/listpage")
    public String toList(){
        return "noticetype/list";
    }


    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(Integer id){
        System.out.println(id);

        boolean delrel =  noticelinktypeService.remove(new QueryWrapper<Noticelinktype>().eq("typeid",id));
        boolean delres =  noticetypeService.removeById(id);

        return (delrel && delres);
    }

    @ResponseBody
    @RequestMapping("/edit")
    public boolean edit(Noticetype noticetype){
        System.out.println(noticetype);

        return noticetypeService.saveOrUpdate(noticetype);
    }

    @ResponseBody
    @RequestMapping("/add")
    public boolean add(Noticetype noticetype){
        System.out.println(noticetype);

        return noticetypeService.saveOrUpdate(noticetype);
    }

}

