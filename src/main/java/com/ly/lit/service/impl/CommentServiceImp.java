package com.ly.lit.service.impl;

import com.ly.lit.entity.Comment;
import com.ly.lit.mapper.CommentMapper;
import com.ly.lit.service.CommentService;
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
public class CommentServiceImp extends ServiceImpl<CommentMapper, Comment> implements CommentService {

}
