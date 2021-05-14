package com.ly.lit.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Users;
import com.ly.lit.mapper.UsersMapper;
import com.ly.lit.service.UsersService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ly.lit.vo.AccountVo;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-03
 */
@Service
public class UsersServiceImp extends ServiceImpl<UsersMapper, Users> implements UsersService {

    @Override
    public Page<AccountVo> getListPages(Page<AccountVo> page, String content) {

        if(content != null && !content.equals("")){
            content = "%" + content + "%";
        }

        return page.setRecords(this.baseMapper.getListPages(page,content));
    }

    @Override
    public AccountVo getAccountVoById(Integer id) {
        return this.baseMapper.getAccountVoById(id);
    }
}
