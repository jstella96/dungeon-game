package com.allstar.dungeon.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.allstar.dungeon.dao.MemberDAO;
import com.allstar.dungeon.dto.MemberDTO;
import com.allstar.dungeon.service.MemberLoginService;


@Service("memberLoginService")
public class MemberLoginServiceImpl implements MemberLoginService{

	@Resource(name="memberDAO")
	private MemberDAO dao;
	
	@Override
	public boolean isMember(Map map) {
		
		//정보가 있으면 로그인 성공
		return dao.selectMemberLoginCheck(map) == 1 ? true : false;
	}
	
	@Override
	public boolean isIdDuplicate(String id) {
		
		//count 함수로 0 or 1 받아온다
		int checkResult = dao.selectMemberId(id);
		return checkResult== 0 ? true : false;
	}


	@Override
	public void inputMember(Map map) {
		/*멤버가입 처리와 동시에, 기본 정보 제공*/
		dao.insertMember(map);
		
	}

	
}
