package com.closet.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.closet.vo.RankVo;
import com.closet.vo.UserVo;

@Repository
public class RankDao {

	@Autowired
	private SqlSession sqlsession;
	
	public List<UserVo> selectPointList(){
		System.out.println("rankDao selectPointList");
		
		return sqlsession.selectList("rank.pointList");
	}
	
	public List<RankVo> selectgoodMap(){
		System.out.println("rankService goodMap");
		
		return sqlsession.selectList("rank.goodList");
	}
	
	
}
