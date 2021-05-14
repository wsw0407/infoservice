package com.ly.lit.service.impl;

import com.ly.lit.service.SendInfoService;
import com.ly.lit.utils.SendInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.mail.MessagingException;


@Service
public class SendinfoServiceImp implements SendInfoService {

    @Autowired
    private JavaMailSender mailSender;

    @Value("${fromEamil}")
    private String from;

    @Override
    @Async
    public void sendEmails(String toeamil, String code) throws MessagingException {
        String subject = "校园服务 | 注册 校园服务系统 邮箱验证";
        SendInfo.sendEmails(mailSender,from,toeamil,code,subject);
    }


    @Value("${serverIp}")
    private String serverIp;

    @Value("${serverPort}")
    private String serverPort;

    @Value("${accountSId}")
    private String accountSId;

    @Value("${accountToken}")
    private String accountToken;

    @Value("${appId}")
    private String appId;

    @Value("${templateId}")
    private String templateId;

    @Override
    public void sendPhone(String to, String[] dats) throws MessagingException {
        SendInfo.sendPhone(serverIp,serverPort,accountSId,accountToken,appId,templateId,to,dats);
    }


}
