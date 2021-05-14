package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Account;
import com.ly.lit.entity.Adminclass;
import com.ly.lit.entity.Users;
import com.ly.lit.service.AccountService;
import com.ly.lit.service.AdminclassService;
import com.ly.lit.service.UsersService;
import com.ly.lit.utils.UploadUtils;
import com.ly.lit.vo.AccountVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
@RequestMapping("/users")
public class UsersController {

    @Autowired
    private UsersService usersService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private AdminclassService adminclassService;

    @CrossOrigin
    @ResponseBody
    @RequestMapping("/list")
    public Map<String,Object> toList(@RequestParam(value = "page",defaultValue = "1") Integer pageNo,
                                     @RequestParam(value = "limit",defaultValue = "10") Integer pageSize,
                                     @RequestParam(value = "content",required = false) String content,
                                     Model model, HttpServletRequest request){

        System.out.println("page"+pageNo);
        System.out.println("limit"+pageSize);

        Map<String,Object> map = new HashMap<>();
        Page<AccountVo> page = new Page<AccountVo>(pageNo,pageSize);

        if(content == null || content.equals("")){

            usersService.getListPages(page,null);

        }else {
            usersService.getListPages(page,content);
            model.addAttribute("content",content);
        }
        map.put("code",0);
        map.put("msg","");
        map.put("count",page.getTotal());
        map.put("data",page.getRecords());

//        model.addAttribute("pageSize",page.getSize());
//        model.addAttribute("count",page.getTotal());
//        model.addAttribute("pageNo",page.getCurrent());
//        model.addAttribute("pages",page.getPages());
//        model.addAttribute("list",page.getRecords());
        return map;
    }


    @RequestMapping("/personPage")
    public String getById(Integer id,Model model){

        AccountVo accountVo = usersService.getAccountVoById(id);
        model.addAttribute("accountVo",accountVo);
        return "personPage";
    }

    @RequestMapping("/touploadIcon")
    public String touploadIcon(){

        return "uploadIcon";
    }

    @ResponseBody
    @RequestMapping("/personInfo")
    public boolean getById(Account account,Users users,Model model,HttpSession session){

        System.out.println(account);
        users.setId(account.getUserid());
        System.out.println(users);
        boolean AC =  accountService.saveOrUpdate(account);
        boolean US =  usersService.saveOrUpdate(users);

        session.setAttribute("ACCOUNT_SESSION",account);

        return AC || US;
    }

    @ResponseBody
    @RequestMapping("/cen")
    public AccountVo cen(Integer id,Model model){

        AccountVo accountVo = usersService.getAccountVoById(id);
        model.addAttribute("accountVo",accountVo);
        return accountVo;
    }


    @RequestMapping("/listpage")
    public String toList(){
        return "user/list";
    }

    @RequestMapping("/toaddAccount")
    public String toaddAccount(){
        return "user/addAccount";
    }

    @RequestMapping("/toaddUser")
    public String toaddUser(Integer userid,Model model){
        model.addAttribute("userid",userid);
        return "user/addUser";
    }

    @RequestMapping("/toedit")
    public String toedit(){
        return "user/edit";
    }

    @ResponseBody
    @RequestMapping("/addAccount")
    public Map<String,Object> addAccount(Account account){
        Map<String,Object> map = new HashMap<>();
        System.out.println("=========="+account);
        if(account.getUsername() == null || account.getUsername().equals("")){
            account.setUsername(account.getAccount());
        }
        if(account.getPic() == null || account.getPic().equals("")){
            account.setPic("/images/001.gif");
        }

        System.out.println(account);
        Users users = new Users();
        users.setRemark("管理员");
        usersService.save(users);
        System.out.println(users);
        account.setRole(2);
        account.setUserid(users.getId());
        accountService.save(account);

        map.put("code",0);
        map.put("msg","注册成功");
        map.put("data",account);

        return map;
    }

    @ResponseBody
    @RequestMapping("/addUser")
    public Map<String,Object> addUser(Users users){
        Map<String,Object> map = new HashMap<>();
        System.out.println("======="+users);

//        if(users.getInclass() != null && !users.getInclass().equals("0") && !users.getInclass().equals("")){
//            Adminclass adminclass = adminclassService.getById(users.getInclass());
//            users.setInclass(adminclass.getClassnum());
//        }


        usersService.saveOrUpdate(users,new QueryWrapper<Users>().eq("id",users.getId()));
        System.out.println(users);
        map.put("code",0);
        map.put("msg","添加成功");
        map.put("data",null);
        return map;
    }


    @ResponseBody
    @RequestMapping("/delete")
    public String delete(Integer id){

        System.out.println(id);
        Account account = accountService.getById(id);
        accountService.removeById(id);
        usersService.removeById(account.getUserid());

        return "true";
    }

    @ResponseBody
    @RequestMapping("/deleteIds")
    public String deleteIds(@RequestParam(value = "ids[]") Integer[] ids){
        System.out.println(Arrays.toString(ids));

        for (Integer id : ids){
            Account account = accountService.getById(id);
            Integer userid = account.getUserid();
            accountService.removeById(id);
            if(userid != null){
                usersService.removeById(userid);
            }
        }
        return "true";
    }



    @ResponseBody
    @RequestMapping("/editUser")
    public Map<String,Object> editUser(Account account,Users users){
        Map<String,Object> map = new HashMap<>();
        System.out.println("====000==="+account);
        System.out.println("====000==="+users);


        users.setId(account.getUserid());
        usersService.saveOrUpdate(users);

        if(account.getPassword() == null || account.getPassword().equals("")){
            account.setPassword(null);
        }
        System.out.println("======="+account);
        System.out.println("======="+users);
        accountService.saveOrUpdate(account);

        map.put("code",0);
        map.put("msg","添加成功");
        map.put("data",account);
        return map;
    }


    @ResponseBody
    @RequestMapping("/registerAccount")
    public Map<String,Object> registerAccount(Account account, String phoneOReamail, String vercode, HttpSession session){
        Map<String,Object> map = new HashMap<>();

        String regex = "^1\\d{10}$";
        String pore_code = (String) session.getAttribute("PORE_CODE");

        System.out.println(account);
        System.out.println(phoneOReamail);
        System.out.println(vercode);
        vercode = phoneOReamail+"&"+vercode;
        if(!vercode.equals(pore_code)){
            map.put("msg","验证码错误");
            map.put("data",false);
            return map;
        }
        Account account1 = accountService.getOne(new QueryWrapper<Account>().eq("account",account.getAccount()),false);
        if(account1 != null){
            map.put("msg","该账号已被注册");
            map.put("data",false);
            return map;
        }


        System.out.println("=========="+account);
        if(account.getUsername() == null || account.getUsername().equals("")){
            account.setUsername(account.getAccount());
        }
        if(account.getPic() == null || account.getPic().equals("")){
            account.setPic("/images/001.gif");
        }

        System.out.println(account);
        Users users = new Users();
        if(phoneOReamail.matches(regex)){
            users.setPhone(phoneOReamail);
        }else {
            users.setEmail(phoneOReamail);
        }
        usersService.save(users);
        System.out.println(users);

        account.setRole(2);
        account.setUserid(users.getId());

        accountService.save(account);

        map.put("code",0);
        map.put("msg","注册成功");
        map.put("data",users.getId());

        return map;
    }


    @ResponseBody
    @RequestMapping("/registerUser")
    public Map<String,Object> registerUser(Users users){
        Map<String,Object> map = new HashMap<>();
        System.out.println("======="+users);

        usersService.saveOrUpdate(users,new QueryWrapper<Users>().eq("id",users.getId()));
        System.out.println(users);
        map.put("code",0);
        map.put("msg","添加成功");
        map.put("data",null);
        return map;
    }

    @ResponseBody
    @RequestMapping("/rePassword")
    public boolean rePassword(Integer accountid,String password){

        System.out.println(accountid + "===" + password);

        return  accountService.update(new UpdateWrapper<Account>().set("password",password).eq("id",accountid));
    }


    @ResponseBody
    @RequestMapping("/uploads")
    public Map<String,Object> uploads(MultipartFile file,HttpSession session){

        Account account = (Account) session.getAttribute("ACCOUNT_SESSION");
        Map<String,Object> map = new HashMap<>();
        String path =  "/upload/img";
        if(account == null){
            map.put("code",0);
            map.put("msg","未登录");
            map.put("data",false);
            return map;
        }
        if(account.getPic() != null){
            String[] strs = account.getPic().split("/");
            String oldname = strs[strs.length-1];
            UploadUtils.delFile(path,oldname);
        }

        String fileName = file.getOriginalFilename();
        System.out.println("----"+fileName);
        String filename = UploadUtils.upload(path,file);

        account.setPic("/img/"+filename);
        accountService.saveOrUpdate(account);
        session.setAttribute("ACCOUNT_SESSION", account);
        map.put("code",0);
        map.put("msg","上传成功");
        map.put("data",filename);

        return map;
    }







}

