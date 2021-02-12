package com.allstar.dungeon.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.allstar.dungeon.dto.MemberDTO;
import com.allstar.dungeon.service.MemberLoginService;
import com.allstar.dungeon.service.MemberMoveService;


@Controller
public class MemberController {
	

	
	@Resource(name = "memberLoginService")
	private MemberLoginService loginService;
	
	//1]로그인 페이지로 이동
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String moveLoginPage() {
		
		return "Main/Home";
	}
	
	//2]로그인 확인 후, 게임시작
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String gameLogin(@RequestParam Map map, Model model, HttpServletRequest req,RedirectAttributes attr) {
		
		boolean memberCheck = loginService.isMember(map);
		
		if(memberCheck) {
			req.getSession().setAttribute("memberId", map.get("id"));
			
			return "redirect:/map/page";
		}else {
			attr.addFlashAttribute("error","존재하지 않는 아이디 입니다.");
			return "redirect:/login";
		}
	}
	
	
	//3]로그아웃-세션영역 데이타 삭제
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logoutProcess(HttpServletRequest req) {
			
		req.getSession().invalidate();
		
		return "Main/Home";
	}
	

	//4]회원가입 처리
	@RequestMapping(value = "/sign", method = RequestMethod.POST)
	public String signProcess(@RequestParam Map map) {
		loginService.inputMember(map);
		return "Main/Home";
	}/////signPost()
	
	
	//5]sign.jsp로부터 id와 nickname값을 받아와 중복체크를 해준다.
	@RequestMapping(value="/sign/ajax",produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String duplicateCheckAjax(@RequestParam Map map) {
		
		//1]서비스 호출
		boolean result = loginService.isIdDuplicate(map.get("id").toString());
		
		return result?"available":"unavailable";
	}//duplicateCheckAjax()

	

}
