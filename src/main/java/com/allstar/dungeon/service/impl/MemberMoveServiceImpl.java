package com.allstar.dungeon.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.allstar.dungeon.dao.MemberDAO;
import com.allstar.dungeon.dto.MemberDTO;
import com.allstar.dungeon.service.MemberMoveService;

@Service("memberMoveService")
public class MemberMoveServiceImpl implements MemberMoveService{
	
	@Resource(name="memberDAO")
	private MemberDAO dao;
	
	@Override
	public MemberDTO findMemberInfo(String id) {
		//회원정보 반환
		return dao.selectMember(id);
	}
}
