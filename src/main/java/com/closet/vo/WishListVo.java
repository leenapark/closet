package com.closet.vo;

public class WishListVo {
	private int wishNo;
	private String content;
	private String boardImg;
	private String nickName;
	private String id;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getBoardImg() {
		return boardImg;
	}
	public void setBoardImg(String boardImg) {
		this.boardImg = boardImg;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public int getWishNo() {
		return wishNo;
	}
	public void setWishNo(int wishNo) {
		this.wishNo = wishNo;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "WishListVo [wishNo=" + wishNo + ", content=" + content + ", boardImg=" + boardImg + ", nickName="
				+ nickName + ", id=" + id + "]";
	}
}
