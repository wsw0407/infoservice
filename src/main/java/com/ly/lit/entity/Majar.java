package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.util.List;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-04-03
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_majar")
public class Majar extends Model<Majar> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 学院
     */
    private String institute;

    /**
     * 专业名称
     */
    private String majarname;

    /**
     * 院系代码
     */
    private String institnum;

    @TableField(exist = false)
    private List<Adminclass> classList;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
