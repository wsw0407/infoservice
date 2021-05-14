package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Comment;
import com.ly.lit.entity.Topics;
import com.ly.lit.service.AccountService;
import com.ly.lit.service.CommentService;
import com.ly.lit.service.TopicsService;
import com.ly.lit.service.TopictypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("front")
public class FrontController {

    @Autowired
    private TopicsService topicsService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private TopictypeService topictypeService;


    @RequestMapping("index")
    public String front(){
        return "front/index";
    }


    @RequestMapping("xyfc")
    public String xyfc(){
        return "front/xyfc";
    }

    @RequestMapping("notice")
    public String notice(){
        return "front/notice";
    }


    @RequestMapping("yqsk")
    public String yqsk(){
        return "front/yqsk";
    }

    @RequestMapping("lypl")
    public String lypl(){
        return "front/lypl";
    }

    @RequestMapping("kcxx")
    public String kcxx(){
        return "front/kcxx";
    }


    @RequestMapping("/frontTopics")
    public String diaplay(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                          @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                          @RequestParam(value = "content",required = false) String content,
                          Model model){

        System.out.println("page"+pageNo);
        System.out.println("limit"+pageSize);
        System.out.println("content"+content);

        Page<Topics> page = new Page<>(pageNo,pageSize);

        if(content == null || content.equals("")){
            topicsService.getListPages(page,null);
        }else {
            topicsService.getListPages(page,content);
            model.addAttribute("content",content);
        }

        List<Topics> newlist = new ArrayList<>();
        List<Topics> list = page.getRecords();
        for (Topics topics : list){
            List<Comment> comList = commentService.list(new QueryWrapper<Comment>().eq("topic_id",topics.getId()));
            List<Comment> newcomList = new ArrayList<>();
            for (Comment comment : comList){
                if(comment.getFromAid() != null && accountService.getById(comment.getFromAid()) != null){
                    comment.setFromUsername(accountService.getById(comment.getFromAid()).getUsername());
                }
                if(comment.getToUid() != null && accountService.getById(comment.getToUid()) != null){
                    comment.setToUsername(accountService.getById(comment.getToUid()).getUsername());
                }
                newcomList.add(comment);
            }
            topics.setConList(newcomList);
            newlist.add(topics);
        }



        model.addAttribute("typelist",topictypeService.list());
        model.addAttribute("pageSize",page.getSize());
        model.addAttribute("pageNo",page.getCurrent());
        model.addAttribute("count",page.getTotal());
        model.addAttribute("pages",page.getPages());
        model.addAttribute("list",page.getRecords());

        return "front/frontTopics";
    }



}
