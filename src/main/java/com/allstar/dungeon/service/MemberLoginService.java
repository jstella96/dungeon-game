package com.allstar.dungeon.service;

import java.util.Map;

import com.allstar.dungeon.dto.MemberDTO;


public interface MemberLoginService {
	//로그인 - 회원여부 판별
	boolean isMember(Map map);
	
	//회원가입 - 아이디 중복체크
	boolean	isIdDuplicate (String id);

	//회원가입 - 회원입력
	void inputMember (Map map);	
}
