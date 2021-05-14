package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.baomidou.mybatisplus.extension.activerecord.Model;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
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
 * @since 2021-04-12
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_topics")
public class Topics extends Model<Topics> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 内容
     */
    private String comtent;

    /**
     * 发布的主题/类别
     */
    @TableField(value = "topic_type",updateStrategy = FieldStrategy.IGNORED)
    private Integer topicType;

    @TableField(exist = false)
    private String typename;

    /**
     * 发布时间
     */
    private Date releasetime;

    /**
     * 发布账户
     */
    private Integer accountId;

    @TableField(exist = false)
    private Account account;

    @TableField(exist = false)
    private List<Comment> conList;
    /**
     * 备注
     */
    private String remark;

    public String getTimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (this.releasetime != null){
            return sdf.format(this.releasetime);
        }else {
            return  null;
        }
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
