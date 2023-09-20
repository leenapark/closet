package com.closet.vo;

public class UserVo {
	
	private int userNo;
	private String id;
	private String password;
	private String name;
	private String email;
	private String gender;
	private String nickName;
	private String joinData;
	private String profileImg;
	private int point;
	private int todayVisit;
	private int totalVisit;
	private int rank;
	
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getJoinData() {
		return joinData;
	}
	public void setJoinData(String joinData) {
		this.joinData = joinData;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}	
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getTodayVisit() {
		return todayVisit;
	}
	public void setTodayVisit(int todayVisit) {
		this.todayVisit = todayVisit;
	}
	public int getTotalVisit() {
		return totalVisit;
	}
	public void setTotalVisit(int totalVisit) {
		this.totalVisit = totalVisit;
	}
	
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	
	@Override
	public String toString() {
		return "UserVo [userNo=" + userNo + ", id=" + id + ", password=" + password + ", name=" + name + ", email="
				+ email + ", gender=" + gender + ", nickName=" + nickName + ", joinData=" + joinData + ", profileImg="
				+ profileImg + ", point=" + point + ", todayVisit=" + todayVisit + ", totalVisit=" + totalVisit
				+ ", rank=" + rank + "]";
	}
}
