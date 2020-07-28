package com.all.light.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.all.light.dto.CorporationDTO;
import com.all.light.dto.MemberDTO;
import com.all.light.service.CorporationService;
import com.all.light.util.PageUtil;

@Controller
public class CorporationController {
	@Autowired
	private CorporationService corSVC;
	
	//로그인
	@RequestMapping("/corlog")
	public ModelAndView corlog(@RequestParam(value = "cnt", required = false, defaultValue = "0") int cnt,
			CorporationDTO cordto,HttpSession session,HttpServletRequest req,ModelAndView mv,RedirectView rv) {
		System.out.println("CorporationController corlog");
		if(cnt<4) {
			HashMap result=corSVC.login(cordto,session,cnt);
			if(result==null || result.size()==0) {
				rv.setUrl("./login.com");
			}else {
				rv.setUrl("./main.com");
			}
		}else {
			//자동입력방지값 동일한지 확인하기
			System.out.println("auto");
			
			HashMap result=corSVC.login(cordto,session,cnt);
			if(result==null || result.size()==0) {
				rv.setUrl("./login.com");
			}else {
				rv.setUrl("./main.com");
			}
		}
		mv.setView(rv);
		return mv;
	}
	
	//로그아웃
	@RequestMapping("/corlogout")
	public ModelAndView logout(HttpSession session,ModelAndView mv,RedirectView rv) {
		if(session.getAttribute("COID")==null) {
			rv.setUrl("./login.com");
			mv.setView(rv);
			return mv;
		}
		corSVC.logout(session);
		rv.setUrl("./main.com");
		mv.setView(rv);
		return mv;
	}
	
	// 7.7
	//기업 리스트 및 검색 메소드
	@RequestMapping("/corporation/admin")
	public ModelAndView adminCorporation(
			@RequestParam(value = "nowPage", required = false, defaultValue = "1") int nowPage,
			@RequestParam(value = "search", required = false) String searchWord,
			ModelAndView mv, RedirectView rv) {

		System.out.println("\nCorporationController.adminCorporation");

		PageUtil pInfo = corSVC.getPageInfo(nowPage, searchWord);
		ArrayList<CorporationDTO> map = corSVC.searchList(pInfo, searchWord);
		
		System.out.println("list = "+map.toString());
		System.out.println("pinfo = "+pInfo.toString());
		mv.addObject("LIST", map); //기업 상세 정보 리스트
		mv.addObject("PINFO", pInfo); //페이징 정보
		
		mv.setViewName("common/admin/corporation");
		return mv;
	}
	//기업 수정 메소드
		@RequestMapping(value="/corporation/modify/admin", method= RequestMethod.GET)
		public ModelAndView adminModifyCorporationGet(
				@RequestParam(value = "cono") int cono,
				@RequestParam(value = "nowPage", required = false, defaultValue = "1") int nowPage,
				@RequestParam(value = "search", required = false) String searchWord,
				CorporationDTO corDTO,	ModelAndView mv, RedirectView rv) {
			System.out.println("corporationController.modifyCorp, GET method");
			//파라미터 받기, 비즈니스로직
			corDTO = corSVC.getCorpInfo(cono);
			System.out.println("corpInfo = "+corDTO.toString());
			//모델지정
			mv.addObject("CORPINFO", corDTO); //기업 상세 정보
			//뷰지정
			mv.setViewName("common/admin/corporationModify");
			return mv;
		}
		
		@RequestMapping(value="/corporation/modify/admin", method= RequestMethod.POST)
		public ModelAndView adminModifyCorporationPost(
				// PK(CONO)를 DTO에서 int로 받을 시 get방식으로 파라미터를 넘겨받아도 corDTO안에서 받을 수 있음
				// String으로 받을 시 안됨
				@RequestParam(value = "nowPage", required = false, defaultValue = "1") int nowPage,
				@RequestParam(value = "search", required = false) String searchWord,
				CorporationDTO corDTO,	ModelAndView mv, RedirectView rv,HttpServletRequest request) {
			System.out.println("corporationController.modifyCorp, Post method");
			//파라미터 받기, 비즈니스로직
			System.out.println("corpDTO = "+corDTO.toString());
			corSVC.corpModify(corDTO);
			//뷰지정
			rv.setUrl(request.getContextPath()+"/corporation/admin.com?search="+searchWord+"&nowPage="+nowPage);
			mv.setView(rv);
			return mv;
		}
		
		
		@RequestMapping("/corporation/delete/admin")
		public ModelAndView adminDeleteCorp(
				@RequestParam(value = "cono") int cono,
				@RequestParam(value = "nowPage", required = false, defaultValue = "1") int nowPage,
				@RequestParam(value = "search", required = false) String searchWord,
				ModelAndView mv, RedirectView rv,HttpServletRequest request) {
			System.out.println("CorpController.delete.Corp");
			//파라미터 받기, 비즈니스로직
			System.out.println("cono = "+cono);
			corSVC.corpDelete(cono);
			//뷰지정
			rv.setUrl(request.getContextPath()+"/corporation/admin.com?search="+searchWord+"&nowPage="+nowPage);
			mv.setView(rv);
			return mv;
		}
		
		@RequestMapping(value="/corporation/join/admin", method=RequestMethod.GET)
		public ModelAndView adminJoinCorporationGet(
				ModelAndView mv, RedirectView rv,HttpServletRequest request) {
			System.out.println("CorpController.join.Corp "+request.getMethod()+"method");
			//뷰지정
			mv.setViewName("common/admin/corporationJoin");
			return mv;
		}
		
		@RequestMapping(value="/corporation/join/admin", method=RequestMethod.POST)
		public ModelAndView adminJoinCorporationPost(
				CorporationDTO corDTO, ModelAndView mv, RedirectView rv,HttpServletRequest request) {
			System.out.println("CorpController.join.Corp "+request.getMethod()+"method");
			System.out.println("전달 파라미터 = "+corDTO);
			//비즈니스 로직
			corSVC.corpInsert(corDTO);
			//뷰지정
			rv.setUrl(request.getContextPath()+"/corporation/admin.com");
			mv.setView(rv);
			return mv;
		}
		
		@ResponseBody
		@RequestMapping("/corpIdChk")
		public String corpIdChk(CorporationDTO corDTO) {
			String data=null;
			corDTO = corSVC.getCorpID(corDTO);
			System.out.println(corDTO);
			if (corDTO != null) {
				data="fail";
			} else if(corDTO == null) {
				data="success";
			}
			return data;
		}
}