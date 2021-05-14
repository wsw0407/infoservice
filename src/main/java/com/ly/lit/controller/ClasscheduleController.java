package com.ly.lit.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ly.lit.entity.Classchedule;
import com.ly.lit.entity.CourseInfo;
import com.ly.lit.entity.Courseschedule;
import com.ly.lit.service.ClasscheduleService;
import com.ly.lit.service.CoursescheduleService;
import com.ly.lit.service.TermService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.lang.reflect.Field;
import java.util.*;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author ${author}
 * @since 2021-04-18
 */
@Controller
@RequestMapping("/classchedule")
public class ClasscheduleController {

    @Autowired
    private ClasscheduleService classcheduleService;

    @Autowired
    private CoursescheduleService coursescheduleService;

    @ResponseBody
    @RequestMapping("/course")
    public  Map<String,Object> course(Integer term,Integer adminClass) throws NoSuchFieldException, IllegalAccessException {

        System.out.println(term);
        System.out.println(adminClass);

        Classchedule classchedule = classcheduleService.getOne(new QueryWrapper<Classchedule>().eq("term",term).eq("inclass",adminClass));
        if(classchedule != null){
            return courseList(classchedule.getId());
        }

        Map<String,Object> map = new HashMap<>();
        String[] sections = {"一","二","三","四","晚"};
        List<CourseInfo> list = new ArrayList<>();

        for (int i=0;i<5;i++){

            CourseInfo courseInfo = new CourseInfo();
            courseInfo.setSpace(sections[i]);
            list.add(courseInfo);
        }

        map.put("code",0);
        map.put("msg","暂无课程信息");
        map.put("count",0);
        map.put("data",list);

        return map;
    }


    public  Map<String,Object> courseList(Integer classId) throws NoSuchFieldException, IllegalAccessException {

        Map<String,Object> map = new HashMap<>();
        String[] sections = {"一","二","三","四","晚"};
        List<CourseInfo> list = new ArrayList<>();

        if(classcheduleService.getById(classId) != null){

            for (int i=0;i<5;i++){

                List<Courseschedule>  courList = coursescheduleService.list(new QueryWrapper<Courseschedule>().eq("section",sections[i]).eq("classId",classId));
                System.out.println(sections[i]+"===============================");
                CourseInfo courseInfo = new CourseInfo();
                courseInfo.setSpace(sections[i]);

                for (Courseschedule c : courList){
                    System.out.println(c);
                    Field name = CourseInfo.class.getDeclaredField(c.getWeek());
                    name.setAccessible(true);
                    name.set(courseInfo, c.getCourseStr());

                    System.out.println(courseInfo);
                }
                list.add(courseInfo);
            }
        }


        map.put("code",0);
        map.put("msg","查询成功");
        map.put("count",0);
        map.put("data",list);

        return map;
    }



    @RequestMapping("/listpage")
    public String toList(){
        return "course/list";
    }

    @RequestMapping("/listpage2")
    public String toList2(){
        return "course/list2";
    }

    @ResponseBody
    @RequestMapping(value="/add", method = RequestMethod.POST,produces = "application/json;charset=utf-8")
    public String add(@RequestBody List<CourseInfo> courseInfo,Integer term,Integer adminClass){

        System.out.println("term====="+term);
        System.out.println("adminClass====="+adminClass);

        Classchedule classc = classcheduleService.getOne(new QueryWrapper<Classchedule>().eq("term",term).eq("inclass",adminClass));
        if(classc != null){

            return "课表已添加,点击修改";
        }

        System.out.println("=================="+courseInfo.size());
        Classchedule classchedule = new Classchedule();
        classchedule.setInclass(adminClass);
        classchedule.setTerm(term);

        classcheduleService.saveOrUpdate(classchedule);

        for (CourseInfo c : courseInfo){
            String  section =  c.getSpace();

            Courseschedule courseschedule = new Courseschedule();
            courseschedule.setClassId(classchedule.getId());
            courseschedule.setSection(section);

            saveCourseschedule(courseschedule,c.getMonday(),"monday");
            saveCourseschedule(courseschedule,c.getTuesday(),"tuesday");
            saveCourseschedule(courseschedule,c.getWednesday(),"wednesday");
            saveCourseschedule(courseschedule,c.getThursday(),"thursday");
            saveCourseschedule(courseschedule,c.getFriday(),"friday");
            saveCourseschedule(courseschedule,c.getSaturday(),"saturday");

        }

        return "添加成功";
    }

    @ResponseBody
    @RequestMapping(value="/edit", method = RequestMethod.POST,produces = "application/json;charset=utf-8")
    public String edit(@RequestBody List<CourseInfo> courseInfo,Integer term,Integer adminClass){

        System.out.println("term====="+term);
        System.out.println("adminClass====="+adminClass);

        Classchedule classchedule = classcheduleService.getOne(new QueryWrapper<Classchedule>().eq("term",term).eq("inclass",adminClass));
        if(classchedule == null){
            return "课表不存在,点击添加";
        }
        System.out.println("=================="+courseInfo.size());

        coursescheduleService.remove(new QueryWrapper<Courseschedule>().eq("classId",classchedule.getId()));

        for (CourseInfo c : courseInfo){
            String  section =  c.getSpace();

            Courseschedule courseschedule = new Courseschedule();
            courseschedule.setClassId(classchedule.getId());
            courseschedule.setSection(section);

            saveCourseschedule(courseschedule,c.getMonday(),"monday");
            saveCourseschedule(courseschedule,c.getTuesday(),"tuesday");
            saveCourseschedule(courseschedule,c.getWednesday(),"wednesday");
            saveCourseschedule(courseschedule,c.getThursday(),"thursday");
            saveCourseschedule(courseschedule,c.getFriday(),"friday");
            saveCourseschedule(courseschedule,c.getSaturday(),"saturday");
        }

        return "修改成功";
    }

    @ResponseBody
    @RequestMapping(value="/exist", method = RequestMethod.POST,produces = "application/json;charset=utf-8")
    public Integer exist(Integer term,Integer adminClass){

        System.out.println("term====="+term);
        System.out.println("adminClass====="+adminClass);

        Classchedule classc = classcheduleService.getOne(new QueryWrapper<Classchedule>().eq("term",term).eq("inclass",adminClass));
        if(classc == null){
            return 0;
        }
        return classc.getId();
    }

    @ResponseBody
    @RequestMapping("/delete")
    public boolean delete(Integer id){
        coursescheduleService.remove(new QueryWrapper<Courseschedule>().eq("classId",id));

        return classcheduleService.removeById(id);
    }


    public  boolean saveCourseschedule(Courseschedule coursesc,String courseInfo,String week){
        if(courseInfo != null && !courseInfo.equals("")){
            coursesc.setId(null);
            coursesc.setWeek(week);
            coursesc.setCourseInfo(courseInfo);

            System.out.println("saveCourseschedule="+coursesc);
            coursescheduleService.saveOrUpdate(coursesc);
        }
        return true;
    }

}

