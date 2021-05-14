package com.ly.lit.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Resources;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ly.lit.vo.AccountVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author ${author}
 * @since 2021-04-10
 */
public interface ResourcesService extends IService<Resources> {

    Page<Resources> getListPages(Page<Resources> page,String content);

    Page<Resources> getListPagesById(Page<Resources> page, @Param("id")Integer id, @Param("content")String content);

}
