package com.ly.lit.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Notice;
import com.ly.lit.mapper.NoticeMapper;
import com.ly.lit.service.NoticeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-16
 */
@Service
public class NoticeServiceImp extends ServiceImpl<NoticeMapper, Notice> implements NoticeService {

    @Override
    public Page<Notice> getListPages(Page<Notice> page, String content) {
        if(content != null && !content.equals("")){
            content = "%" + content + "%";
        }
        return page.setRecords(this.baseMapper.getListPages(page,content));
    }

    @Override
    public Notice getById(Integer id) {
        return this.baseMapper.getById(id);
    }
}
