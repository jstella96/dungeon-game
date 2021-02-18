package com.allstar.dungeon.service;

import java.util.List;
import java.util.Map;

import com.allstar.dungeon.dto.DiamondDTO;
import com.allstar.dungeon.dto.ItemDTO;


public interface ItemService {
	
	List<ItemDTO> getItems(Map map);

	void inputItemGet(Map map);
	
}
