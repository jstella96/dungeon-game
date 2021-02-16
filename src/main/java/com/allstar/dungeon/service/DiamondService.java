package com.allstar.dungeon.service;

import java.util.List;
import java.util.Map;

import com.allstar.dungeon.dto.DiamondDTO;


public interface DiamondService {
	
	List<DiamondDTO> getDiamonds(Map map);

	void inputDiamondGet(Map map);
	
}
