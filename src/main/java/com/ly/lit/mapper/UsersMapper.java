package com.ly.lit.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Users;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ly.lit.vo.AccountVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2021-04-03
 */
public interface UsersMapper extends BaseMapper<Users> {

    List<AccountVo> getListPages(Page<AccountVo> page, @Param("content")String content);

    AccountVo getAccountVoById(@Param("id")Integer id);


}
