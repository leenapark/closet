package com.closet.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	
	@RequestMapping(value="/", method= {RequestMethod.GET,RequestMethod.POST})
	public String mainPage( ) {
		//return"myroom/closet";
		//return"myroom/wishList";
		//return"myroom/styzipList";
		//return"main/index";
		return"main/main";
	}
	
	@RequestMapping(value="/test", method= {RequestMethod.GET,RequestMethod.POST})
	public String test( ) {

		return"test";
	}
}
