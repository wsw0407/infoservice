package com.ly.lit.vo;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_users")
public class AccountVo extends Model<AccountVo> {

    private static final long serialVersionUID=1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String account;

    private String password;

    private String pic;

    private String username;

    private Integer role;

    private Integer userid;

    private String realname;

    private Integer age;

    private Integer sex;

    private String sexname;

    private Integer inclass;

    private String classnum;

    private Integer majarId;

    private String address;

    private String phone;

    private String email;

    private String remark;

    private String majarname;

    public String getSexname() {
        if(this.sex == null){
            return null;
        }

        if(this.sex == 1){
            this.sexname = "男";
        }else if(this.sex == 2){
            this.sexname = "女";
        }
        return sexname;
    }



    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
