package com.qsy.workbench.dao;

import com.qsy.workbench.pojo.ClueActivityRelation;
import com.qsy.workbench.pojo.ContactActivityRelation;

import java.util.List;

public interface ContactActivityRelationMapper {
    int deleteByPrimaryKey(String id);

    int insert(ContactActivityRelation row);

    int insertSelective(ContactActivityRelation row);

    ContactActivityRelation selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(ContactActivityRelation row);

    int updateByPrimaryKey(ContactActivityRelation row);

    //批量添加，将与线索管理的市场活动添加联系人市场活动表中
    int insertContactActivityRelation(List<ContactActivityRelation> carList);
}