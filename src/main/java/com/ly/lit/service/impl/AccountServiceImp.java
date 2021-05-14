package com.ly.lit.service.impl;

import com.ly.lit.entity.Account;
import com.ly.lit.mapper.AccountMapper;
import com.ly.lit.service.AccountService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
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
public class AccountServiceImp extends ServiceImpl<AccountMapper, Account> implements AccountService {

}
