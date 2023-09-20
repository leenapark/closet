package com.closet.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.closet.service.TrendSetterService;
import com.closet.vo.CommentVo;
import com.closet.vo.HashTagVo;
import com.closet.vo.TrendSetterVo;
import com.closet.vo.UserVo;

@Controller
@RequestMapping(value = "/trendSetter")
public class TrendSetterController {

	@Autowired
	private TrendSetterService trendSetterService;

	// trendSetter 리스트 출력
	@RequestMapping(value = "/trendSetterList", method = { RequestMethod.GET, RequestMethod.POST })
	public String trendSetterList(Model model, 
								  HttpSession session, 
								  @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
								  @RequestParam(value = "searchCate", required = false, defaultValue = "") String searchCate,
								  @RequestParam(value = "gender", required = false, defaultValue = "") String gender,
								  @RequestParam(value = "crtPage", required = false, defaultValue = "1") int crtPage) {
									
		System.out.println("TrendSetterController/trendSetterList()");
		
		int postCnt = 15;
		int pageBtnCnt = 5;

		int follower;

		if (((UserVo) session.getAttribute("authMember")) == null) {
			follower = -1;
		} else {
			follower = ((UserVo) session.getAttribute("authMember")).getUserNo();
		}
		// int follower = ((UserVo)session.getAttribute("authMember")).getUserNo();

		String division = "trendSetter";
		String feel = "good";
		String delFlag = "Y";

		Map<String, Object> pMap = trendSetterService.trendSetterList(division, feel, delFlag, follower, keyword, searchCate, gender, crtPage, postCnt, pageBtnCnt);
		// 트렌드세터 리스트 뿌리기
				
		// 태그 카데고리 뿌리기
		List<HashTagVo> tagCateList = trendSetterService.tagCateList();
		//System.out.println("흠 : " + pMap);
		//System.out.println("결과3: " + ((List<TrendSetterVo>)(pMap.get("trendSetterList"))).get(0).getGender());
		model.addAttribute("pMap", pMap);
		model.addAttribute("trendSetterList", pMap.get("trendSetterList"));
		model.addAttribute("gender", gender);
		model.addAttribute("tagCateList", tagCateList);

		return "trendsetter/trendSetterList";
	}

	// trendSetter 선택된 태그가 포함된 리스트 출력
	@ResponseBody
	@RequestMapping(value = "/trendTagResultList", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> trendTagResultList(Model model,
												  @RequestParam(value = "resultListArr[]") List<Integer> tagList,
												  @RequestParam(value = "gender", required = false, defaultValue = "") String gender,
												  @RequestParam(value = "crtPage", required = false, defaultValue = "1") int crtPage,
												  HttpSession session) {
		System.out.println("TrendSetterController/trendTagResultList()");
		
		int follower;
		int postCnt = 15;
		//int postCnt = 3;
		int pageBtnCnt = 5;

		System.out.println("crtPage : " + crtPage);
		if (((UserVo) session.getAttribute("authMember")) == null) {
			follower = -1;
		} else {
			follower = ((UserVo) session.getAttribute("authMember")).getUserNo();
		}

		//List<TrendSetterVo> trendTagResultList = new ArrayList<TrendSetterVo>();

		String division = "trendSetter";
		String feel = "good";
		String delFlag = "Y";

		Map<String, Object> tagpMap = trendSetterService.trendTagResultList(division, feel, delFlag, tagList, follower, gender, crtPage, postCnt, pageBtnCnt);

		System.out.println("컨트롤러 : " + tagpMap);

		return tagpMap;
	}

	// 태그리스트 뿌리기
	@ResponseBody
	@RequestMapping(value = "/hashTagList", method = { RequestMethod.GET, RequestMethod.POST })
	public List<HashTagVo> hashTagList(@RequestParam("tagDivNo") int tagDivNo) {
		System.out.println("TrendSetterController/hashTagList()");

		List<HashTagVo> tagList = trendSetterService.hashTagList(tagDivNo);

		// System.out.println(tagList);
		return tagList;
	}

	// trendSetter 게시판 글 읽기
	@RequestMapping(value = "/readTrendSetter", method = { RequestMethod.GET, RequestMethod.POST })
	public String readTrendSetter(@RequestParam("boardNo") int boardNo, Model model, HttpSession session) {
		System.out.println("TrendSetterController/readTrendSetter()");
		/*
		 * int userNo;
		 * 
		 * UserVo authMember = (UserVo)session.getAttribute("authMember");
		 * 
		 * if (authMember == null) { userNo = -1; } else { userNo =
		 * authMember.getUserNo(); }
		 * 
		 * System.out.println(userNo);
		 */
		// 게시글 한개 조회
		TrendSetterVo trendSetterVo = trendSetterService.trendSetterRead(boardNo);
		// 해당 게시글에 포함되어있는 태그리스트 조회
		List<HashTagVo> tagList = trendSetterService.boardTagList(boardNo);
		// 해당 게시글에 좋아요 갯수 카운트
		int goodCnt = trendSetterService.boardGoodCnt(boardNo);
		// 해당 게시글에 자신이 좋아요를 누른 이력이 있는지 조회
		// TrendSetterVo feelingVo = trendSetterService.selectFeeling(userNo, boardNo);

		Map<String, Object> tsMap = new HashMap<String, Object>();

		tsMap.put("trendSetterVo", trendSetterVo);
		tsMap.put("tagList", tagList);
		tsMap.put("goodCnt", goodCnt);
		// tsMap.put("feelingVo", feelingVo);

		/*
		 * if (feelingVo == null) { tsMap.put("heart", "unlike"); } else {
		 * tsMap.put("heart", "like"); }
		 */
		model.addAttribute("tsMap", tsMap);

		return "trendsetter/readTrendSetter";
	}

	// trendSetter 게시판 글 삭제(update)
	@RequestMapping(value = "/deleteTrendSetter", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteTrendSetter(@RequestParam("boardNo") int boardNo) {
		System.out.println("TrendSetterController/deleteTrendSetter()");

		String delFlag = "N";

		trendSetterService.deleteTrendSetter(boardNo, delFlag);

		return "redirect:/trendSetter/trendSetterList";
	}

	// 선택한 태그 리스트 조회
	@ResponseBody
	@RequestMapping(value = "/selectTagList", method = { RequestMethod.GET, RequestMethod.POST })
	public List<HashTagVo> selectTagList(/* @RequestParam("tagNo") int tagNo */
			@RequestParam(value = "tagNoList[]") List<Integer> tagNoList) {
		System.out.println("TrendSetterController/selectTagList()");

		List<HashTagVo> hashTagVo = new ArrayList<HashTagVo>();

		for (int i = 0; i < tagNoList.size(); i++) {
			hashTagVo.add(trendSetterService.selectTagList(tagNoList.get(i)));
		}

		return hashTagVo;
	}

	@ResponseBody
	@RequestMapping(value = "/selectBoardImg", method = { RequestMethod.GET, RequestMethod.POST })
	public TrendSetterVo selectBoardImg(@RequestParam("boardNo") int boardNo) {
		System.out.println("TrendSetterController/selectTagList()");

		TrendSetterVo boardVo = trendSetterService.selectBoardImg(boardNo);
		// System.out.println("boardVo의 결과 :" + boardVo);

		return boardVo;
	}

	// 위시리스트 추가
	@RequestMapping(value = "/addWishList", method = { RequestMethod.GET, RequestMethod.POST })
	public void addWishList(@RequestParam("boardNo") int boardNo, @RequestParam("userNo") int userNo,
			@RequestParam("content") String content) {
		System.out.println("TrendSetterController/addWishList()");

		trendSetterService.wishListAdd(boardNo, userNo, content);
	}

	// 해당 게시글에 자신이 좋아요를 누른 이력이 있는지 조회
	@ResponseBody
	@RequestMapping(value = "/selectFeeling", method = { RequestMethod.GET, RequestMethod.POST })
	public String selectFeeling(@RequestParam("boardNo") int boardNo, HttpSession session) {
		System.out.println("TrendSetterController/selectFeeling()");

		String like;

		int userNo;

		UserVo authMember = (UserVo) session.getAttribute("authMember");

		if (authMember == null) {
			userNo = -1;
		} else {
			userNo = authMember.getUserNo();
		}

		System.out.println("테스트 : " + userNo);

		TrendSetterVo feelingVo = trendSetterService.selectFeeling(userNo, boardNo);

		if (feelingVo == null) {
			like = "unlike";
		} else {
			like = "like";
		}

		return like;
	}

	// 좋아요 누른 데이터 삭제
	@ResponseBody
	@RequestMapping(value = "/deleteGood", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteGood(@RequestParam("boardNo") int boardNo, HttpSession session) {
		System.out.println("TrendSetterController/deleteGood()");
		int userNo;
		String like;

		UserVo authMember = (UserVo) session.getAttribute("authMember");

		userNo = authMember.getUserNo();

		System.out.println("컨트롤러 boardNo : " + boardNo);
		int cnt = trendSetterService.deleteGood(userNo, boardNo);

		if (cnt == 1) {
			// 삭제가 정상적으로 되면 unlike 상태로 변해야함.
			like = "unlike";
			System.out.println("삭제완료!");
		} else {
			// 삭제가 정상적으로 되지 않았으면 like 상태를 유지
			like = "like";
		}

		return like;
	}

	// 좋아요 누른 데이터 insert
	@ResponseBody
	@RequestMapping(value = "/insertGood", method = { RequestMethod.GET, RequestMethod.POST })
	public String insertGood(@RequestParam("boardNo") int boardNo, HttpSession session) {
		System.out.println("TrendSetterController/insertGood()");
		int userNo;
		String like;

		UserVo authMember = (UserVo) session.getAttribute("authMember");

		userNo = authMember.getUserNo();
		System.out.println("로그인 아이디 : " + userNo);
		int cnt = trendSetterService.insertGood(userNo, boardNo);

		if (cnt == 1) {
			// insert가 정상적으로 되면 like 상태로 변해야함.
			like = "like";
			System.out.println("insert 완료!");
		} else {
			// insert가 정상적으로 되지 않았으면 unlike 상태를 유지
			like = "unlike";
		}

		return like;
	}

	// 게시글당 좋아요 갯수
	@ResponseBody
	@RequestMapping(value = "/goodCnt", method = { RequestMethod.GET, RequestMethod.POST })
	public int goodCnt(@RequestParam("boardNo") int boardNo) {
		System.out.println("TrendSetterController/goodCnt()");

		int goodCnt = trendSetterService.boardGoodCnt(boardNo);

		return goodCnt;
	}

	// 댓글 가져오기 ajax
	@ResponseBody
	@RequestMapping(value = "/getCmt", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String, Object> getCmt(@RequestParam("boardNo") int boardNo,
			@RequestParam("startCmtNo") int startCmtNo,
			@RequestParam("endCmtNo") int endCmtNo,
			HttpSession session) {
		System.out.println("[TrendSetterController] /getCmt");
		
		int authUserNo;
		UserVo authMember = (UserVo) session.getAttribute("authMember");

		if (authMember == null) {
			authUserNo = -1;
		} else {
			authUserNo = authMember.getUserNo();
		}
		
		Map<String, Object> cMap = trendSetterService.getCmt(boardNo, startCmtNo, endCmtNo);
		cMap.put("authUserNo", authUserNo);
		
		return cMap;
	}
	
	//댓글 등록하기 ajax
	@ResponseBody
	@RequestMapping(value = "/writeCmt", method = { RequestMethod.GET, RequestMethod.POST })
	public int writeCmt(@ModelAttribute CommentVo cVo, HttpSession session) {

		System.out.println("[TrendSetterController] /writeCmt");
		cVo.setUserNo(((UserVo) session.getAttribute("authMember")).getUserNo());

		System.out.println(cVo);
		
		return trendSetterService.writeCmt(cVo);
	}
	
	//댓글 삭제하기 ajax
	@ResponseBody
	@RequestMapping(value = "/removeCmt", method = { RequestMethod.GET, RequestMethod.POST })
	public int removeCmt(@RequestParam("comNo") int comNo) {
		System.out.println("[TrendSetterController] /removeCmt");
		
		return trendSetterService.removeCmt(comNo);
	}
	
	//댓글 수정하기 ajax
	@ResponseBody
	@RequestMapping(value = "/modifyCmt", method = { RequestMethod.GET, RequestMethod.POST })
	public int modifyCmt(@ModelAttribute CommentVo cVo) {
		System.out.println("[TrendSetterController] /modifyCmt");
		
		return trendSetterService.modifyCmt(cVo);
	}
	
	//트렌드세터 글 등록하기 ajax
	@ResponseBody
	@RequestMapping(value = "/writeTrendSetter", method = { RequestMethod.GET, RequestMethod.POST })
	public int writeTrendSetter(@ModelAttribute TrendSetterVo trendSetterVo,
								   @RequestParam("selectTagList[]") List<Integer> selectTagList,
								   HttpSession session) {
		System.out.println("[TrendSetterController] /writeTrendSetter");
		
		trendSetterVo.setUserNo(((UserVo) session.getAttribute("authMember")).getUserNo());

		System.out.println(trendSetterVo);
		System.out.println(selectTagList);
		
		return trendSetterService.writeTrendSetter(trendSetterVo, selectTagList);
	}
}
