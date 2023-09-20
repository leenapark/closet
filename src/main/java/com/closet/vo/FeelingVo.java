package com.closet.vo;

public class FeelingVo {

	private int feelingNo;
	private int userNo;
	private int matchNo;
	private int boardNo;
	private String feelType;
	private int good;
	private int hate;
	
	public int getFeelingNo() {
		return feelingNo;
	}
	public void setFeelingNo(int feelingNo) {
		this.feelingNo = feelingNo;
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
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getFeelType() {
		return feelType;
	}
	public void setFeelType(String feelType) {
		this.feelType = feelType;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getHate() {
		return hate;
	}
	public void setHate(int hate) {
		this.hate = hate;
	}
	@Override
	public String toString() {
		return "FeelingVo [feelingNo=" + feelingNo + ", userNo=" + userNo + ", matchNo=" + matchNo + ", boardNo="
				+ boardNo + ", feelType=" + feelType + ", good=" + good + ", hate=" + hate + "]";
	}
}
