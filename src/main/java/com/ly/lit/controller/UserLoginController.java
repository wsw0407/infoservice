package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ly.lit.entity.Account;
import com.ly.lit.entity.Users;
import com.ly.lit.entity.Uservisit;
import com.ly.lit.service.AccountService;
import com.ly.lit.service.SendInfoService;
import com.ly.lit.service.UsersService;
import com.ly.lit.service.UservisitService;
import com.ly.lit.utils.RegistRandomCode;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;
import eu.bitwalker.useragentutils.Version;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class UserLoginController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private UsersService usersService;

    @Autowired
    private SendInfoService sendInfoService;

    @Autowired
    private UservisitService uservisitService;


    @RequestMapping("/")
    public String tologin(){

        return "login";
    }

    @RequestMapping("/tologin")
    public String tologins(){

        return "login";
    }

    @ResponseBody
    @RequestMapping("/login")
    public Map<String,Object> login(String account, String password, HttpSession session,HttpServletRequest request){

        System.out.println(account+"====="+password);
        QueryWrapper<Account> wrapper = new QueryWrapper<>();
        wrapper.eq("account",account).eq("password",password);
        Map<String,Object> map = new HashMap();
        Account accounts = accountService.getOne(wrapper,false);
        if(accounts != null){
            getClientInfo(request,account);
            session.setAttribute("ACCOUNT_SESSION", accounts);
            if(accounts.getRole() == 1){
                map.put("role","admin");
            }
            map.put("isExist",true);
            return map;
        }else {
            map.put("isExist",false);
            return map;
        }
    }

    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session){

        session.removeAttribute("ACCOUNT_SESSION");
        Uservisit uservisit = (Uservisit) session.getAttribute("USERV_ISIT");
        if(uservisit != null){
            uservisit.setExitTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
            uservisitService.saveOrUpdate(uservisit);
        }

        return "redirect:/";
    }

    @RequestMapping("/toregister")
    public String toregister(){

        return "register";
    }



    @ResponseBody
    @RequestMapping("/getCode")
    public String getCode(String phoneOReamail,String way,HttpSession session) throws MessagingException {

        System.out.println(phoneOReamail+"==="+way);
        String code =  RegistRandomCode.getRegisNumCode();

        if(way != null && way.equals("email")){
             sendInfoService.sendEmails(phoneOReamail,code);

        }else {
             sendInfoService.sendPhone(phoneOReamail,new String[]{code,"1","??????3"});
        }
        //session.setMaxInactiveInterval(20*60);

        session.setAttribute("PORE_CODE",phoneOReamail+"&"+code);
        System.out.println(session.getAttribute("PORE_CODE"));
        return code;
    }


    @RequestMapping("/testReg")
    public String testReg(){

        return "test/testReg";
    }

    @RequestMapping("/toForgotPwd")
    public String toForgotPwd(){

        return "toForgotPwd";
    }

    @RequestMapping("/torePassword")
    public String rePassword(){

        System.out.println("=========");
        return "setting/rePassword";
    }

    @ResponseBody
    @RequestMapping("/isexist")
    public String isexist(String phoneOReamail){

       Users users = usersService.getOne(new QueryWrapper<Users>().eq("phone",phoneOReamail).or().eq("email",phoneOReamail),false);
        if(users == null){
            return "false";
        }
        return "true";
    }

    @ResponseBody
    @RequestMapping("/getAccountByPoe")
    public Account getAccountByPoe(String phoneOReamail){

        Users users = usersService.getOne(new QueryWrapper<Users>().eq("phone",phoneOReamail).or().eq("email",phoneOReamail),false);
        Account account = accountService.getOne(new QueryWrapper<Account>().eq("userid",users.getId()));
        return account;
    }


    public  void getClientInfo(HttpServletRequest request, String loginname){
        String agent =request.getHeader("User-Agent");
        System.out.println(agent);

        //User Agent????????????????????????????????? UA???????????????????????????????????????????????????
        //???????????????????????????????????????????????????CPU ??????????????????????????????
        //????????????????????????????????????????????????????????????
        UserAgent userAgent = UserAgent.parseUserAgentString(agent);

        // ???????????????
        Browser browser = userAgent.getBrowser();
        //System.out.println(browser.getName());
        // ?????????????????????
        Version bv = userAgent.getBrowserVersion();
        //System.out.println(bv.getVersion());
        // ??????????????????
        OperatingSystem os = userAgent.getOperatingSystem();
        //System.out.println(os.getName());

        String iphone = "";
        if (agent.contains("Windows NT")) {
            //pc????????????????????????
            String pc_regex = " \\((.*); ";
            Pattern pattern = Pattern.compile(pc_regex);
            Matcher matcher = pattern.matcher(agent);
            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "PC???";
        } else {
            String type = "";
            if (agent.contains("iPhone") || agent.contains("iPod") || agent.contains("iPad")) {
                type = "ios";
            } else if (agent.contains("Android") || agent.contains("Linux")) {
                type = "apk";
            } else if (agent.indexOf("micromessenger") > 0) {
                type = "wx";
            }
            String iphone_regex = "\\((.*)\\) Apple";
            Pattern pattern = Pattern.compile(iphone_regex);
            Matcher matcher = pattern.matcher(agent);

            while (matcher.find()) {
                iphone = matcher.group(1);
            }
            agent = "?????????" + type;
        }

        System.out.println(iphone);
        System.out.println(agent);

        System.out.println("---------------------??????ip--------------------------");
        String ipAddress = null;
        if (request.getHeader("x-forwarded-for") == null) {
            ipAddress = request.getRemoteAddr();
        } else {
            if (request.getHeader("x-forwarded-for").length() > 15) {
                String[] aStr = request.getHeader("x-forwarded-for").split(",");
                ipAddress = aStr[0];
            } else {
                ipAddress = request.getHeader("x-forwarded-for");
            }
        }
        System.out.println(ipAddress);

        // ??????UservisitInf
        Uservisit uservisitInf =new Uservisit();
        uservisitInf.setLoginname(loginname);
        uservisitInf.setLoginTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        uservisitInf.setExitTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
        uservisitInf.setVisitIp(ipAddress);
        uservisitInf.setUserAddress("");
        uservisitInf.setUserFrom(agent);
        uservisitInf.setBrowser(browser.getName());
        uservisitInf.setSystem(os.getName());
        uservisitInf.setVersion(bv.getVersion());
        uservisitInf.setIphone(iphone);

        // ???????????????
        uservisitService.save(uservisitInf);
        String s = null;
        try {
            s = new ObjectMapper().writeValueAsString(uservisitInf);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }

        // ??????redis
        // redisTemplate.opsForList().leftPush("users",s);
        // ?????????session

        request.getSession().setAttribute("USERV_ISIT",uservisitInf);

    }





}


