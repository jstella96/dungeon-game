package com.allstar.dungeon.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.allstar.dungeon.dto.DiamondDTO;
import com.allstar.dungeon.dto.ItemDTO;

@Repository
public class ItemDAO {
	
	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper; 
	
	public List<ItemDTO> selectItemList(Map map) {
		
		return sqlMapper.selectList("selectItemList",map);
	}

	public void insertItemGet(Map map) {
		
		sqlMapper.update("insertItemGet",map);
	}
}
