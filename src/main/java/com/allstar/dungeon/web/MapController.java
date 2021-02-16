package com.allstar.dungeon.web;

import java.util.HashMap;
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

import com.allstar.dungeon.dto.DiamondDTO;
import com.allstar.dungeon.dto.MemberDTO;
import com.allstar.dungeon.dto.MonsterDTO;
import com.allstar.dungeon.service.DiamondService;
import com.allstar.dungeon.service.MemberMoveService;
import com.allstar.dungeon.service.MonsterService;

@Controller
@RequestMapping("/map/")
public class MapController {

	@Resource(name="sqlSessoinTemplate")
	private SqlSessionTemplate sqlMapper;

	@Resource(name = "memberMoveService")
	private MemberMoveService moveService;
	
	@Resource(name = "monsterService")
	private MonsterService monsterService;
	
	@Resource(name = "diamondService")
	private DiamondService diamondService;
	
	@RequestMapping("change")
	public String mapChange(@RequestParam Map map,Model model,HttpServletRequest req) {
		
		String id= req.getSession().getAttribute("memberId").toString();
		map.put("id",id);
		moveService.modifyMember(map);
		
		return "redirect:/map/page";
	}
	
	@RequestMapping("page")
	public String mapMove(Model model,HttpServletRequest req) {
		
		String id= req.getSession().getAttribute("memberId").toString();
				
		MemberDTO memberDto = moveService.getMember(id);
		model.addAttribute("memberDto",memberDto);
		
		Map map = new HashMap();
		map.put("id",id);
		map.put("map",memberDto.getMap());
		//1]몬스터 리스트
		List<MonsterDTO> monsterList =  monsterService.getMonsters(map);
		model.addAttribute("monsterList",monsterList);
		//2]다이아몬드 리스트
		List<DiamondDTO> diamondList = diamondService.getDiamonds(map);
		model.addAttribute("diamondList",diamondList);

		return String.format("Map/Map%d.dungeon",memberDto.getMap());

	}
	
	
	
	//diamond get
	@RequestMapping(value="diamond/get",produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String diamondGet(@RequestParam Map map,HttpServletRequest req) {
		System.out.println("아이디 있나?");
		System.out.println(map.get("diamondId").toString());
		String id= req.getSession().getAttribute("memberId").toString();
		map.put("id",id);
		diamondService.inputDiamondGet(map);
		return map.get("diamondId").toString();
	}
	
	//monster get
	@RequestMapping(value="monster/death",produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String deathMonsterAjax(@RequestParam Map map,HttpServletRequest req) {
		
		String id= req.getSession().getAttribute("memberId").toString();
		map.put("id",id);
		String monsterId = map.get("monsterId").toString();
		monsterService.inputMonsterDeath(map);
		
		return monsterId;
	}
	


}