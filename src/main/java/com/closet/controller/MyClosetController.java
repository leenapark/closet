package com.closet.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.closet.service.FollowService;
import com.closet.service.MyClosetService;
import com.closet.service.TrendSetterService;
import com.closet.vo.CodiBoardVo;
import com.closet.vo.MyRoomVo;
import com.closet.vo.UserVo;

@Controller
@RequestMapping(value = "/mycloset", method = { RequestMethod.GET, RequestMethod.POST })
public class MyClosetController {

	@Autowired
	private MyClosetService myClosetService;
	@Autowired
	private FollowService followService;
	@Autowired
	private TrendSetterService trendSetterService;

	// 마이룸 메인
	@RequestMapping(value = "/{userId}/main", method = { RequestMethod.GET, RequestMethod.POST })
	public String myroomMain(@PathVariable("userId") String id, HttpSession session) {
		// myRoom 정보 가져오기(내꺼 혹은 다른 사람꺼)
		MyRoomVo myRoomVo = myClosetService.getMyRoomData(id);
		if (myRoomVo != null) {

			int sessionUserNo = 0;
			// 팔로우 몇명 팔로잉 몇명 팔로우 했는지
			if (session.getAttribute("authMember") != null) {
				sessionUserNo = ((UserVo) session.getAttribute("authMember")).getUserNo();
				// today랑 total 올리기
				if (sessionUserNo != myRoomVo.getUserNo()) {
					Integer todayCount = myClosetService.todayTotal(myRoomVo.getUserNo());
					myRoomVo = myClosetService.getMyRoomData(id);
					myRoomVo.setTodayVisit(todayCount);
				}
			}
			Integer todayCount = myClosetService.getTodayCount(myRoomVo.getUserNo());
			if (todayCount != null) {
				myRoomVo.setTodayVisit(todayCount);
			} else {
				myRoomVo.setTodayVisit(0);
			}
			Map<String, Object> follow = followService.myClosetFollow(myRoomVo.getUserNo(), sessionUserNo);
			session.setAttribute("follow", follow);
			session.setAttribute("myRoomVo", myRoomVo);

			return "mycloset/main";
		} else {
			// 없는 사람 페이지 들어가면
			return "";
		}
	}

	@RequestMapping(value = "/{userId}/closet", method = { RequestMethod.GET, RequestMethod.POST })
	public String closet(@RequestParam(name = "clothCategory", required = false, defaultValue = "0") int clothCategory,
			@RequestParam(name = "crtPage", required = false, defaultValue = "1") int crtPage,
			@PathVariable("userId") String id, HttpSession session, Model model) {

		MyRoomVo myRoomVo = (MyRoomVo) session.getAttribute("myRoomVo");

		int listCnt = 15; // 페이지당 글 갯수
		int pageBtnCount = 5; // 페이지 버튼 갯수

		Map<String, Object> pMap = myClosetService.getClothesList(myRoomVo.getUserNo(), clothCategory, crtPage, listCnt,
				pageBtnCount);

		model.addAttribute("clothCategory", clothCategory);
		model.addAttribute("pMap", pMap);

		return "mycloset/closet";
	}

	@RequestMapping(value = "/{userId}/closet/deleteClothes", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteClothes(@RequestParam("clothNo") int clothNo) {
		myClosetService.deleteClothes(clothNo);
		return "redirect:./";
	}

	@RequestMapping(value = "/{userId}/wishList", method = { RequestMethod.GET, RequestMethod.POST })
	public String getWishList(@RequestParam(name = "crtPage", required = false, defaultValue = "1") int crtPage,
			HttpSession session, Model model) {

		MyRoomVo myRoomVo = (MyRoomVo) session.getAttribute("myRoomVo");

		int listCnt = 15; // 페이지당 글 갯수
		int pageBtnCount = 5; // 페이지 버튼 갯수

		Map<String, Object> pMap = myClosetService.getWishList(myRoomVo.getUserNo(), crtPage, listCnt, pageBtnCount);
		model.addAttribute("pMap", pMap);

		return "mycloset/wishList";
	}

	@RequestMapping(value = "/{userId}/wishList/deleteWishList", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteWishList(@RequestParam("wishNo") int wishNo) {
		myClosetService.deleteWishList(wishNo);
		return "redirect:./";
	}

	// 코디구함 작성글
	@RequestMapping(value = "/{userId}/styzipList", method = { RequestMethod.GET, RequestMethod.POST })
	public String styzipList(@RequestParam(name = "categoryNo", required = false, defaultValue = "0") int categoryNo,
			@RequestParam(name = "crtPage", required = false, defaultValue = "1") int crtPage, HttpSession session,
			Model model) {

		MyRoomVo myRoomVo = (MyRoomVo) session.getAttribute("myRoomVo");

		int listCnt = 8; // 페이지당 글 갯수
		int pageBtnCount = 5; // 페이지 버튼 갯수

		Map<String, Object> pMap = myClosetService.getStyleMatchList(myRoomVo.getUserNo(), crtPage, categoryNo, listCnt,
				pageBtnCount);
		model.addAttribute("categoryNo", categoryNo);
		model.addAttribute("pMap", pMap);

		return "mycloset/styzipList";
	}

	// 코디구함 삭제(delFlag->'Y'로 변경)
	@RequestMapping(value = "/{userId}/styzipList/deletestyzipList", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteStyZipList(@RequestParam("boardNo") int boardNo) {
		myClosetService.deleteStyZipList(boardNo);
		return "redirect:./";
	}

	// 코디하기 메인
	@RequestMapping(value = "/{userId}/doCodi", method = { RequestMethod.GET, RequestMethod.POST })
	public String doCodi(@RequestParam(value = "listType", required = false, defaultValue = "0") int listType,
			@RequestParam(value = "crtPage", required = false, defaultValue = "-1") int crtPage, HttpSession session,
			Model model) {
		/*
		 * listType : 0일 때 전체, 1일때 Trend Setter에 등록하지 않은 코디하기글만, 2일때 Trend Setter에 등록한
		 * 글만
		 */
		int authUserNo;
		
		MyRoomVo myRoomVo = (MyRoomVo) session.getAttribute("myRoomVo");
		
		UserVo authMember = ((UserVo) session.getAttribute("authMember"));
		
		if (authMember == null) {
			authUserNo = -1;
		} else {
			authUserNo = authMember.getUserNo();
		}
		
		System.out.println("/" + myRoomVo.getId() + "/doCodi");

		int listCnt = 10; // 페이지당 글 갯수
		int pageBtnCount = 5; // 페이지 버튼 갯수

		model.addAttribute("pMap", myClosetService.getCodiList(myRoomVo.getUserNo(), authUserNo, listType, crtPage, listCnt, pageBtnCount));

		return "mycloset/doCodi";
	}

	// 코디하기 글쓰기폼
	@RequestMapping(value = "/{userId}/codiWriteForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String codiWriteForm(@RequestParam(name = "no", required = false, defaultValue = "-1") int boardNo,
			Model model) {
		System.out.println("[MyClosetController] codiWriteForm/");

		model.addAttribute("bMap", myClosetService.getCodiModify(boardNo));
		System.out.println(myClosetService.getCodiModify(boardNo));

		return "mycloset/codiWriteForm";

	}

	// 코디하기 글쓰기 폼 옷장 리스트 ajax
	@RequestMapping(value = "/{userNo}/getCloset", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> getCloset(@PathVariable("userNo") int userNo,
			@RequestParam(name = "clothCategory", required = false, defaultValue = "0") int clothCategory,
			@RequestParam(name = "crtPage", required = false, defaultValue = "1") int crtPage, HttpSession session) {
		System.out.println("[MyClosetController] /" + userNo + "/getCloset");

		System.out.println(clothCategory);

		int listCnt = 10; // 페이지당 글 갯수
		int pageBtnCount = 5; // 페이지 버튼 갯수
		Map<String, Object> pMap = myClosetService.getClothesList(userNo, clothCategory, crtPage, listCnt,
				pageBtnCount);

		pMap.put("clothCategory", clothCategory);
		System.out.println(pMap);

		return pMap;

	}

	// 코디하기 글읽기
	@RequestMapping(value = "/{userId}/readCodi", method = { RequestMethod.GET, RequestMethod.POST })
	public String readCodi(@RequestParam(value = "no") int boardNo, Model model) {
		System.out.println("[MyClosetController] readCodi/");

		model.addAttribute("tagCateList", trendSetterService.tagCateList());
		model.addAttribute("codiPost", myClosetService.getCodiPost(boardNo));

		return "mycloset/readCodi";

	}

	// 옷 넣기
	@RequestMapping(value = "/{userId}/insertClothes", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String insertClothes(@PathVariable("userId") String id, @RequestParam("file") MultipartFile file,
			@RequestParam("data") String jsonFile) {

		myClosetService.insertClothes(file, jsonFile);

		return "/closet/mycloset/" + id + "/closet";
	}

	// 코디하기 글쓰기
	@RequestMapping(value = "/{userNo}/writeCodi", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String writeCodi(@PathVariable("userNo") int userNo, @ModelAttribute CodiBoardVo codiBoardVo,
			@RequestParam(name = "clothInCanvas", required = false, defaultValue = "-0") String clothInCanvas,
			@RequestParam(name = "boardNo", required = false, defaultValue = "-1") int boardNo,
			@RequestParam("canvasImg") String canvasImg) {
		System.out.println("[MyClosetController] /" + userNo + "/writeCodi");

		return myClosetService.writeCodi(codiBoardVo, clothInCanvas, canvasImg, boardNo);
	}

	// 코디하기 글삭제
	@RequestMapping(value = "/{userId}/removeCodi", method = { RequestMethod.GET, RequestMethod.POST })
	public String removeCodi(@PathVariable("userId") String id, @ModelAttribute CodiBoardVo codiBoardVo) {
		System.out.println("[MyClosetController] removeCodi/");

		myClosetService.removeCodi(codiBoardVo);

		return "redirect:/mycloset/" + id + "/doCodi";

	}

	// 코디하기 공개 비공개 설정
	@RequestMapping(value = "/{userId}/setOpenStat", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public int setOpenStat(@PathVariable("userId") String userId, @ModelAttribute CodiBoardVo codiBoardVo) {
		System.out.println("[MyClosetController] /" + userId + "/setOpenStat");
		
		return myClosetService.modifyOpenFlag(codiBoardVo);
	}
}