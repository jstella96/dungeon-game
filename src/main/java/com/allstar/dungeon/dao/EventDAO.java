package com.allstar.dungeon.dao;


import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


@Repository
public class EventDAO {
	
	
	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper;
	
	public int selectEventClear(Map map) {
	
		return sqlMapper.selectOne("selectEventClear",map);
		
	}
	public void insertEventClear(Map map) {
			
		sqlMapper.insert("insertEventClear",map);
	}
	
}
