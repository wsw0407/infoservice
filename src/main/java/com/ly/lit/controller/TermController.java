package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Account;
import com.ly.lit.entity.Term;
import com.ly.lit.entity.Users;
import com.ly.lit.service.TermService;
import com.ly.lit.vo.AccountVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-19
 */
@Controller
@RequestMapping("/term")
public class TermController {

    @Autowired
    private TermService termService;

    @ResponseBody
    @RequestMapping("/listAll")
    public List<Term> listAll(){

        return  termService.list(new QueryWrapper<Term>().orderByDesc("time"));
    }

    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> list(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                   @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                   @RequestParam(value = "content",required = false) String content
                                   ){

        Map<String,Object> map = new HashMap<>();
        Page<Term> page = new Page<Term>(pageNo,pageSize);

        System.out.println(content);
        if(content == null || content.equals("")){
            termService.page(page,new QueryWrapper<Term>().orderByDesc("time"));

        }else {
            termService.page(page,new QueryWrapper<Term>().like("term",content).orderByDesc("time"));
        }


        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",page.getRecords());

        return  map;
    }


    @RequestMapping("/listpage")
    public String toList(){
        return "course/termList";
    }



    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){

        System.out.println(id);
        termService.removeById(id);

        return "true";
    }

    @ResponseBody
    @RequestMapping("/add")
    public Map<String,Object> add(Term term){
        Map<String,Object> map = new HashMap<>();
        System.out.println("======="+term);
        if(term.getTime() == null){
            System.out.println("=======");
            term.setTime(new Date());
        }

        termService.saveOrUpdate(term);
        map.put("code",0);
        map.put("msg","添加成功");
        map.put("data",null);
        return map;
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));

        termService.removeByIds(Arrays.asList(ids));

        return "true";
    }



}

