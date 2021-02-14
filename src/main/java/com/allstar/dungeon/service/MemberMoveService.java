package com.allstar.dungeon.service;

import java.util.Map;

import com.allstar.dungeon.dto.MemberDTO;

public interface MemberMoveService {

	MemberDTO getMember(String id);
	
	void modifyMember(Map map);
}
