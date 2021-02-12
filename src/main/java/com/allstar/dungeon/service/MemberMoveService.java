package com.allstar.dungeon.service;

import java.util.Map;

import com.allstar.dungeon.dto.MemberDTO;

public interface MemberMoveService {

	MemberDTO findMemberInfo(String id);
	
	void modifyMemberInfo(Map map);
}
