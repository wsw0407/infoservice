package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ly.lit.entity.*;
import com.ly.lit.service.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("statics")
public class StaticsController {

    @Autowired
    private UservisitService uservisitService;

    @Autowired
    private ResourcesService resourcesService;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private UsersService usersService;

    @Autowired
    private TopicsService topicsService;



    @RequestMapping("/display")
    public String dispaly(Model model){
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM");
        String dataStr = sdf.format(new Date());
        float resourcesCountMounth = resourcesService.count(new QueryWrapper<Resources>().eq("SUBSTRING(uploadtime, 1, 4)",dataStr.substring(0,4)).eq("SUBSTRING(uploadtime, 6, 2)",dataStr.substring(5)));
        int resourcesCount = resourcesService.count();

        float resources = Math.round((resourcesCountMounth/resourcesCount)*1000)/10;

        float noticeCounting = noticeService.count(new QueryWrapper<Notice>().eq("remark",2));
        int noticeCount = noticeService.count();
        float notice = Math.round((noticeCounting/noticeCount)*1000)/10;

        //float accountCounting = uservisitService.list(new QueryWrapper<Uservisit>().groupBy("loginname")).size();
        int accountCount = accountService.count();
        //float account = Math.round((accountCounting/accountCount)*1000)/10;
        //用户统计量
        //model.addAttribute("accountCounting",account);
        model.addAttribute("accountCount",accountCount);

        //公告统计量
        model.addAttribute("noticeCounting",notice);
        model.addAttribute("noticeCount",noticeCount);

        //资源统计量
        model.addAttribute("resourcesCountMounth",resources);
        model.addAttribute("resourcesCount",resourcesCount);

        //访问量统计量
        Integer visitCountMounth = uservisitService.count(new QueryWrapper<Uservisit>().eq("SUBSTRING(login_time, 1, 4)",dataStr.substring(0,4)).eq("SUBSTRING(login_time, 6, 2)",dataStr.substring(5)));

        model.addAttribute("visitCountMounth",visitCountMounth);
        model.addAttribute("visitCount",uservisitService.count());

        //本月同年占比
        model.addAttribute("resourcesPercent",resourcesPercent(dataStr));
        model.addAttribute("visitPercent",visitPercent(dataStr,visitCountMounth));
        model.addAttribute("topicsPercent",topicsPercent(dataStr));

        return "statics/statics";
    }


    @ResponseBody
    @RequestMapping("/sexStatis")
    public List<Statics> sexStatis(){

        QueryWrapper<Users> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("sex","COUNT(*) realname").groupBy("sex");
        List<Users> list = usersService.list(queryWrapper);
        List<Statics> liseSex = new ArrayList<>();

        for (Users users:list){

            Statics statics = new Statics();
            if(users.getSex() == null){
                continue;
            }
            else if(users.getSex() == 1){
                statics.setName("男");
            }else if(users.getSex() == 2){
                statics.setName("女");
            }

            statics.setValue(users.getRealname());
            liseSex.add(statics);
        }
        return liseSex;
    }

    @ResponseBody
    @RequestMapping("/personDistribut")
    public List<Statics> personDistribut(){

        List<Users> list = usersService.list(new QueryWrapper<Users>().select("SUBSTRING(address,1,2) address","COUNT(1) remark").groupBy("SUBSTRING(address,1,2)"));
        List<Statics> staticsList = new ArrayList<>();

        for (Users users : list){

            if(users.getAddress() != null && !users.getAddress().equals("")){
                Statics statics = new Statics();
                statics.setName(users.getAddress());
                statics.setValue(users.getRemark());
                staticsList.add(statics);
            }

        }

        return staticsList;
    }

    @ResponseBody
    @RequestMapping("/lineStatis")
    public Map<String,int[]> lineStatis(){
        Map<String,int[]> map = new HashMap<>();
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM");
        String dataStr = sdf.format(new Date());

        map.put("visitdata",visitStatis(dataStr));
        map.put("topicdata",topicsStatis(dataStr));
        map.put("resourcedata",resourceStatis(dataStr));

        return map;
    }


    public int[]  resourceStatis(String dataStr){


        int[] resourcedata = new int[12];


        QueryWrapper<Resources> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("SUBSTRING(uploadtime, 6, 2) remark","COUNT(1) id").eq("SUBSTRING(uploadtime, 1, 4)",dataStr.substring(0,4)).groupBy("SUBSTRING(uploadtime, 6, 2)");
        List<Resources> resourcess = resourcesService.list(queryWrapper);

        for (Resources resources : resourcess){
            if (StringUtils.isNumeric(resources.getRemark())) {
                resourcedata[Integer.parseInt(resources.getRemark())-1]=resources.getId();
            }
        }

        return resourcedata;
    }




    public int[]  topicsStatis(String dataStr){

        int[] topicdata = new int[12];


        QueryWrapper<Topics> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("SUBSTRING(releasetime, 6, 2) comtent","COUNT(1) id").eq("SUBSTRING(releasetime, 1, 4)",dataStr.substring(0,4)).groupBy("SUBSTRING(releasetime, 6, 2)");
        List<Topics> topicses = topicsService.list(queryWrapper);

        for (Topics topics : topicses){
            if (StringUtils.isNumeric(topics.getComtent())) {
                topicdata[Integer.parseInt(topics.getComtent())-1]=topics.getId();
            }
        }

        return topicdata;
    }


    public int[] visitStatis(String dataStr){
        int[] visitdata = new int[12];


        QueryWrapper<Uservisit> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("SUBSTRING(login_time, 6, 2) login_time","COUNT(1) id").eq("SUBSTRING(login_time, 1, 4)",dataStr.substring(0,4)).groupBy("SUBSTRING(login_time, 6, 2)");
        List<Uservisit> uservisits = uservisitService.list(queryWrapper);

        for (Uservisit uservisit : uservisits){
            if (StringUtils.isNumeric(uservisit.getLoginTime())) {
                visitdata[Integer.parseInt(uservisit.getLoginTime())-1]=uservisit.getId();
            }
        }

        return visitdata;
    }


    public float resourcesPercent(String dataStr){


        float resourcesCountMounth = resourcesService.count(new QueryWrapper<Resources>().eq("SUBSTRING(uploadtime, 1, 4)",dataStr.substring(0,4)).eq("SUBSTRING(uploadtime, 6, 2)",dataStr.substring(5)));
        int resourcesCount = resourcesService.count(new QueryWrapper<Resources>().eq("SUBSTRING(uploadtime, 1, 4)",dataStr.substring(0,4)));
        float resourcesPercent = Math.round((resourcesCountMounth/resourcesCount)*1000)/10;


        return resourcesPercent;
    }

    public float visitPercent(String dataStr,Integer uservisitCountMounth){

        float countMounth = uservisitCountMounth;
        Integer uservisitCount = uservisitService.count(new QueryWrapper<Uservisit>().eq("SUBSTRING(login_time, 1, 4)",dataStr.substring(0,4)));
        float visitPercent = Math.round((countMounth/uservisitCount)*1000)/10;


        return visitPercent;
    }


    public float topicsPercent(String dataStr){


        float topicsCountMounth = topicsService.count(new QueryWrapper<Topics>().eq("SUBSTRING(releasetime, 1, 4)",dataStr.substring(0,4)).eq("SUBSTRING(releasetime, 6, 2)",dataStr.substring(5)));
        int topicsCount = topicsService.count(new QueryWrapper<Topics>().eq("SUBSTRING(releasetime, 1, 4)",dataStr.substring(0,4)));
        float topicsPercent = Math.round((topicsCountMounth/topicsCount)*1000)/10;


        return topicsPercent;
    }





}
