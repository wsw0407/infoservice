package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-04-03
 */
@Data
@ToString
@EqualsAndHashCode(callSuper = false)
@TableName("sys_users")
public class Users extends Model<Users> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 真实名
     */
    private String realname;

    /**
     * 年龄
     */
    private Integer age;

    /**
     * 性别
     */
    private Integer sex;

    /**
     * 班级
     */
    private Integer inclass;

    /**
     * 专业
     */
    private Integer majarId;

    /**
     * 家庭住址
     */
    private String address;

    /**
     * 电话
     */
    private String phone;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 备注
     */
    private String remark;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
