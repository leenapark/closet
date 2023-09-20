package com.closet.vo;

public class CodiImgVo {
	
	//필드 영역
	private int codiImgNo, boardNo, clothNo, x, y, z, imgHeight, imgWidth;
	private String canvasJson, clothImg;
	
	//생성자 (생략 - 기본생성자 활용)
	
	//메소드 getter/setter
	public int getCodiImgNo() {
		return codiImgNo;
	}
	public void setCodiImgNo(int codiImgNo) {
		this.codiImgNo = codiImgNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getClothNo() {
		return clothNo;
	}
	public void setClothNo(int clothNo) {
		this.clothNo = clothNo;
	}
	public int getX() {
		return x;
	}
	public void setX(int x) {
		this.x = x;
	}
	public int getY() {
		return y;
	}
	public void setY(int y) {
		this.y = y;
	}
	public int getZ() {
		return z;
	}
	public void setZ(int z) {
		this.z = z;
	}
	
	public int getImgWidth() {
		return imgWidth;
	}
	public void setImgWidth(int imgWidth) {
		this.imgWidth = imgWidth;
	}
	public String getCanvasJson() {
		return canvasJson;
	}
	public void setCanvasJson(String canvasJson) {
		this.canvasJson = canvasJson;
	}
	public String getClothImg() {
		return clothImg;
	}
	public void setClothImg(String clothImg) {
		this.clothImg = clothImg;
	}
	public int getImgHeight() {
		return imgHeight;
	}
	public void setImgHeight(int imgHeight) {
		this.imgHeight = imgHeight;
	}
	@Override
	public String toString() {
		return "CodiImgVo [codiImgNo=" + codiImgNo + ", boardNo=" + boardNo + ", clothNo=" + clothNo + ", x=" + x
				+ ", y=" + y + ", z=" + z + ", imgHeight=" + imgHeight + ", imgWidth=" + imgWidth + ", canvasJson="
				+ canvasJson + ", clothImg=" + clothImg + "]";
	}	
}
