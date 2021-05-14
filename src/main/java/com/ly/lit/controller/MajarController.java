package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Adminclass;
import com.ly.lit.entity.Majar;
import com.ly.lit.entity.Users;
import com.ly.lit.service.AdminclassService;
import com.ly.lit.service.MajarService;
import com.ly.lit.vo.AccountVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-03
 */
@Controller
@RequestMapping("/majar")
public class MajarController {


    @Autowired
    private MajarService majarService;

    @Autowired
    private AdminclassService adminclassService;

    @ResponseBody
    @RequestMapping("/listAll")
    public List<Majar> findAll(){

        QueryWrapper<Majar> wrapper = new QueryWrapper<>();
        wrapper.ne("id",1);
        List<Majar> list = majarService.list(wrapper);

        return  list;
    }


    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> toList(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                     @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                     @RequestParam(value = "content",required = false) String content,
                                     Model model, HttpServletRequest request){

        Map<String,Object> map = new HashMap<>();
        Page<Majar> page = new Page<Majar>(pageNo,pageSize);

        QueryWrapper<Majar> wrapper = new QueryWrapper<>();
        wrapper.ne("id",1);
        if(content == null || content.equals("")){
            majarService.page(page,wrapper.orderByAsc("institnum"));

        }else {
            majarService.page(page,wrapper.like("institute",content).or().like("majarname",content).orderByAsc("institnum"));
            model.addAttribute("content",content);
        }

        List<Majar> list = new ArrayList<>();
        for (Majar majar : page.getRecords()){
            QueryWrapper<Adminclass> wrapper1 = new QueryWrapper<Adminclass>().eq("majar_id",majar.getId());
            majar.setClassList(adminclassService.list(wrapper1));
            list.add(majar);
        }

        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",list);

        return map;
    }

    @RequestMapping("/listpage")
    public String toList(){
        return "majar/list";
    }

    @RequestMapping("/toadd")
    public String toadd(){
        return "majar/add";
    }

    @RequestMapping("/toedit")
    public String toedit(Integer id,Model model){

        model.addAttribute("majar",majarService.getById(id));
        return "majar/add";
    }


    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){

        System.out.println(id);
        adminclassService.remove(new QueryWrapper<Adminclass>().eq("majar_id",id));
        majarService.removeById(id);

        return "true";
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));
        for (Integer id : ids){
            adminclassService.remove(new QueryWrapper<Adminclass>().eq("majar_id",id));
            majarService.removeById(id);
        }
        return "true";
    }


    @ResponseBody
    @RequestMapping("/add")
    public Map<String,Object> add(Majar majar){
        Map<String,Object> map = new HashMap<>();
        System.out.println("======="+majar);

        majarService.saveOrUpdate(majar);

        map.put("code",0);
        map.put("msg","添加成功");
        map.put("data",null);
        return map;
    }



}

