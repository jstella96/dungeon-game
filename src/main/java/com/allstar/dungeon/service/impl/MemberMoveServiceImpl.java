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
	public MemberDTO getMember(String id) {
		//회원정보 반환
		MemberDTO dto =  dao.selectMember(id);
		int diamondCount = dto.getDiamondCount() + dto.getRedDiamondCount();
		dto.setDiamondCount(diamondCount); 
		return dto;
	}

	@Override
	public void modifyMember(Map map) {
		
		int afterPage=1;
		
		int x= Integer.valueOf(map.get("x").toString());
		int y=Integer.valueOf(map.get("y").toString());
		int page=Integer.valueOf(map.get("page").toString());
		
		if(x==0){
			afterPage = page-1;
			x=12;
		}else if(x==12) {
			afterPage = page+1;
			x=0;
		}else if(y==0) {
			afterPage = page+4;
			y=8;
		}else if(y==8) {
			afterPage = page-4;
			y=0;
		}	
		
		map.put("page",afterPage);
		map.put("x",x);
		map.put("y",y);
		
		dao.updateMember(map);
		
	}
}
