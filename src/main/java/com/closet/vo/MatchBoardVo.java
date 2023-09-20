package com.closet.vo;

public class MatchBoardVo {

	private int matchNo;
	private int userNo;
	private int boardNo;
	private String title;
	private String content;
	private String regDate;
	private String matchImg;
	
	public int getMatchNo() {
		return matchNo;
	}
	public void setMatchNo(int matchNo) {
		this.matchNo = matchNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMatchImg() {
		return matchImg;
	}
	public void setMatchImg(String matchImg) {
		this.matchImg = matchImg;
	}
	@Override
	public String toString() {
		return "MatchBoardVo [matchNo=" + matchNo + ", userNo=" + userNo + ", boardNo=" + boardNo + ", title=" + title
				+ ", content=" + content + ", regDate=" + regDate + ", matchImg=" + matchImg + "]";
	}
}
