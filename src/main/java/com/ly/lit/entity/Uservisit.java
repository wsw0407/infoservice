package com.ly.lit.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
import java.text.SimpleDateFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 
 * </p>
 *
 * @author ${author}
 * @since 2021-04-25
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_uservisit")
public class Uservisit extends Model<Uservisit> {

    private static final long serialVersionUID=1L;

      @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String loginTime;

    private String exitTime;

    private String visitIp;

    private String userAddress;

    private String userFrom;

    private String browser;

    private String system;

    private String version;

    private String loginname;

    private String iphone;

    /*public String getLoginTimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (this.loginTime != null){
            return sdf.format(this.loginTime);
        }else {
            return  null;
        }
    }

    public String getExitTimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        if (this.exitTime != null){
            return sdf.format(this.exitTime);
        }else {
            return  null;
        }
    }*/

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

}
