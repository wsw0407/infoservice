package com.ly.lit.utils;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;

@Component
public class UploadUtils {


    private static String basepath;

    @Value("${basepath}")
    public  void setBasepath(String basepath) {
     this.basepath= basepath;
    }

    public static String upload(String path, MultipartFile file) {

        System.out.println("basepath==="+basepath);
        path = basepath +path;
        String fileName = file.getOriginalFilename();

        if(fileName == null || fileName.equals("")){
            return null;
        }

        Date date = new Date();
        fileName = getFileName(fileName, date);

        try {
            file.transferTo(new File(path, fileName));
            return fileName;
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
            return null;
        }
    }


    public static boolean delFile(String path,String fileName) {

        String uppath = path +"/"+ fileName;
        uppath = basepath + uppath;
        File file = new File(uppath);
        System.out.println("path==================="+path);
        System.out.println("uppath==================="+uppath);
        System.out.println("file.exists=============="+file.exists());

        if(file.exists()) {
            file.delete();
            System.out.println(fileName+"删除");
            return true;
        }
        return false;
    }

    public static String getFileName(String fileName, Date date) {

        SimpleDateFormat sdf = new SimpleDateFormat("YYYYMMddHHmmssSS");

        String strings[] = fileName.split("\\.");

        System.err.println("getTime==========="+strings[1]+strings[0]);
        fileName = strings[0] +"_"+sdf.format(date)+"."+strings[1];
        System.err.println("========fileName========"+fileName);

        return fileName;
    }

    public static String spiltFileName(String fileName) {

        Integer num1 = fileName.lastIndexOf('_');
        if(num1 < 0){
            return fileName;
        }
        String fileprefix = fileName.substring(0,num1);

        Integer num2 = fileName.lastIndexOf('.');
        String filesuffix = fileName.substring(num2);

        fileName=fileprefix+filesuffix;
        System.err.println("========fileName========"+fileName);

        return fileName;
    }

    public static boolean filesExists(String path,String filename){

        System.out.println(filename);
        path = basepath + path;
        System.out.println(path);

        File f = new File(path,filename);
        if(f.exists()){
            return true;
        }else {
            return false;
        }
    }

    public static ResponseEntity<byte[]> download(String path,String filename) throws Exception{
        System.out.println(filename);
        path = basepath + path;

        File f = new File(path,filename);
        if(f.exists()){
            InputStream is = new FileInputStream(f);
            byte[] body = new byte[is.available()];
            is.read(body);//把要下载的文件 都 读到 body 字节数组中了  字节适用于所有的文件

            //4.得到这个body缓存 返回浏览器
            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Disposition", "attchement;filename=" + URLEncoder.encode(f.getName(), "UTF-8"));
            HttpStatus statusCode = HttpStatus.OK;
            ResponseEntity<byte[]> entity = new ResponseEntity<byte[]>(body, headers, statusCode);

            is.close();
            return entity;
        }
        else {
            return  null;
        }
    }



}
