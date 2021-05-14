package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.IdType;
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
 * @since 2021-04-11
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_reslinktype")
public class Reslinktype extends Model<Reslinktype> {

    private static final long serialVersionUID=1L;


    @TableId
    private Integer resuorcceid;

    private Integer typeid;


    @Override
    protected Serializable pkVal() {
        return this.resuorcceid;
    }

}
