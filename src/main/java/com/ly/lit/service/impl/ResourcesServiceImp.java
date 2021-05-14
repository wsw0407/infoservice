package com.ly.lit.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Resources;
import com.ly.lit.mapper.ResourcesMapper;
import com.ly.lit.service.ResourcesService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ly.lit.vo.AccountVo;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-10
 */
@Service
public class ResourcesServiceImp extends ServiceImpl<ResourcesMapper, Resources> implements ResourcesService {

    @Override
    public Page<Resources> getListPages(Page<Resources> page,String content) {

        if(content != null && !content.equals("")){
            content = "%" + content + "%";
        }
        return page.setRecords(this.baseMapper.getListPages(page,content));
    }

    @Override
    public Page<Resources> getListPagesById(Page<Resources> page, Integer id, String content) {
        if(content != null && !content.equals("")){
            content = "%" + content + "%";
        }
        return page.setRecords(this.baseMapper.getListPagesById(page,id,content));
    }
}
