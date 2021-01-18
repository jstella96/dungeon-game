package com.allstar.dungeon.map;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/map/")
public class MapController {

	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper;
	
	
	//로그인 페이지로 이동
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String gameLogin() {
		return "Map/Login";
	}
	//로그인 확인 후, 게임시작
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String gameLoginTry(@RequestParam Map map,Model model,HttpServletRequest req) {
		//유효성 체크
		int memberCheck = sqlMapper.selectOne("memberLoginCheck",map);
		if(memberCheck == 0) {
			//리턴. 에러 발생.
		}
		req.getSession().setAttribute("member_Id", map.get("id"));
		
		
		//데이터에서 이전 위치 기록 받아오기
		Map memberGameInfo = sqlMapper.selectOne("memberInfoCall",map);
		
		model.addAttribute("page",memberGameInfo.get("map"));
		model.addAttribute("x",memberGameInfo.get("x"));
		model.addAttribute("y",memberGameInfo.get("y"));
		
		//map에 따른 사용자의 다이아몬드 습득 정보 가져오기
		map.put("page",memberGameInfo.get("map"));
		List<Map> list = sqlMapper.selectList("dungeonDiamondSelect", map);
		model.addAttribute("diaList",list);
		
		
		System.out.println(String.format("Map/Map%d.dungeon",memberGameInfo.get("map")));
		
		return String.format("Map/Map%d.dungeon",memberGameInfo.get("map"));
	}
	
	@RequestMapping(value = "Join", method = RequestMethod.POST)
	public String gameJoin(@RequestParam Map map) {
	
		int memberCheck = sqlMapper.selectOne("memberLoginCheck",map);
		if(memberCheck == 0) {
			 sqlMapper.insert("memberInsert",map);
		}
		
		return "Map/Login";
	}
	
	
	@RequestMapping("change")
	public String mapChange(@RequestParam Map map,Model model,HttpServletRequest req) {
		
		String member_Id= req.getSession().getAttribute("member_Id").toString();
		map.put("id",member_Id);
		
		
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
		
		model.addAttribute("page",afterPage);
		model.addAttribute("x",x);
		model.addAttribute("y",y);
		
		map.put("page",afterPage);
		map.put("x",x);
		map.put("y",y);
		
		
		List<Map> list = sqlMapper.selectList("dungeonDiamondSelect", map);
		model.addAttribute("diaList",list);
		
		
		sqlMapper.update("CharacterLocationUpdate",map);
		return String.format("Map/Map%d.dungeon", afterPage);
	}
	
	//diamond get
	@RequestMapping(value="diamond",produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String diamondGet(@RequestParam Map map,HttpServletRequest req) {
		
		String member_Id= req.getSession().getAttribute("member_Id").toString();
		map.put("id",member_Id);
		String diaNumber = map.get("diamondNumber").toString();
		sqlMapper.update("dungeonDiamondUpdate",map);
		
		return diaNumber;
	}
	


}
