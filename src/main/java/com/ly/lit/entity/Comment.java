package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

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
@TableName("sys_comment")
public class Comment extends Model<Comment> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 内容
     */
    private String content;

    /**
     * 关联评论的id
     */
    private Integer topicId;

    /**
     * 回复用户id
     */
    private Integer fromAid;

    @TableField(exist = false)
    private String fromUsername;
    /**
     * 回复用户id
     */
    private Integer toUid;

    @TableField(exist = false)
    private String toUsername;

    private Date creatdate;

    public String getTimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (this.creatdate != null){
            return sdf.format(this.creatdate);
        }else {
            return  null;
        }
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
