package com.allstar.dungeon.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.allstar.dungeon.dao.MonsterDAO;
import com.allstar.dungeon.dto.MonsterDTO;
import com.allstar.dungeon.service.MonsterService;
@Service("monsterService")
public class MonsterServiceImpl implements MonsterService {

	@Resource(name = "monsterDAO")
	private MonsterDAO dao;
	
	@Override
	public List<MonsterDTO> getMonsters(Map map) {
		// TODO Auto-generated method stub
		return dao.selectMonsterList(map);
	}

	@Override
	public void inputMonsterDeath(Map map) {
		
		dao.insertMonsterDeath(map);
		
	}
	

}
