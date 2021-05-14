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
 * @since 2021-04-18
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_classchedule")
public class Classchedule extends Model<Classchedule> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 班级
     */
    private Integer inclass;

    /**
     * 专业
     */
    private Integer majarid;

    /**
     * 学期
     */
    private Integer term;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
