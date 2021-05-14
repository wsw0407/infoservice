package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
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
@TableName("sys_resaccess")
public class Resaccess extends Model<Resaccess> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String accessWay;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
