package com.closet.vo;

public class CodiBoardVo {
	private int boardNo;  /* 게시글번호 */
	private int userNo ; /* 회원식별번호 */
	private String title;  /* 글제목 */
	private String content;/* 글내용 */
	private String division; /* 글분류 */
	private String boardImg; /* 옷사진 */
	private String gender;  /* 성별 */
	private String regDate;  /* 작성시간 */
	private String deadline; /* 요청기한 */
	private int good; /* 좋아요 */
	private int hate; /* 싫어요 */  
	private String openFlag; /* 공개여부 */
	private String delFlag; /* 삭제여부 */
	private int trendSetterNo; /* 트랜드세터 등록 글번호 */
	
	//그외
	private String nickName; /* 별명 */
	private int reCount; /* 답글수 */
	private int matchNo; /*답글 식별번호*/
	private String matchImg; /*답글 이미지*/
	private String adopt; /*채택여부*/
	private String userId; /*유저 아이디*/
	
	//좋아요 싫어요 , 팔로워 팔로잉
	private String feelType; /*좋아요,싫어요*/
	private int feelingNo;	 /*좋아요 번호*/
	private int following;	 /*팔로워 검색기준(글쓴사람 아이디)*/
	private int follower;	 /*팔로잉 검색기준(로그인한 아이디)*/
	
	public CodiBoardVo() {
		super();
	}

	public CodiBoardVo(int boardNo, int userNo, String title, String content, String division, String boardImg,
			String gender, String regDate, String deadline, int good, int hate, String openFlag, String delFlag,
			int trendSetterNo, String nickName, int reCount, int matchNo, String matchImg, String adopt, String userId,
			String feelType, int feelingNo, int following, int follower) {
		super();
		this.boardNo = boardNo;
		this.userNo = userNo;
		this.title = title;
		this.content = content;
		this.division = division;
		this.boardImg = boardImg;
		this.gender = gender;
		this.regDate = regDate;
		this.deadline = deadline;
		this.good = good;
		this.hate = hate;
		this.openFlag = openFlag;
		this.delFlag = delFlag;
		this.trendSetterNo = trendSetterNo;
		this.nickName = nickName;
		this.reCount = reCount;
		this.matchNo = matchNo;
		this.matchImg = matchImg;
		this.adopt = adopt;
		this.userId = userId;
		this.feelType = feelType;
		this.feelingNo = feelingNo;
		this.following = following;
		this.follower = follower;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDivision() {
		return division;
	}

	public void setDivision(String division) {
		this.division = division;
	}

	public String getBoardImg() {
		return boardImg;
	}

	public void setBoardImg(String boardImg) {
		this.boardImg = boardImg;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
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

	public String getOpenFlag() {
		return openFlag;
	}

	public void setOpenFlag(String openFlag) {
		this.openFlag = openFlag;
	}

	public String getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}

	public int getTrendSetterNo() {
		return trendSetterNo;
	}

	public void setTrendSetterNo(int trendSetterNo) {
		this.trendSetterNo = trendSetterNo;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getReCount() {
		return reCount;
	}

	public void setReCount(int reCount) {
		this.reCount = reCount;
	}

	public int getMatchNo() {
		return matchNo;
	}

	public void setMatchNo(int matchNo) {
		this.matchNo = matchNo;
	}

	public String getMatchImg() {
		return matchImg;
	}

	public void setMatchImg(String matchImg) {
		this.matchImg = matchImg;
	}

	public String getAdopt() {
		return adopt;
	}

	public void setAdopt(String adopt) {
		this.adopt = adopt;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFeelType() {
		return feelType;
	}

	public void setFeelType(String feelType) {
		this.feelType = feelType;
	}

	public int getFeelingNo() {
		return feelingNo;
	}

	public void setFeelingNo(int feelingNo) {
		this.feelingNo = feelingNo;
	}

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
		return "CodiBoardVo [boardNo=" + boardNo + ", userNo=" + userNo + ", title=" + title + ", content=" + content
				+ ", division=" + division + ", boardImg=" + boardImg + ", gender=" + gender + ", regDate=" + regDate
				+ ", deadline=" + deadline + ", good=" + good + ", hate=" + hate + ", openFlag=" + openFlag
				+ ", delFlag=" + delFlag + ", trendSetterNo=" + trendSetterNo + ", nickName=" + nickName + ", reCount="
				+ reCount + ", matchNo=" + matchNo + ", matchImg=" + matchImg + ", adopt=" + adopt + ", userId="
				+ userId + ", feelType=" + feelType + ", feelingNo=" + feelingNo + ", following=" + following
				+ ", follower=" + follower + "]";
	}
	
	

	
	
	
	
}
