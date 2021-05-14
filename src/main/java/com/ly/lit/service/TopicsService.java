package com.ly.lit.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Resources;
import com.ly.lit.entity.Topics;
import com.baomidou.mybatisplus.extension.service.IService;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-12
 */
public interface TopicsService extends IService<Topics> {

    Page<Topics> getListPages(Page<Topics> page, String content);

    Page<Topics> getListPagesById(Page<Topics> page,Integer id, String content);

}
