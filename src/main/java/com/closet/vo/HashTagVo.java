package com.closet.vo;

public class HashTagVo {
	
	private int boardNo;		//게시글번호
	private int tagNo;			//태그번호
	private int tagDivNo;		//태그분류번호
	private String tagName;		//태그이름
	private String tagStatus;	//상황별
	
	public HashTagVo() {}
	
	public HashTagVo(int boardNo, int tagNo, int tagDivNo, String tagName, String tagStatus) {
		super();
		this.boardNo = boardNo;
		this.tagNo = tagNo;
		this.tagDivNo = tagDivNo;
		this.tagName = tagName;
		this.tagStatus = tagStatus;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getTagNo() {
		return tagNo;
	}

	public void setTagNo(int tagNo) {
		this.tagNo = tagNo;
	}

	public int getTagDivNo() {
		return tagDivNo;
	}

	public void setTagDivNo(int tagDivNo) {
		this.tagDivNo = tagDivNo;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public String getTagStatus() {
		return tagStatus;
	}

	public void setTagStatus(String tagStatus) {
		this.tagStatus = tagStatus;
	}

	@Override
	public String toString() {
		return "HashtagVo [boardNo=" + boardNo + ", tagNo=" + tagNo + ", tagDivNo=" + tagDivNo + ", tagName=" + tagName
				+ ", tagStatus=" + tagStatus + "]";
	}
	
	
}
