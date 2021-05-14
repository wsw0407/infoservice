package com.ly.lit.controller;


import com.ly.lit.entity.Account;
import com.ly.lit.entity.Comment;
import com.ly.lit.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-12
 */
@Controller
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    private CommentService commentService;


    @ResponseBody
    @RequestMapping("/add")
    public boolean addComment(Comment comment, HttpSession session){
        //   暂未登录静态用户评论
        Account account = (Account) session.getAttribute("ACCOUNT_SESSION");
        if(account == null){
            return  false;
        }
        comment.setFromAid(account.getId());

        System.out.println(comment);
        comment.setCreatdate(new Date());
        return commentService.saveOrUpdate(comment);
    }

    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(Integer id){
        //   暂未登录静态用户评论
        System.out.println(id);
        return commentService.removeById(id);
    }


}

