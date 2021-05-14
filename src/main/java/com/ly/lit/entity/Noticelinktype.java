package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;

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
@TableName("sys_noticelinktype")
public class Noticelinktype extends Model<Noticelinktype> {

    private static final long serialVersionUID=1L;

    @TableId
    private Integer noticeid;

    private Integer typeid;


    @Override
    protected Serializable pkVal() {
        return this.noticeid;
    }

}
