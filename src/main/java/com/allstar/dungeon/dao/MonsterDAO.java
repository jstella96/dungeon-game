package com.allstar.dungeon.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.allstar.dungeon.dto.MonsterDTO;

@Repository

public class MonsterDAO {
	
	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper; 
	
	public List<MonsterDTO> selectMonsterList(Map map) {
		
		return sqlMapper.selectList("selectMonsterList",map);
	}

	public void insertMonsterDeath(Map map) {
		
		sqlMapper.update("updateMonsterDeath",map);
	}
}
