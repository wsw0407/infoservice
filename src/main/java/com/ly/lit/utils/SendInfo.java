package com.ly.lit.utils;

import com.cloopen.rest.sdk.BodyType;
import com.cloopen.rest.sdk.CCPRestSmsSDK;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Set;


public class SendInfo {

    @Value("${fromEamil}")
    private static String from;

    public static void sendEmails(JavaMailSender mailSender,String from,String toeamil,String code,String subject) throws MessagingException {

//        String from = "1075512441@qq.com";
//        String to = "2862516131@qq.com";
        String content =  "<div style='width: 600px;margin:auto;background: white;overflow: auto'>\n" +
                "    <div style='height: 40px;background: #49BCFF;padding-left: 20px'>\n" +
                "        <h2 style='text-align:center;line-height: 40px;font-weight:bold;color: white'>大学生校园服务系统</h2>\n" +
                "    </div>\n" +
                "    <div style='line-height: 40px;padding-left: 20px;padding-bottom: 10px'>\n" +
                "        <h2>亲爱的用户您好</h2>\n" +
                "        <p>您的邮箱：@EMAIL<b></b></p>\n" +
                "        <p>您的激活码：@CODE<b></b></p>\n" +
                "        <p>您注册时的日期：@DATE<b></b></p>\n" +
                "        <p>当您在使用本网站时，务必要遵守法律法规</p>\n" +
                "    </div>\n" +
                "    <hr>\n" +
                "    <div  style='padding-right: 20px;margin-bottom:10px;float: right;font-size: 10px;color: #999999'>\n" +
                "        <p>此为系统邮件，请勿回复</p>\n" +
                "        <p>请保管好您的信息，避免被他人盗用</p>\n" +
                "        <p>©wsw</p>\n" +
                "    </div>\n" +
                "</div>";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        content = content.replaceAll("@EMAIL",toeamil)
                .replaceAll("@CODE",code)
                .replaceAll("@DATE",sdf.format(new Date()));
       // String subject = "校园服务 | 注册 校园服务系统 邮箱验证";


        MimeMessage message = mailSender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        //发件人
        helper.setFrom(from);
        //收件人
        helper.setTo(toeamil);
        //标题
        helper.setSubject(subject);
        //true指的是html邮件，false指的是普通文本
        helper.setText(content, true);

        //发送邮件
        mailSender.send(message);

    }

    public static void sendPhone(String serverIp,String serverPort,String accountSId,String accountToken,String appId,String templateId,String to,String[] datas){
        //生产环境请求地址：app.cloopen.com
        //String serverIp = "app.cloopen.com";
        //请求端口
        //String serverPort = "8883";
        //主账号,登陆云通讯网站后,可在控制台首页看到开发者主账号ACCOUNT SID和主账号令牌AUTH TOKEN
        //String accountSId = "8a216da878005a8001788aeee68e33bd";
        //String accountToken = "7e51234b9ce4415c9f4bbbdfaa19f236";
        //请使用管理控制台中已创建应用的APPID
        //String appId = "8a216da878005a8001788af5f05333d1";
        CCPRestSmsSDK sdk = new CCPRestSmsSDK();
        sdk.init(serverIp, serverPort);
        sdk.setAccount(accountSId, accountToken);
        sdk.setAppId(appId);
        sdk.setBodyType(BodyType.Type_JSON);
        //String to = "18438609053";
        //String templateId= "1";
        //String[] datas = {"232323","1","变量3"};
        String subAppend="1234";  //可选 扩展码，四位数字 0~9999
        String reqId="fadfafxxassss";  //可选 第三方自定义消息id，最大支持32位英文数字，同账号下同一自然天内不允许重复
        //HashMap<String, Object> result = sdk.sendTemplateSMS(to,templateId,datas);
        HashMap<String, Object> result = sdk.sendTemplateSMS(to,templateId,datas,null,null);
        if("000000".equals(result.get("statusCode"))){
            //正常返回输出data包体信息（map）
            HashMap<String,Object> data = (HashMap<String, Object>) result.get("data");
            Set<String> keySet = data.keySet();
            for(String key:keySet){
                Object object = data.get(key);
                System.out.println(key +" = "+object);
            }
        }else{
            //异常返回输出错误码和错误信息
            System.out.println("错误码=" + result.get("statusCode") +" 错误信息= "+result.get("statusMsg"));
        }
    }



}
