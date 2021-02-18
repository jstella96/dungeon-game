package com.allstar.dungeon.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.allstar.dungeon.dao.DiamondDAO;
import com.allstar.dungeon.dao.ItemDAO;
import com.allstar.dungeon.dto.DiamondDTO;
import com.allstar.dungeon.dto.ItemDTO;
import com.allstar.dungeon.service.DiamondService;
import com.allstar.dungeon.service.ItemService;

@Service("itemService")
public class ItemServiceImpl implements ItemService {
	
	@Resource(name="itemDAO")
	private ItemDAO dao;
	
	@Override
	public List<ItemDTO> getItems(Map map) {
		// TODO Auto-generated method stub
		return dao.selectItemList(map);
	}

	@Override
	public void inputItemGet(Map map) {
		dao.insertItemGet(map);
	}

}
