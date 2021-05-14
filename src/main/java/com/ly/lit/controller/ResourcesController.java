package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.*;
import com.ly.lit.service.ResaccessService;
import com.ly.lit.service.ReslinktypeService;
import com.ly.lit.service.ResourcesService;
import com.ly.lit.utils.UploadUtils;
import com.ly.lit.vo.AccountVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.util.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-10
 */
@Controller
@RequestMapping("/resources")
public class ResourcesController {


    @Autowired
    private ResourcesService resourcesService;

    @Autowired
    private ResaccessService resaccessService;

    @Autowired
    private ReslinktypeService reslinktypeService;

    @CrossOrigin
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
        Page<Resources> page = new Page<>(pageNo,pageSize);

        if(content == null || content.equals("")){
            resourcesService.getListPages(page,null);
        }else {
            resourcesService.getListPages(page,content);
            model.addAttribute("content",content);
        }
        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",page.getRecords());

        return map;
    }

    @ResponseBody
    @RequestMapping("/listById")
    public Map<String,Object> listById(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                       @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                       @RequestParam(value = "content",required = false) String content,
                                       @RequestParam(value = "id",required = false)Integer id,
                                       HttpSession session,
                                       Model model){

        System.out.println("page"+pageNo);
        System.out.println("limit"+pageSize);
        System.out.println("content"+content);
        Map<String,Object> map = new HashMap<>();

        if(id == null){
            Account account = (Account) session.getAttribute("ACCOUNT_SESSION");
            if(account != null){
                id=account.getId();
            }
            if(id == null){
                map.put("code",0);
                map.put("msg","未登录");
                map.put("count",0);
                map.put("data",null);
                return map;
            }
        }

        Page<Resources> page = new Page<>(pageNo,pageSize);

        if(content == null || content.equals("")){
            resourcesService.getListPagesById(page,id,null);
        }else {
            resourcesService.getListPagesById(page,id,content);
            model.addAttribute("content",content);
        }
        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",page.getRecords());

        return map;
    }

    @RequestMapping("/displayList")
    public String displayList(){
        return "resources/displayList";
    }

    @RequestMapping("/personResources")
    public String personResources(){
        return "resources/personResources";
    }


    @RequestMapping("/listpage")
    public String toList(){
        return "resources/list";
    }


    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){
        System.out.println(id);
        resourcesService.removeById(id);
        return "true";
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));
        for (Integer resId : ids){
            reslinktypeService.removeById(resId);
        }
        resourcesService.removeByIds(Arrays.asList(ids));
        return "true";
    }

    @RequestMapping("/toadd")
    public String toaddUser(Model model){

        return "resources/addResources";
    }

    @ResponseBody
    @RequestMapping("/accessList")
    public List<Resaccess> accessList(){
        List<Resaccess> list = resaccessService.list();
        return list;
    }

    @RequestMapping("/add")
    public String add(Resources resources, Integer[] type, MultipartFile file,Model model,HttpSession session){

        String path =  "/upload/file";
        String fileName = file.getOriginalFilename();
        System.out.println("----"+fileName);
        Account account = (Account) session.getAttribute("ACCOUNT_SESSION");

        if(account == null){
            model.addAttribute("msg","未登录");
            return "resources/addResources";
        }

        if(resources.getAccess() == 1){
            String filename = UploadUtils.upload(path,file);
            if (filename != null){
                resources.setContent(filename);
            }
        }

        resources.setUploadtime(new Date());
        resources.setAccountId(account.getId());
        resourcesService.save(resources);

        Integer resourcesId = resources.getId();
        for (Integer typeid : type){
            Reslinktype reslinktype = new Reslinktype();
            reslinktype.setResuorcceid(resourcesId);
            reslinktype.setTypeid(typeid);
            reslinktypeService.saveOrUpdate(reslinktype);
        }

        return "resources/list";
    }

    @ResponseBody
    @RequestMapping("/filesExists")
    public boolean filesExists(String filename){

        return UploadUtils.filesExists("/upload/file",filename);
    }

    @RequestMapping("/downLoad")
    public ResponseEntity<byte[]> download(String filename) throws Exception{
        System.out.println(filename);

        return  UploadUtils.download("/upload/file",filename);
    }


    @RequestMapping("/toedit")
    public String toedit(Integer id,Model model){
        System.out.println(id);
        model.addAttribute("resId",id);
        return  "resources/editResources";
    }

    @ResponseBody
    @RequestMapping("/editinfo")
    public Resources editinfo(Integer id){
        System.out.println(id);
        Resources resources = resourcesService.getById(id);
        List<Reslinktype> rltypelist = reslinktypeService.list(new QueryWrapper<Reslinktype>().eq("resuorcceid",id));
        List<Resourcestype> typelist  = new ArrayList<>();
        for (Reslinktype reslinktype : rltypelist){
            Resourcestype type = new Resourcestype();
            type.setId(reslinktype.getTypeid());
            typelist.add(type);
        }
        resources.setTypelist(typelist);

        return resources;
    }

    @ResponseBody
    @RequestMapping("/edit")
    public String edit(Resources resources, Integer[] type, MultipartFile file){
        String path =  "/upload/file";
        String fileName = file.getOriginalFilename();
        System.out.println(file.getOriginalFilename()+"fileName.equals()="+fileName.equals(""));
        System.out.println(resources);
        System.out.println(Arrays.toString(type));

        if(resources.getAccess() == 1 && !fileName.equals("")){

            //UploadUtils.delFile(path,resources.getContent());

            String filename = UploadUtils.upload(path,file);
            if (filename != null){
                resources.setContent(filename);
            }
        }

        Integer resourcesId = resources.getId();
        reslinktypeService.removeById(resourcesId);

        for (Integer typeid : type){
            Reslinktype reslinktype = new Reslinktype();
            reslinktype.setResuorcceid(resourcesId);
            reslinktype.setTypeid(typeid);
            reslinktypeService.save(reslinktype);
        }

        resourcesService.saveOrUpdate(resources);
        return "redirect:/resources/toedit?id="+resources.getId();
    }


}

