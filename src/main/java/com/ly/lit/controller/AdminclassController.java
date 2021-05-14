package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ly.lit.entity.Adminclass;
import com.ly.lit.entity.Majar;
import com.ly.lit.service.AdminclassService;
import com.ly.lit.service.MajarService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-04
 */
@Controller
@RequestMapping("/adminclass")
public class AdminclassController {

    @Autowired
    private AdminclassService adminclassService;

    @Autowired
    private MajarService majarService;

    @ResponseBody
    @RequestMapping("/listById")
    public List<Adminclass> findList(Integer id){

        System.out.println(id);
        QueryWrapper<Adminclass> wrapper = new QueryWrapper<>();
        wrapper.eq("majar_id",id);
        List<Adminclass> list = adminclassService.list(wrapper);

        return  list;
    }

    @ResponseBody
    @RequestMapping("/listAll")
    public List<Adminclass> listAll(){

        QueryWrapper<Adminclass> wrapper = new QueryWrapper<Adminclass>()
                .orderByDesc("(SUBSTRING(classnum,2,2))")
                .orderByAsc("(SUBSTRING(classnum,4,2))")
                .orderByAsc("(SUBSTRING(classnum,6,2))");
        List<Adminclass> list = adminclassService.list(wrapper);

        return  list;
    }

    @RequestMapping("/toclassList")
    public String toclassList(Integer id, Model model){

//        QueryWrapper<Adminclass> wrapper = new QueryWrapper<Adminclass>().eq("majar_id",id).orderByDesc("(SUBSTRING(classnum,2,2))");
//        List<Adminclass> list = adminclassService.list(wrapper);
        Majar majar = majarService.getById(id);
        model.addAttribute("majar",majar);
        model.addAttribute("majarId",id);

        return  "majar/classList";
    }

    @ResponseBody
    @RequestMapping("/classList")
    public  Map<String,Object> classList(Integer id){
        Map<String,Object> map = new HashMap<>();
        QueryWrapper<Adminclass> wrapper = new QueryWrapper<Adminclass>();
        wrapper.eq("majar_id",id)
               .orderByDesc("(SUBSTRING(classnum,2,2))")
               .orderByAsc("(SUBSTRING(classnum,4,2))")
               .orderByAsc("(SUBSTRING(classnum,6,2))");

        List<Adminclass> list = adminclassService.list(wrapper);
        Majar majar = majarService.getById(id);


        map.put("code",0);
        map.put("msg","");
        map.put("count",list.size());
        map.put("data",list);

        return  map;
    }


    @ResponseBody
    @RequestMapping("/add")
    public  Map<String,Object> add(Adminclass adminclass){
        Map<String,Object> map = new HashMap<>();

        System.out.println(adminclass);
        adminclassService.saveOrUpdate(adminclass);

        map.put("code",0);
        map.put("msg","添加成功");
        map.put("data",null);

        return  map;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){
        System.out.println(id);
        adminclassService.removeById(id);

        return "true";
    }
    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){

        System.out.println(Arrays.toString(ids));
        adminclassService.removeByIds(Arrays.asList(ids));
        return "true";
    }





}

