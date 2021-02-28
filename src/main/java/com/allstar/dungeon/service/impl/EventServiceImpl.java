package com.allstar.dungeon.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.allstar.dungeon.dao.EventDAO;

import com.allstar.dungeon.service.EventService;

@Service("eventService")
public class EventServiceImpl implements EventService{
	
	@Resource(name="eventDAO")
	private EventDAO dao;
	
	
	@Override
	public void inputEventClear(Map map) {
		
		dao.insertEventClear(map);
		
	}


	@Override
	public String getEventClear(Map map) {
		// TODO Auto-generated method stub
		return dao.selectEventClear(map) == 0 ?"y":"n";
	}

}
