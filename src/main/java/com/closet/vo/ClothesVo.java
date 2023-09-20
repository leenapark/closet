package com.closet.vo;

public class ClothesVo {

	private int clothNo;
	private int userNo;
	private int clothCateNo;
	private String clothImg;
	private String clothInfo;
	private String clothName;
	private String regDate;
	private String delFlag;
	public int getClothNo() {
		return clothNo;
	}
	public void setClothNo(int clothNo) {
		this.clothNo = clothNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getClothCateNo() {
		return clothCateNo;
	}
	public void setClothCateNo(int clothCateNo) {
		this.clothCateNo = clothCateNo;
	}
	public String getClothImg() {
		return clothImg;
	}
	public void setClothImg(String clothImg) {
		this.clothImg = clothImg;
	}
	public String getClothInfo() {
		return clothInfo;
	}
	public void setClothInfo(String clothInfo) {
		this.clothInfo = clothInfo;
	}
	public String getClothName() {
		return clothName;
	}
	public void setClothName(String clothName) {
		this.clothName = clothName;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	@Override
	public String toString() {
		return "ClothesVo [clothNo=" + clothNo + ", userNo=" + userNo + ", clothCateNo=" + clothCateNo + ", clothImg="
				+ clothImg + ", clothInfo=" + clothInfo + ", clothName=" + clothName + ", regDate=" + regDate
				+ ", delFlag=" + delFlag + "]";
	}
}
