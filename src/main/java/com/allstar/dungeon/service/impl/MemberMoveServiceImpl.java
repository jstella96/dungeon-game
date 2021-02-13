package com.allstar.dungeon.service.impl;

import java.util.Map;

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
		MemberDTO dto =  dao.selectMember(id);
		int diamondCount = dto.getDiamondCount() + dto.getRedDiamondCount();
		dto.setDiamondCount(diamondCount); 
		return dto;
	}

	@Override
	public void modifyMemberInfo(Map map) {
		dao.updateMember(map);
		
	}
}
