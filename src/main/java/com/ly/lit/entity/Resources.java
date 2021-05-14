package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;

import java.text.SimpleDateFormat;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-04-10
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_resources")
public class Resources extends Model<Resources> {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 标题
     */
    private String title;

    /**
     * 描述
     */
    private String remark;

    /**
     * 上传资源/类别
     */
    private Integer resourcesType;

    /**
     * 上传时间
     */
    private Date uploadtime;

    /**
     * 上传账户
     */
    private Integer accountId;

    @TableField(exist = false)
    private String username;

    /**
     * 上传内容
     */
    private String content;

    /**
     * 获取方式
     */
    private Integer access;

    @TableField(exist = false)
    private String accessWay;

    @TableField(exist = false)
    private List<Resourcestype> typelist;

    public String getTimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (this.uploadtime != null){
            return sdf.format(this.uploadtime);
        }else {
            return  null;
        }
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
