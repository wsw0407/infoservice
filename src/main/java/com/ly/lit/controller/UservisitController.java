package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Account;
import com.ly.lit.entity.Uservisit;
import com.ly.lit.service.UservisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-25
 */
@Controller
@RequestMapping("/uservisit")
public class UservisitController {

    @Autowired
    private UservisitService uservisitService;

    @ResponseBody
    @RequestMapping("list")
    public Map<String,Object> toList(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                     @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                     @RequestParam(value = "content",required = false) String content,
                                     Model model){
        Map<String,Object> map = new HashMap<>();
        Page<Uservisit> page = new Page<Uservisit>(pageNo,pageSize);

        if(content == null || content.equals("")){
            uservisitService.page(page,new QueryWrapper<Uservisit>().orderByDesc("id"));
        }else {
            QueryWrapper<Uservisit> wrapper = new QueryWrapper<Uservisit>();
            wrapper.like("loginname","%"+content+"%")
                    .or().like("visit_ip","%"+content+"%");

            uservisitService.page(page,wrapper);
            model.addAttribute("content",content);
        }

        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",page.getRecords());


        return map;
    }



    @RequestMapping("/listpage")
    public String toList(){
        return "uservisit/list";
    }


    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){

        System.out.println(id);
        uservisitService.removeById(id);

        return "true";
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));

        uservisitService.removeByIds(Arrays.asList(ids));
        return "true";
    }

}

