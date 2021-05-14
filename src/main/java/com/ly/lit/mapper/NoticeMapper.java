package com.ly.lit.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Notice;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ly.lit.entity.Resources;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2021-04-16
 */
public interface NoticeMapper extends BaseMapper<Notice> {

    List<Notice> getListPages(Page<Notice> page, @Param("content")String content);

    Notice getById(Integer id);

}
