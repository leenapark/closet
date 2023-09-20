package com.closet.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.closet.service.UserService;
import com.closet.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping("/loginform")
	public String loginForm() {
		System.out.println("usercontroller");
		
		
		return "user/loginForm";
	}
	
	@RequestMapping("/login")
	public String login(@ModelAttribute UserVo userVo, HttpSession session, Model model) {
		
		System.out.println("UserController login");
		UserVo authVo = userService.login(userVo);
		
		
		if(authVo != null) {

			session.setAttribute("authMember", authVo);
			
			return "redirect:../mycloset/"+authVo.getId()+"/main";
			
		}else {
			//로그인 실패
			return "redirect:loginform?result=fail";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("authMember");
		
		return "redirect:../";
	}
	
	// 소셜 로그인
	@RequestMapping(value="/kakao", produces = "application/json", method = {RequestMethod.GET, RequestMethod.POST})
    public String loginFormWithKakao(@RequestParam(value = "code", required = false) String code, HttpSession session) {
        System.out.println("#########" + code);
        String access_Token = userService.getAccessToken(code);
        System.out.println("###access_Token#### : " + access_Token);        
        
        UserVo userInfo = userService.getUserInfo(access_Token);
        System.out.println("userInfo: " + userInfo);   
        
        if(userInfo != null) {

			session.setAttribute("authMember", userInfo);
			
			return "redirect:../mycloset/"+userInfo.getId()+"/main";
			
		}else {
			//로그인 실패
			return "redirect:loginform?result=fail";
		}
    }
	
	
	// 소셜 로그아웃
	@RequestMapping(value="/kakaologout")
	public String kakaologout(HttpSession session) {
	    userService.kakaoLogout((String)session.getAttribute("access_Token"));
	    session.removeAttribute("access_Token");
	    session.removeAttribute("userId");
	    return "index";
	}
	
	
	@RequestMapping("/joinform")
	public String joinForm() {
		System.out.println("usercontroller joinForm");
		
		return "user/joinForm";
	}
	
	
	/********id check*******/
	@ResponseBody
	@RequestMapping(value="/checkid", method = {RequestMethod.GET, RequestMethod.POST})
	public String checkid(@RequestParam("userId") String id) {
		System.out.println("UserController idcheck: " + id);
		
		String response = userService.checkId(id);
		return response;
	}
	
	/*******nickName check******/
	@ResponseBody
	@RequestMapping(value="/checknickname", method = {RequestMethod.GET, RequestMethod.POST})
	public String checkNickName(@RequestParam("nickName") String nickName) {
		System.out.println("UserController idcheck: " + nickName);
		
		String response = userService.checkNickName(nickName);
		return response;
	}
	
	/*********회원가입*********/
	@RequestMapping(value="/join", method= {RequestMethod.GET, RequestMethod.POST})
	public String join(@ModelAttribute UserVo userVo) {
		System.out.println("join: " + userVo.toString());
		userService.join(userVo);
		
		return	"user/joinOk";
	}
	
	/*******회원정보수정 폼********/
	@RequestMapping("/modifyform")
	public String modifyForm(HttpSession session, Model model) {
		System.out.println("UserController modifyForm");
		UserVo authUser = (UserVo) session.getAttribute("authMember");
		System.out.println("modifyform authUser: " + authUser);

		
		UserVo userVo = userService.modifyform(authUser.getUserNo());
		System.out.println("modifyform userVo: " + userVo);
		
		model.addAttribute("modifyUser", userVo);
		
		return "user/modifyForm";
	}
	
	
	/*****************회원가입 정보 수정********************/
	// 프로필 변경
	@ResponseBody
	@RequestMapping(value="/profile", method = {RequestMethod.PUT, RequestMethod.GET, RequestMethod.POST})
	public UserVo modifyProfile(@RequestParam("file") MultipartFile file, @ModelAttribute UserVo userVo, Model model) {
		System.out.println("UserController modify: " + file);
				
		UserVo vo = userService.profileUpdate(file, userVo);
		System.out.println("vo: " + vo);
		
		
		return vo;
	}
	
	// 비밀번호 변경
	@ResponseBody
	@RequestMapping(value="/newpassword", method = {RequestMethod.GET, RequestMethod.POST})
	public String newpassword(@ModelAttribute UserVo userVo) {
		System.out.println("UserController password: " + userVo);
		
		String result = userService.updatePass(userVo);
		
		return result;
	}
	
	
	// 닉네임 변경
	@ResponseBody
	@RequestMapping(value="/newnickname", method = {RequestMethod.GET, RequestMethod.POST})
	public String newNickName(@ModelAttribute UserVo userVo) {
		System.out.println("UserController modify");
		System.out.println(userVo);
		
		
		String result = userService.modifyNickName(userVo);
		
		return result;
	}
	
	// 이메일 변경
	@ResponseBody
	@RequestMapping(value="/chengeemail", method = {RequestMethod.GET, RequestMethod.POST})
	public String newEmail(@ModelAttribute UserVo userVo) {
		System.out.println("UserController modify");
		System.out.println(userVo);
		
		
		String result = userService.modifyEmail(userVo);
		
		return result;
	}
	
	// 성별 변경
	@ResponseBody
	@RequestMapping(value="/chengegender", method = {RequestMethod.GET, RequestMethod.POST})
	public String newGender(@ModelAttribute UserVo userVo) {
		System.out.println("UserController modify");
		System.out.println(userVo);
		
		
		String result = userService.modifyGender(userVo);
		
		return result;
	}
	
	
}
