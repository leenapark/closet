package com.closet.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.closet.service.FollowService;
import com.closet.vo.MyRoomVo;
import com.closet.vo.UserVo;

@Controller
@RequestMapping(value = "/followerfollowing", method = { RequestMethod.GET, RequestMethod.POST })
public class FollowController {

	@Autowired
	private FollowService followService;
	
	@RequestMapping(value = "/toFollow", method = { RequestMethod.GET, RequestMethod.POST })
	public String toFollow(HttpServletRequest request,
						   @RequestParam("following") int following,
						   HttpSession session) {
		
		int follower = ((UserVo)session.getAttribute("authMember")).getUserNo();
		
		followService.toFollow(following,follower);
		//팔로우하고 세션변경
		Map<String,Object> follow = followService.myClosetFollow(following,follower);
		session.setAttribute("follow",follow);
		//이전 페이지 기억하고 해당 일 끝마치면 돌아가기
		String referer = request.getHeader("Referer");
		return "redirect:"+ referer;
	}
	
	@RequestMapping(value = "/unFollow", method = { RequestMethod.GET, RequestMethod.POST })
	public String unFollow(HttpServletRequest request,
						   @RequestParam("following") int following,
			   			   HttpSession session) {
		
		int follower = ((UserVo)session.getAttribute("authMember")).getUserNo();
		
		followService.unFollow(following,follower);
		
		//언팔하고 세션변경
		Map<String,Object> follow = followService.myClosetFollow(following,follower);
		session.setAttribute("follow",follow);
		//이전 페이지 기억하고 해당 일 끝마치면 돌아가기
		String referer = request.getHeader("Referer");
		return "redirect:"+ referer;
	}
	
	//트렌드세터리스트에 팔로우 버튼 클릭
	@RequestMapping(value = "/checkFollow", method = { RequestMethod.GET, RequestMethod.POST })
	public String checkFollow(HttpServletRequest request,
						   	  @RequestParam("following") int following,
						   	  HttpSession session, Model model) {
		System.out.println("followController/checkFollow()");
		
		int follower = ((UserVo)session.getAttribute("authMember")).getUserNo();
		
		followService.toFollow(following,follower);
		
		//이전 페이지 기억하고 해당 일 끝마치면 돌아가기
		String referer = request.getHeader("Referer");
		return "redirect:"+ referer;
	}
	
	//트렌드 세터 리스트에서 팔로잉 버튼 클릭(팔로우 취소)
	@RequestMapping(value="/cancelFollow", method = { RequestMethod.GET, RequestMethod.POST })
	public String cancelFollow(HttpServletRequest request,
						   	   @RequestParam("following") int following,
						   	   HttpSession session, Model model) {
		System.out.println("followController/cancelFollow()");
		
		int follower = ((UserVo)session.getAttribute("authMember")).getUserNo();
		
		followService.unFollow(following, follower);
		
		//이전 페이지 기억하고 해당 일 끝마치면 돌아가기
		String referer = request.getHeader("Referer");
		return "redirect:"+ referer;
	}
	
	
	// 팔로워 리스트
	@RequestMapping(value="/followers", method = { RequestMethod.GET, RequestMethod.POST })
	public String followers(HttpSession session, Model model) {
		System.out.println("FollowController followers");
		
		MyRoomVo myRoomVo = (MyRoomVo) session.getAttribute("myRoomVo");
		System.out.println(myRoomVo);
		
		List<UserVo> followersList = followService.followers(myRoomVo.getUserNo());
		model.addAttribute("followersList", followersList);
		
		
		return "user/followers";
	}
	
	// 팔로잉 리스트
	@RequestMapping(value="/following", method = { RequestMethod.GET, RequestMethod.POST })
	public String following(HttpSession session, Model model) {
		System.out.println("FollowController following");
		
		MyRoomVo myRoomVo = (MyRoomVo) session.getAttribute("myRoomVo");
		System.out.println(myRoomVo);
		
		List<UserVo> followingList = followService.following(myRoomVo.getUserNo());
		model.addAttribute("followingList", followingList);
		
		
		return "user/following";
	}
}
