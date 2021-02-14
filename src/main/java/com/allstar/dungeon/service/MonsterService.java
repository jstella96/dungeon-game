package com.allstar.dungeon.service;

import java.util.List;
import java.util.Map;

import com.allstar.dungeon.dto.MonsterDTO;

public interface MonsterService {

	List<MonsterDTO> getMonsters(Map map);

	void inputMonsterDeath(Map map);
	
}
