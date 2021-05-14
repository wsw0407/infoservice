package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Reslinktype;
import com.ly.lit.entity.Resourcestype;
import com.ly.lit.service.ReslinktypeService;
import com.ly.lit.service.ResourcesService;
import com.ly.lit.service.ResourcestypeService;
import com.ly.lit.vo.AccountVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-10
 */
@Controller
@RequestMapping("/resourcestype")
public class ResourcestypeController {

    @Autowired
    private ResourcestypeService resourcestypeService;

    @Autowired
    private ReslinktypeService reslinktypeService;


    @ResponseBody
    @RequestMapping("/listAll")
    public List<Resourcestype> listAll(){
        return resourcestypeService.list();
    }

    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> list(){

        Map<String,Object> map = new HashMap<>();
        List<Resourcestype> list = resourcestypeService.list();
        map.put("code",0);
        map.put("msg","");
        map.put("count",list.size());
        map.put("data",list);

        return map;
    }


    @RequestMapping("/listpage")
    public String toList(){
        return "resourcetype/list";
    }


    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(Integer id){
        System.out.println(id);

        boolean delrel =  reslinktypeService.remove(new QueryWrapper<Reslinktype>().eq("typeid",id));
        boolean delres =  resourcestypeService.removeById(id);

        return (delrel && delres);
    }

    @ResponseBody
    @RequestMapping("/edit")
    public boolean edit(Resourcestype resourcestype){
        System.out.println(resourcestype);

        return resourcestypeService.saveOrUpdate(resourcestype);
    }

    @ResponseBody
    @RequestMapping("/add")
    public boolean add(Resourcestype resourcestype){
        System.out.println(resourcestype);

        return resourcestypeService.saveOrUpdate(resourcestype);
    }



}

