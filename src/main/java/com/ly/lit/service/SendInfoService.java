package com.ly.lit.service;

import org.springframework.scheduling.annotation.Async;

import javax.mail.MessagingException;

public interface SendInfoService {

    @Async
    void sendEmails(String toeamil, String code) throws MessagingException;


    @Async
    void sendPhone(String to, String[] dats) throws MessagingException;

}
