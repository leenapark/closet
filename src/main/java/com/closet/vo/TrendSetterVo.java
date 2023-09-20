package com.closet.vo;

public class TrendSetterVo implements Comparable<TrendSetterVo>{

	private String nickName;	//별명
	private String id;			//사용자아이디
	private int boardNo;		//게시판글번호
	private int userNo;			//회원번호
	private String title;		//게시판 제목
	private String content;		//게시판 내용
	private String division;	//게시판 구분
	private String boardImg;	//게시판 이미지
	private String gender;		//성별
	private String regDate;		//작성시간
	private String deadline;	//요청기한
	private int good;			//좋아요
	private int hate;			//싫어요
	private String openFlag;	//공개여부
	private String delFlag;		//삭제여부
	private int commentCnt;		//댓글갯수
	private int goodCnt;		//좋아요갯수
	private int tagNo;			//태그번호
	private int tagDivNo;		//태그분류번호
	private String tagName;		//태그이름
	private String tagStatus;	//태그상황별
	private String feelType;	//좋아요,싫어요
	private int feelingNo;		//좋아요 번호
	private int following;		//팔로워 검색기준(글쓴사람 아이디)
	private int follower;		//팔로잉 검색기준(로그인한 아이디)
	
	
	public TrendSetterVo() {}

	public TrendSetterVo(int boardNo) {
		this.boardNo = boardNo;
	}

	public TrendSetterVo(String nickName, String id, int boardNo, int userNo, String title, String content,
			String division, String boardImg, String gender, String regDate, String deadline, int good, int hate,
			String openFlag, String delFlag, int commentCnt, int goodCnt, int tagNo, int tagDivNo, String tagName,
			String tagStatus, String feelType, int feelingNo, int following, int follower) {
		this.nickName = nickName;
		this.id = id;
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
		this.commentCnt = commentCnt;
		this.goodCnt = goodCnt;
		this.tagNo = tagNo;
		this.tagDivNo = tagDivNo;
		this.tagName = tagName;
		this.tagStatus = tagStatus;
		this.feelType = feelType;
		this.feelingNo = feelingNo;
		this.following = following;
		this.follower = follower;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
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

	public int getCommentCnt() {
		return commentCnt;
	}


	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	public int getGoodCnt() {
		return goodCnt;
	}

	public void setGoodCnt(int goodCnt) {
		this.goodCnt = goodCnt;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public int compareTo(TrendSetterVo o) {
		// TODO Auto-generated method stub
		if (this.boardNo > o.getBoardNo()) {
			return -1;
		} else if (this.boardNo < o.getBoardNo()) {
			return 1;
		}
		return 0;
	}


	@Override
	public String toString() {
		return "TrendSetterVo [nickName=" + nickName + ", id=" + id + ", boardNo=" + boardNo + ", userNo=" + userNo
				+ ", title=" + title + ", content=" + content + ", division=" + division + ", boardImg=" + boardImg
				+ ", gender=" + gender + ", regDate=" + regDate + ", deadline=" + deadline + ", good=" + good
				+ ", hate=" + hate + ", openFlag=" + openFlag + ", delFlag=" + delFlag + ", commentCnt=" + commentCnt
				+ ", goodCnt=" + goodCnt + ", tagNo=" + tagNo + ", tagDivNo=" + tagDivNo + ", tagName=" + tagName
				+ ", tagStatus=" + tagStatus + ", feelType=" + feelType + ", feelingNo=" + feelingNo + ", following="
				+ following + ", follower=" + follower + ", getNickName()=" + getNickName() + ", getBoardNo()="
				+ getBoardNo() + ", getUserNo()=" + getUserNo() + ", getTitle()=" + getTitle() + ", getContent()="
				+ getContent() + ", getDivision()=" + getDivision() + ", getBoardImg()=" + getBoardImg()
				+ ", getGender()=" + getGender() + ", getRegDate()=" + getRegDate() + ", getDeadline()=" + getDeadline()
				+ ", getGood()=" + getGood() + ", getHate()=" + getHate() + ", getOpenFlag()=" + getOpenFlag()
				+ ", getDelFlag()=" + getDelFlag() + ", getCommentCnt()=" + getCommentCnt() + ", getGoodCnt()="
				+ getGoodCnt() + ", getTagNo()=" + getTagNo() + ", getTagDivNo()=" + getTagDivNo() + ", getTagName()="
				+ getTagName() + ", getTagStatus()=" + getTagStatus() + ", getFeelType()=" + getFeelType()
				+ ", getFeelingNo()=" + getFeelingNo() + ", getFollowing()=" + getFollowing() + ", getFollower()="
				+ getFollower() + ", getId()=" + getId() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}


}
