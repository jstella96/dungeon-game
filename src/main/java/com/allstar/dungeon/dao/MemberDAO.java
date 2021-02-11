package com.allstar.dungeon.dao;

import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.allstar.dungeon.dto.MemberDTO;

@Repository
public class MemberDAO {

	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper; 
	
	
	public void insertMember(Map map) {
		
		sqlMapper.insert("insertMember",map);
	}

	
	public void updateMember(Map map) {
		
		sqlMapper.update("updateMember",map);
	}


	public void deleteMember(String id) {
		
		sqlMapper.update("deleteMember",id);
	}


	public MemberDTO selectMember(String id) {
		
		return sqlMapper.selectOne("selectMember",id);
	}


	public int selectMemberId(String id) {
		
		return sqlMapper.selectOne("selectMemberId",id);
	}


	public int selectMemberLoginCheck(Map map) {

		return sqlMapper.selectOne("selectMemberLoginCheck",map);
	}

}
