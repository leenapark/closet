package com.closet.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.closet.dao.FollowDao;
import com.closet.vo.FollowVo;
import com.closet.vo.UserVo;

@Service
public class FollowService {

	@Autowired
	private FollowDao followDao;
	
	public void toFollow(int following, int follower) {
		Map<String,Object> followMap = new HashMap<String,Object>();
		followMap.put("following", following);
		followMap.put("follower", follower);
		
		followDao.toFollow(followMap);
		
	}
	
	public void unFollow(int following, int follower) {
		Map<String,Object> followMap = new HashMap<String,Object>();
		followMap.put("following", following);
		followMap.put("follower", follower);
		
		followDao.unFollow(followMap);
	}
	
	public Map<String,Object> myClosetFollow(int myClosetUserNo,int sessionUserNo) {
		
		Map<String,Object> follow = new HashMap<String,Object>();
		follow.put("followingCount", followDao.countFollwing(myClosetUserNo));
		follow.put("followerCount", followDao.countFollwer(myClosetUserNo));
		Map<String,Object> isFollowMap = new HashMap<String,Object>();
		isFollowMap.put("myClosetUserNo", myClosetUserNo);
		isFollowMap.put("sessionUserNo", sessionUserNo);
		FollowVo followVo = followDao.isFollow(isFollowMap);
		if(followVo == null) {
			follow.put("isFollow",false);
		}else {
			follow.put("isFollow",true);
		}
		
		
		return follow;
	}
	
	// 팔로워
	public List<UserVo> followers(int userNo) {
		System.out.println("followerssevice userNo" + userNo);
		
		return followDao.selectfollowers(userNo);
	}
	
	// 팔로잉
	public List<UserVo> following(int userNo) {
		System.out.println("followerssevice userNo" + userNo);
		
		return followDao.selectfollowing(userNo);
	}
	
}
