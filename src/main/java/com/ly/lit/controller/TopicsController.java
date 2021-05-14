package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Account;
import com.ly.lit.entity.Comment;
import com.ly.lit.entity.Resources;
import com.ly.lit.entity.Topics;
import com.ly.lit.service.AccountService;
import com.ly.lit.service.CommentService;
import com.ly.lit.service.TopicsService;
import com.ly.lit.service.TopictypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-12
 */
@Controller
@RequestMapping("/topics")
public class TopicsController {

    @Autowired
    private TopicsService topicsService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private TopictypeService topictypeService;

    @RequestMapping("/listPage")
    public String toList(){
        return "topics/list";
    }

    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> toList(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                     @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                     @RequestParam(value = "content",required = false) String content,
                                     Model model){

        System.out.println("limit"+pageSize);
        System.out.println("page"+pageNo);
        System.out.println("content"+content);

        Map<String,Object> map = new HashMap<>();
        Page<Topics> page = new Page<>(pageNo,pageSize);

        if(content == null || content.equals("")){
            topicsService.getListPages(page,null);
        }else {
            topicsService.getListPages(page,content);
        }

        List<Topics> list = page.getRecords();
        List<Topics> newlist = new ArrayList<>();
        for (Topics topics : list){

            List<Comment> comList = commentService.list(new QueryWrapper<Comment>().eq("topic_id",topics.getId()));
            List<Comment> newcomList = new ArrayList<>();
            for (Comment comment : comList){
                comment.setFromUsername(accountService.getById(comment.getFromAid()).getUsername());
                comment.setToUsername(accountService.getById(comment.getToUid()).getUsername());
                newcomList.add(comment);
            }
            topics.setConList(newcomList);
            newlist.add(topics);
        }

        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",newlist);

        return map;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(Integer id){
        System.out.println(id);
        commentService.remove(new QueryWrapper<Comment>().eq("topic_id",id));
        return topicsService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));

        for (Integer resId : ids){
            commentService.remove(new QueryWrapper<Comment>().eq("topic_id",resId));
        }
        topicsService.removeByIds(Arrays.asList(ids));
        return "true";
    }


    @RequestMapping("/diaplay")
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

        return "topics/diaplay";
    }


    @RequestMapping("/persondiaplay")
    public String persondiaplay(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                          @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                          @RequestParam(value = "content",required = false) String content,
                          @RequestParam(value = "id",required = false) Integer id,
                          HttpSession session
                          ,Model model){

        System.out.println("page"+pageNo);
        System.out.println("limit"+pageSize);
        System.out.println("content"+content);

        if(id == null){
            Account account = (Account) session.getAttribute("ACCOUNT_SESSION");
            if(account != null){
                id=account.getId();
            }
            if(id == null){
                model.addAttribute("msg","未登录");

                return "users/persontopics";
            }
        }

        Page<Topics> page = new Page<>(pageNo,pageSize);

        if(content == null || content.equals("")){
            topicsService.getListPagesById(page,id,null);
        }else {
            topicsService.getListPagesById(page,id,content);
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

        return "users/persontopics";
    }




    @ResponseBody
    @RequestMapping("/add")
    public boolean addTopic(Topics topics,HttpSession session){

        Account account = (Account) session.getAttribute("ACCOUNT_SESSION");

        if(account == null){
            return  false;
        }
        topics.setReleasetime(new Date());
        topics.setAccountId(account.getId());
        System.out.println(topics);


        return  topicsService.saveOrUpdate(topics);
    }


}

