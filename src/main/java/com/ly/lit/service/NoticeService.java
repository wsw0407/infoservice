package com.ly.lit.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Notice;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ly.lit.entity.Resources;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-16
 */
public interface NoticeService extends IService<Notice> {

    Page<Notice> getListPages(Page<Notice> page, String content);

    Notice getById(Integer id);

}
