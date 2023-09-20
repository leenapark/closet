package com.closet.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.closet.service.StyleMatchService;
import com.closet.vo.ClothesVo;
import com.closet.vo.CodiBoardVo;
import com.closet.vo.CodiImgVo;
import com.closet.vo.CommentVo;
import com.closet.vo.FeelingVo;
import com.closet.vo.UserVo;

@Controller
@RequestMapping(value="/styleMatch")
public class StyleMatchController {
	
	@Autowired
	private StyleMatchService styleMatchService;
	
	
	//styleMatch 화면 리스트 불러오기
	@RequestMapping(value="/codi", method= {RequestMethod.GET,RequestMethod.POST})
	public String codiBoard(Model model,
							@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
		 					@RequestParam(value = "searchCate", required = false, defaultValue = "") String searchCate,
							@RequestParam(value = "gender", required = false, defaultValue = "") String gender,
							@RequestParam(value = "crtPage", required = false, defaultValue = "1") int crtPage,
							HttpSession session){
		
		//페이징에 필요
		int postCnt = 15;
		int pageBtnCnt = 5;
		
		System.out.println("컨트롤러 codilist");
		System.out.println("검색 키워드 :" + keyword + "카테고리 (별명,아이디) :" +  searchCate );

		//List<CodiBoardVo> matchBoardList = styleMatchService.matchBoardList( keyword, searchCate , gender , crtPage , postCnt , pageBtnCnt );
		
		//팔로워 팔로우
		int follower;

		if (((UserVo) session.getAttribute("authMember")) == null) {
			follower = -1;
		} else {
			follower = ((UserVo) session.getAttribute("authMember")).getUserNo();
		}
		
		
		//맵으로
		Map<String , Object> pMap = styleMatchService.matchBoardList( keyword, searchCate , gender , crtPage , postCnt , pageBtnCnt , follower );
		
		model.addAttribute("pMap", pMap);
		model.addAttribute("mList", pMap.get("matchBoardList"));
		
		//System.out.println(matchBoardList);
		
		//데이터 보내기
		//model.addAttribute("mList", matchBoardList);
		
		//성별 분류를 위해서
		model.addAttribute("gender", gender);
		

		return"stylematch/codilist";
		
	}
	
	
	//스타일 매칭 게시글 하나 불러오기
	@RequestMapping(value="{boardNo}/codiRead", method= {RequestMethod.GET,RequestMethod.POST})
	public String codiBoardRead(@PathVariable("boardNo") int boardNo,
								@RequestParam(value = "adopt", required = false, defaultValue = "0") int adopt,
								@RequestParam(value = "order", required = false, defaultValue = "0") int order,
								@RequestParam(value = "crtPage", required = false, defaultValue = "1") int crtPage,
								Model model,HttpSession session) {
		
		//boardNo 게시판별 번호로 내용출력
		System.out.println("게시글 읽기 controller" + boardNo);
		
		//boardNo로 게시글 내용 1개 불러오기
		model.addAttribute("boardOne",styleMatchService.codiBoardOne(boardNo));
		
		//페이징에 필요
		int postCnt = 10;
		int pageBtnCnt = 5;
		
		//팔로워 팔로우
		int follower;

		if (((UserVo) session.getAttribute("authMember")) == null) {
			follower = -1;
		} else {
			follower = ((UserVo) session.getAttribute("authMember")).getUserNo();
		}
		
		Map<String , Object> pMap = styleMatchService.reMatchBoardList(boardNo , order, crtPage , follower ,postCnt, pageBtnCnt);
		//글 하나에 달린 답글들 가져오기
		//List<CodiBoardVo> reMatchBoardList = styleMatchService.reMatchBoardList(boardNo);
		//System.out.println(reMatchBoardList.toString());
		
		//model.addAttribute("reBoardList", reMatchBoardList );
		model.addAttribute("pMap", pMap);
		model.addAttribute("reBoardList", pMap.get("reMatchBoardList"));
			
		System.out.println("adopt: " +adopt);
		model.addAttribute("adopt",adopt);
		model.addAttribute("boardNo",boardNo);
		
		return"stylematch/read";
	}
	
	
	
	//스타일 매칭 글쓰기 - 부위별 옷 리스트 가지고 오기
	@RequestMapping(value="/codiWrite", method= {RequestMethod.GET,RequestMethod.POST})
	public String codiBoardWrite(HttpSession session, Model model,ClothesVo clothesVo) {
		
		//세션에서 userNo받아와서 옷정보 불러오기 
			int userNo = ((UserVo)session.getAttribute("authMember")).getUserNo();

			System.out.println(userNo);

			clothesVo.setUserNo(userNo);
			//clothesVo.setClothCateNo(clothCateNo);;

			//List<ClothesVo> closetList = styleMatchService.closetList(clothesVo);
			//System.out.println(closetList);

			//model.addAttribute("cList",closetList);
			
		return"stylematch/writeForm";
		
	}
	
	
	
	//스타일 매칭 답글 글쓰기 폼
	@RequestMapping(value="/reCodiWrite", method= {RequestMethod.GET,RequestMethod.POST})
	public String reCodiBoardWrite(Model model,ClothesVo clothesVo,
								   @RequestParam("boardUserNo") int userNo,
								   @RequestParam("boardNo") int boardNo,
								   //@RequestParam("boardImg") String boardImg,
								   @RequestParam( value ="clothCateNo", required=false, defaultValue="0") int clothCateNo) {
		
		clothesVo.setUserNo(userNo);
		clothesVo.setClothCateNo(clothCateNo);
		
		List<ClothesVo> closetList = styleMatchService.closetList(clothesVo);
		System.out.println(closetList);
		
		//답글쓸때 원글 boardImg 가져와야함
	
		model.addAttribute("cList",closetList);
		model.addAttribute("boardNo",boardNo);
		model.addAttribute("boardUserNo",userNo);
		//model.addAttribute("boardImg",boardImg);
		
		return "stylematch/reWriteForm";
		
	}
	
	

	
	//스타일 매칭 게시글 답글 하나 불러오기
	@ResponseBody
	@RequestMapping(value="{matchNo}/reMatchRead", method= {RequestMethod.GET,RequestMethod.POST})
	public String reMatchRead(@PathVariable("matchNo") int matchNo,
							 @RequestParam("adopt") int adopt,
								Model model) {
		
		//boardNo 게시판별 번호로 내용출력
		System.out.println("게시글 답글 읽기 controller" + matchNo);
		
		//boardNo로 게시글 답글 내용 1개 불러오기
		model.addAttribute("boardOne",styleMatchService.reMatchOne(matchNo));
		
		//글 하나에 달린 답글들 가져오기 --> 대댓글 가져와야함
		List<CodiBoardVo> matchCommentList = styleMatchService.matchCommentList(matchNo);
		System.out.println(matchCommentList);
		
		model.addAttribute("commentList", matchCommentList );
		System.out.println(matchCommentList);
		
		System.out.println("adopt: " +adopt);
		model.addAttribute("adopt",adopt);
			
		return "stylematch/read";
	}
	
	
	//스타일 매칭 답글 채택하기
	@RequestMapping(value="/reMatchAdopt", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String reMatchAdopt(@RequestParam("matchNo") int matchNo,
								@RequestParam("userNo") int userNo,
								@RequestParam("boardNo") int boardNo) {
		
		//adopt 채택여부 'Y'로 엡데이트 , 채택된사람 포인트 + 100
		styleMatchService.reMatchAdopt(matchNo,userNo);
		System.out.println("matchNo:" + matchNo + "userNo :" + userNo + "boardNo" + boardNo);
		
		//본 게시글로 이동 
		return "/closet/styleMatch/"+boardNo+"/codiRead";
		
	}

	//스타일 매칭 인서트
	@RequestMapping(value="/styleMatchInsert", method= {RequestMethod.GET,RequestMethod.POST})
	public String styleMatchInset(@RequestParam("file") String file,
								  @RequestParam("data") String jsonFile,
								  @RequestParam("clothImgData") String clothImgData) {
		
		//받아오는 값 확인하기
		//System.out.println("스타일 매칭 인서트 controller jsonFile :" + jsonFile );
		System.out.println(clothImgData);

		//데이터 보내기
		styleMatchService.styleMatchInset(file , jsonFile, clothImgData);		
		
		return "stylematch/codilist";
		
	}
	
	
	
	//스타일 매칭 글 삭제 
	@RequestMapping(value="/codiDelete", method= {RequestMethod.GET,RequestMethod.POST})
	public String codiDelete(@RequestParam("boardNo") int boardNo) {
		System.out.println("게시글 삭제 controller boardNo : " + boardNo);
		
		styleMatchService.codiDelete(boardNo);
		
		return"redirect:/styleMatch/codi";
		
	}
	
	//스타일 매칭 답글 인서트
	@RequestMapping(value="/insertReply", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String insertReply(@RequestParam("boardNo") int boardNo,
			@RequestParam("file") String file,
			@RequestParam("data") String jsonFile) {
		
		
		styleMatchService.insertReply(file,jsonFile);
		
		return"/closet/styleMatch/"+boardNo+"/codiRead";
	}
	
	//스타일 매칭 답글 삭제
	@RequestMapping(value="/deleteReply", method= {RequestMethod.GET,RequestMethod.POST})
	public String deleteReply(@RequestParam("boardNo") int boardNo,
							  @RequestParam("matchNo") int matchNo) {
		
		styleMatchService.deleteReply(matchNo);
		
		return"redirect:./"+boardNo+"/codiRead";
	}
	
	//대댓글 가져오기
	@RequestMapping(value="/reReCommentList", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<CommentVo> reReCommentList(@RequestParam("matchNo") int matchNo){
		
		return styleMatchService.reReCommentList(matchNo);
	}
	//대댓글 넣기
	@RequestMapping(value="/insertReReComment", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<CommentVo> insertReReComment(@RequestParam("matchNo") int matchNo,
											@RequestParam("content") String content,
											@RequestParam("userNo") int userNo
											){
		styleMatchService.insertReReComment(matchNo,content,userNo);
		return styleMatchService.reReCommentList(matchNo);
	}
	//대댓글 삭제하기
	@RequestMapping(value="/deleteReReComment", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public void deleteReReComment(@RequestParam("matchComNo") int matchComNo
											){
		styleMatchService.deleteReReComment(matchComNo);
	}
	//대댓글 넣기
	@RequestMapping(value="/modiReReComment", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<CommentVo> modiReReComment(@RequestParam("matchComNo") int matchComNo,
										   @RequestParam("content") String content,
										   @RequestParam("matchNo") int matchNo
											){
		styleMatchService.modiReReComment(matchComNo,content);
		return styleMatchService.reReCommentList(matchNo);
	}
	@RequestMapping(value="/getClothes", method= {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public List<CodiImgVo> getClothes(@RequestParam("boardNo") int boardNo
									  ){
		
		return styleMatchService.getClothes(boardNo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/selectFeeling", method = { RequestMethod.GET, RequestMethod.POST })
	public Map<String,Object> selectFeeling(@RequestParam("emotion") int emotion,@RequestParam("matchNo") int matchNo, HttpSession session) {
		
		String like;
		String hate;
		int userNo;

		UserVo authMember = (UserVo) session.getAttribute("authMember");

		if (authMember == null) {
			userNo = -1;
		} else {
			userNo = authMember.getUserNo();
		}
		FeelingVo feelingVo = styleMatchService.selectFeeling(userNo, matchNo,emotion);
		
		if(emotion==1) {	
			Map<String,Object> goodMap = new HashMap<String,Object>();
			
			if (feelingVo == null) {
				like = "unlike";
			} else {
				like = "like";
				goodMap.put("feelingNo", feelingVo.getFeelingNo());
			}
			goodMap.put("like", like);
			goodMap.put("good",styleMatchService.feelingCount(matchNo,emotion));
			return goodMap;
		}else{
			Map<String,Object> hateMap = new HashMap<String,Object>();
			
			if (feelingVo == null) {
				hate = "nohate";
			} else {
				hate = "hate";
				hateMap.put("feelingNo", feelingVo.getFeelingNo());
			}
			hateMap.put("hate", hate);
			hateMap.put("hateCount",styleMatchService.feelingCount(matchNo,emotion));
			return hateMap;
		}
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteFeeling", method = { RequestMethod.GET, RequestMethod.POST })
	public String deleteFeeling(@RequestParam("emotion") int emotion, @RequestParam("feelingNo") int feelingNo, HttpSession session) {
		
		int userNo;
		
		UserVo authMember = (UserVo) session.getAttribute("authMember");

		if (authMember == null) {
			userNo = -1;
		} else {
			userNo = authMember.getUserNo();
			styleMatchService.deleteFeeling(userNo,feelingNo,emotion);
		}
		
		
		
		return "success";
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertFeeling", method = { RequestMethod.GET, RequestMethod.POST })
	public String insertFeeling(@RequestParam("emotion") int emotion, @RequestParam("matchNo") int matchNo, HttpSession session) {
		
		int userNo;
		
		UserVo authMember = (UserVo) session.getAttribute("authMember");

		if (authMember == null) {
			userNo = -1;
		} else {
			userNo = authMember.getUserNo();
			styleMatchService.insertFeeling(userNo,matchNo,emotion);
		}
		
		return "success";
	}
	@ResponseBody
	@RequestMapping(value = "/insertWishList", method = { RequestMethod.GET, RequestMethod.POST })
	public String insertWishList(@RequestParam("userNo") int userNo, @RequestParam("matchNo") int matchNo, @RequestParam("content") String content) {
		
		styleMatchService.insertWishList(userNo, matchNo, content);
		
		return "success";
	}
}
