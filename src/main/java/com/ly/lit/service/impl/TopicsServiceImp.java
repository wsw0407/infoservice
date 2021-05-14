package com.ly.lit.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Topics;
import com.ly.lit.mapper.TopicsMapper;
import com.ly.lit.service.TopicsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-12
 */
@Service
public class TopicsServiceImp extends ServiceImpl<TopicsMapper, Topics> implements TopicsService {

    @Override
    public Page<Topics> getListPages(Page<Topics> page, String content) {
        if(content != null && !content.equals("")){
            content = "%" + content + "%";
        }
        return page.setRecords(this.baseMapper.getListPages(page,content));
    }

    @Override
    public Page<Topics> getListPagesById(Page<Topics> page, Integer id, String content) {
        if(content != null && !content.equals("")){
            content = "%" + content + "%";
        }
        return page.setRecords(this.baseMapper.getListPagesById(page,id,content));
    }
}
