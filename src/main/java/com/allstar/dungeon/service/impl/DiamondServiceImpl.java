package com.allstar.dungeon.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.allstar.dungeon.dao.DiamondDAO;
import com.allstar.dungeon.dto.DiamondDTO;
import com.allstar.dungeon.service.DiamondService;

@Service("diamondService")
public class DiamondServiceImpl implements DiamondService {
	
	@Resource(name="diamondDAO")
	private DiamondDAO dao;
	
	@Override
	public List<DiamondDTO> getDiamonds(Map map) {
		// TODO Auto-generated method stub
		return dao.selectDiamondList(map);
	}

	@Override
	public void inputDiamondGet(Map map) {
		dao.insertDiamondGet(map);
	}

}
