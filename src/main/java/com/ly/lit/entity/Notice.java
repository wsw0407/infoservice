package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;
import org.springframework.format.annotation.DateTimeFormat;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-04-16
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_notice")
public class Notice extends Model<Notice> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 活动公告标题
     */
    private String title;

    /**
     * 内容描述
     */
    private String content;

    /**
     * 发布时间
     */
    private Date releasetime;

    /**
     * 结束时间
     */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endtime;

    /**
     * 图片
     */
    private String pic;

    /**
     * 标记，活动是否有效
     */
    private Integer remark;

    @TableField(exist = false)
    private String status;

    /**
     * 活动链接，可以转到网页链接
     */
    private String link;

    @TableField(exist = false)
    private List<Noticetype> typelist;

    public String getReleasetimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (this.releasetime != null){
            return sdf.format(this.releasetime);
        }else {
            return  null;
        }
    }

    public String getEndtimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (this.endtime != null){
            return sdf.format(this.endtime);
        }else {
            return  null;
        }
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
