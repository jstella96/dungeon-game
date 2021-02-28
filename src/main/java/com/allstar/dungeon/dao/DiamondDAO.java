package com.allstar.dungeon.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.allstar.dungeon.dto.DiamondDTO;

@Repository
public class DiamondDAO {
	
	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper; 
	
	public List<DiamondDTO> selectDiamondList(Map map) {
		
		return sqlMapper.selectList("selectDiamondList",map);
	}

	public void insertDiamondGet(Map map) {
		
		sqlMapper.insert("insertDiamondGet",map);
	}
	

	public void insertRedDiamondGet(Map map) {
		
		sqlMapper.insert("insertRedDiamondGet",map);
	}
}