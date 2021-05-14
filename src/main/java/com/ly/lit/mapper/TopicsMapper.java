package com.ly.lit.mapper;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ly.lit.entity.Resources;
import com.ly.lit.entity.Topics;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author ${author}
 * @since 2021-04-12
 */
public interface TopicsMapper extends BaseMapper<Topics> {

    List<Topics> getListPages(Page<Topics> page, @Param("content")String content);

    List<Topics> getListPagesById(Page<Topics> page, @Param("id")Integer id,@Param("content")String content);


}
