package com.closet.vo;

public class CommentVo {

	//필드
	private int matchComNo;
	private int userNo;
	private int matchNo;
	private String content;
	private String regDate;
	private String id;
	private String nickName;
	
	//생성자 : 생략(기본 생성자 활용)
	
	//메소드 - getter/setter
	public int getMatchComNo() {
		return matchComNo;
	}
	public void setMatchComNo(int matchComNo) {
		this.matchComNo = matchComNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getMatchNo() {
		return matchNo;
	}
	public void setMatchNo(int matchNo) {
		this.matchNo = matchNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
	//메소드 일반
	@Override
	public String toString() {
		return "CommentVo [matchComNo=" + matchComNo + ", userNo=" + userNo + ", matchNo=" + matchNo + ", content="
				+ content + ", regDate=" + regDate + ", id=" + id + ", nickName=" + nickName + "]";
	}
	
	
}
