package com.ly.lit.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.*;
import com.ly.lit.service.NoticeService;
import com.ly.lit.service.NoticelinktypeService;
import com.ly.lit.service.NoticestatusService;
import com.ly.lit.service.NoticetypeService;
import com.ly.lit.utils.UploadUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.util.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-16
 */
@Controller
@RequestMapping("/notice")
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private NoticelinktypeService noticelinktypeService;

    @Autowired
    private NoticetypeService noticetypeService;

    @Autowired
    private NoticestatusService noticestatusService;

    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> toList(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                     @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                     @RequestParam(value = "content",required = false) String content,
                                     Model model){

        System.out.println("page"+pageNo);
        System.out.println("limit"+pageSize);
        System.out.println("content"+content);

        Map<String,Object> map = new HashMap<>();
        Page<Notice> page = new Page<>(pageNo,pageSize);

        if(content == null || content.equals("")){
            noticeService.getListPages(page,null);
        }else {
            noticeService.getListPages(page,content);
            model.addAttribute("content",content);
        }
        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",page.getRecords());
        map.put("pageTotal",page.getPages());

        return map;
    }

    @RequestMapping("/listPage")
    public String list(){
        return "notice/list";
    }

    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(Integer id){
        System.out.println(id);
        String path =  "/upload";
        Notice notice = noticeService.getById(id);
        noticelinktypeService.removeById(id);
        if(notice != null){
            UploadUtils.delFile(path,notice.getPic());
        }

        return noticeService.removeById(id);
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));
        String path =  "/upload";

        for (Integer noticeId : ids){
            noticelinktypeService.removeById(noticeId);
            Notice notice = noticeService.getById(noticeId);
            if(notice != null){
                UploadUtils.delFile(path,notice.getPic());
            }
        }
        noticeService.removeByIds(Arrays.asList(ids));
        return "true";
    }


    @RequestMapping("/toadd")
    public String toadd(Model model){

        model.addAttribute("status",noticestatusService.list());

        return "notice/add";
    }

    @RequestMapping("/add")
    public String add(Notice notice,String types){

        System.out.println(notice);
        System.out.println(types);

        notice.setReleasetime(new Date());
        noticeService.saveOrUpdate(notice);

        String[] type = types.split(",");
        for (String typeid : type){
            Noticelinktype noticelinktype = new Noticelinktype();
            noticelinktype.setNoticeid(notice.getId());
            noticelinktype.setTypeid(Integer.parseInt(typeid));
            noticelinktypeService.save(noticelinktype);
        }

        return "notice/add";
    }

    @ResponseBody
    @RequestMapping("/uploads")
    public Map<String,Object> uploads(MultipartFile file){

        Map<String,Object> map = new HashMap<>();

        String path =  "/upload/img";

        String fileName = file.getOriginalFilename();
        System.out.println("----"+fileName);
        String filename = UploadUtils.upload(path,file);

        map.put("code",0);
        map.put("msg","");
        map.put("data",filename);


        return map;
    }

    @ResponseBody
    @RequestMapping("/uploadEdit")
    public Map<String,Object> uploadEdit(MultipartFile file,String oldFile){

        Map<String,Object> map = new HashMap<>();
        String path =  "/upload/img";
        System.out.println(oldFile+"==========================");
        String[] strs = oldFile.split("/");
        String oldname = strs[strs.length-1];
        UploadUtils.delFile(path,oldname);


        String fileName = file.getOriginalFilename();
        System.out.println("----"+fileName);
        String filename = UploadUtils.upload(path,file);

        map.put("code",0);
        map.put("msg","");
        map.put("data",filename);

        return map;
    }


    @RequestMapping("/toedit")
    public String toedit(Integer id,Model model,String pageInfo){

        Notice notice = noticeService.getById(id);
        List<Noticetype> typeList = notice.getTypelist();
        Integer[] types = new Integer[typeList.size()];
        for (int i = 0; i < typeList.size(); i++) {
            types[i] = typeList.get(i).getId();
        }

        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("typeList",Arrays.toString(types));
        model.addAttribute("notice",notice);
        model.addAttribute("status",noticestatusService.list());

        return "notice/edit";
    }


    @RequestMapping("/edit")
    public String edit(Notice notice,String types,String pageInfo){

        System.out.println(notice);
        System.out.println(types);

        noticeService.saveOrUpdate(notice);


        Integer noticeId = notice.getId();
        noticelinktypeService.removeById(noticeId);

        String[] type = types.split(",");
        for (String typeid : type){
            Noticelinktype noticelinktype = new Noticelinktype();
            noticelinktype.setNoticeid(notice.getId());
            noticelinktype.setTypeid(Integer.parseInt(typeid));
            noticelinktypeService.save(noticelinktype);
        }


        String[] page = pageInfo.split(",");
        System.out.println(Arrays.toString(page));

        return "redirect:/notice/listPage?id="+notice.getId();

    }


    @RequestMapping("/display")
    public String display(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                          @RequestParam(value = "limit",defaultValue = "4") Integer pageSize,
                          @RequestParam(value = "content",required = false) String content,
                          Model model){

        model.addAttribute("limit",pageSize);
        if(content != null && !content.equals("")){
            model.addAttribute("content",content);
        }

        return "notice/display";
    }


    @RequestMapping("/displayInfo")
    public String displayInfo(Integer id,Model model){

        Notice notice = noticeService.getById(id);

        model.addAttribute("notice",notice);

        return "notice/displayInfo";
    }


}

