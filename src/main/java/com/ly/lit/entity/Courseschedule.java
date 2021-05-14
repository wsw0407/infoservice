package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-04-19
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_courseschedule")
public class Courseschedule extends Model<Courseschedule> {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 周几
     */
    private String week;

    /**
     * 第几节
     */
    private String section;

    /**
     * 课程信息
     */
    @TableField("courseInfo")
    private String courseInfo;

    /**
     * 课表所属信息的关联ID
     */
    @TableField("classId")
    private Integer classId;

    public void setCourseInfo(String courseInfo) {
        if(courseInfo != null){
            System.out.println("============");
            this.courseInfo = courseInfo.replaceAll("<br>","");
        }else {
            this.courseInfo = courseInfo;
        }
    }

    public String getCourseStr(){
        if(this.courseInfo != null){
            return this.courseInfo.replaceAll("\n","<br>\n");
        }
        return null;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
