package com.closet.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.closet.service.RankService;
import com.closet.vo.RankVo;
import com.closet.vo.UserVo;

@Controller
public class RankController {

	@Autowired
	private RankService rankService;
	
	@RequestMapping(value="/rank", method = {RequestMethod.GET, RequestMethod.POST})
	public String lank(Model model) {
		System.out.println("LankController");
		
		List<UserVo> pointList = rankService.bestPoint();
		System.out.println(pointList);
		model.addAttribute("pointList", pointList);
		
		List<RankVo> goodList = rankService.goodList();
		System.out.println(goodList);
	    model.addAttribute("goodList", goodList);
	    
		return "rank/rank";
	}
	
}
