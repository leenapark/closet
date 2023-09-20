package com.closet.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.closet.dao.RankDao;
import com.closet.vo.RankVo;
import com.closet.vo.UserVo;

@Service
public class RankService {

	@Autowired
	private RankDao RankDao;
	
	
	public List<UserVo> bestPoint(){
		System.out.println("LankService bestPoint");
		
		return RankDao.selectPointList();
	}
	
	public List<RankVo> goodList(){
		System.out.println("RankService goodMap");
		
		return RankDao.selectgoodMap();
	}
	
}
