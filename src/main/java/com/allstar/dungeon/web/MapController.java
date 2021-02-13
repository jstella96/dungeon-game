package com.allstar.dungeon.web;

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

import com.allstar.dungeon.dto.MemberDTO;
import com.allstar.dungeon.service.MemberMoveService;

@Controller
@RequestMapping("/map/")
public class MapController {

	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper;

	@Resource(name = "memberMoveService")
	private MemberMoveService moveService;
	
	@RequestMapping("change")
	public String mapChange(@RequestParam Map map,Model model,HttpServletRequest req) {
		
		String memberId= req.getSession().getAttribute("memberId").toString();
	
		
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
		
		map.put("id",memberId);
		map.put("page",afterPage);
		map.put("x",x);
		map.put("y",y);
		
		
		moveService.modifyMemberInfo(map);

		
		return "redirect:/map/page";
	}
	
	@RequestMapping("page")
	public String mapMove(Model model,HttpServletRequest req) {
		
		String memberId= req.getSession().getAttribute("memberId").toString();
				
		MemberDTO memberDto = moveService.findMemberInfo(memberId);
		model.addAttribute("memberDto",memberDto);

		//map에 따른 사용자의 다이아몬드 습득 정보 가져오기
		//map.put("page",memberGameInfo.get("map"));
		//List<Map> list = sqlMapper.selectList("dungeonDiamondSelect", map);
		//model.addAttribute("diaList",list);

		return String.format("Map/Map%d.dungeon",memberDto.getMap());

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
