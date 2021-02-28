package com.allstar.dungeon.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.print.attribute.HashPrintJobAttributeSet;

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

	@Override
	public List<Map> getItemsInven(Map map) {
		// TODO Auto-generated method stub
		List<Map> list = new ArrayList<Map>();
		List<ItemDTO> itemList = dao.selectItemList(map);
		for(ItemDTO dto : itemList) {
			Map itemMap = new HashMap();
			itemMap.put("state", dto.getState());
			itemMap.put("name", dto.getName());
			itemMap.put("use", dto.getUse());
			list.add(itemMap);
		}
		return list;
	}

	@Override
	public void modifyItemGet(Map map) {
		
		dao.updateItemGet(map);
		
	}

}
