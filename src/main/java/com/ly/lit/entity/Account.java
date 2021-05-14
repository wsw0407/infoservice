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
@TableName("sys_account")
public class Account extends Model<Account> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 账号
     */
    private String account;

    /**
     * 密码
     */
    private String password;

    /**
     * 图片头像
     */
    private String pic;

    /**
     * 昵称
     */
    private String username;

    /**
     * 权限/角色
     */
    private Integer role;

    /**
     * 关联详细用户信息
     */
    private Integer userid;


    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
