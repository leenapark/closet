package com.closet.vo;

public class FollowVo {
	private int following;
	private int follower;
	
	public int getFollowing() {
		return following;
	}
	public void setFollowing(int following) {
		this.following = following;
	}
	public int getFollower() {
		return follower;
	}
	public void setFollower(int follower) {
		this.follower = follower;
	}
	@Override
	public String toString() {
		return "FollowerFollowingVo [following=" + following + ", follower=" + follower + "]";
	}
}
