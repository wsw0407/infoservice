package com.ly.lit.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Users;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ly.lit.vo.AccountVo;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-03
 */
public interface UsersService extends IService<Users> {

    Page<AccountVo> getListPages(Page<AccountVo> page, String content);

    AccountVo getAccountVoById(@Param("id")Integer id);

}
