package com.closet.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.closet.dao.StyleMatchDao;
import com.closet.util.Paging;
import com.closet.util.ScreenShotSave;
import com.closet.vo.ClothesVo;
import com.closet.vo.CodiBoardVo;
import com.closet.vo.CodiImgVo;
import com.closet.vo.CommentVo;
import com.closet.vo.FeelingVo;
import com.closet.vo.MatchBoardVo;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;



@Service
public class StyleMatchService {
	
	@Autowired
	private StyleMatchDao styleMatchDao;
	
	//스타일 매칭 게시글 리스트 출력
	public Map<String , Object> matchBoardList(String keyword, String searchCate , String gender , int crtPage , int postCnt , int pageBtnCnt , int follower){
		System.out.println("CodiBoardService matchBoardList()");
		
		Map<String, Object> totalMap = new HashMap<String, Object>();
		
		totalMap.put("keyword", keyword);
		totalMap.put("searchCate", searchCate);
		totalMap.put("gender", gender);
		totalMap.put("follower", follower);

		int totalPostCnt = styleMatchDao.matchBoardListCnt(keyword, searchCate, gender,follower);
		
		Map<String,Object> pMap = Paging.setPaging(crtPage, postCnt, pageBtnCnt, totalPostCnt);

		totalMap.put("startPostNo", pMap.get("startPostNo"));
		totalMap.put("endPostNo", pMap.get("endPostNo"));
		
		List<CodiBoardVo> styleMatchResultList = styleMatchDao.matchBoardList(totalMap);
		
		pMap.put("matchBoardList", styleMatchResultList);
		
		return pMap;
		
	}
	
	//게시글 하나만 가져오기
	public CodiBoardVo codiBoardOne(int boardNo) {
				
		System.out.println("게시글 읽기 service" + boardNo);
		
		return styleMatchDao.codiBoardOne(boardNo);

	}
	
	//부위별 옷 리스트 가져오기
	public List<ClothesVo> closetList(ClothesVo clothesVo){
		
		System.out.println("CodiBoardService closetList()");
		
		return styleMatchDao.closetList(clothesVo);
	}
	
	
	//스타일매칭 답글 리스트 출력
	public Map<String , Object> reMatchBoardList(int boardNo ,int order,int crtPage , int follower ,  int postCnt , int pageBtnCnt ){
		System.out.println("CodiBoardService reMatchBoardList()");
		
		Map<String, Object> totalMap = new HashMap<String, Object>();

		totalMap.put("follower", follower);
		totalMap.put("boardNo", boardNo);
		
		int totalPostCnt = styleMatchDao.reMatchBoardListCnt(follower,boardNo);
		
		Map<String,Object> pMap = Paging.setPaging(crtPage, postCnt, pageBtnCnt, totalPostCnt);
		
		totalMap.put("startPostNo", pMap.get("startPostNo"));
		totalMap.put("endPostNo", pMap.get("endPostNo"));
			
		List<CodiBoardVo> reMatchResultList = styleMatchDao.reMatchBoardList(totalMap);
		
		pMap.put("reMatchBoardList",reMatchResultList);
		
		return pMap;
		
	}
	
	//스타일매칭 답글 대댓글 리스트 출력
	public List<CodiBoardVo> matchCommentList(int matchNo){
		System.out.println("CodiBoardService matchCommentLis()");

		return styleMatchDao.matchCommentList(matchNo);
		
	}
	
	
	//게시글 답글 하나만 가져오기
	public CodiBoardVo reMatchOne(int matchNo) {
				
		System.out.println("게시글 읽기 service" + matchNo);
		
		return styleMatchDao.reMatchOne(matchNo);

	}
	
	
	//스타일 매칭 게시글 인서트
	public void styleMatchInset(String file, String jsonFile, String clothImgData) {
		
		System.out.println("스타일 매칭 인서트 service");
		
		String saveDir = "D:/closet/FileUp";
		//String saveDir= "/var/webapps/closet/FileUp"; //리눅스 서버
		
		String saveFileName = ScreenShotSave.saveFile(saveDir, file);
		
		//mapping
		CodiBoardVo codiBoardVo = new CodiBoardVo();
		
		ObjectMapper objectMapper = new ObjectMapper();
        try {
        	codiBoardVo = objectMapper.readValue(jsonFile, CodiBoardVo.class);
        } catch (Exception e) {
           System.out.println(e);
        }

        // clothesVo에 timeMill과 uuid로 바꾼 이미지 이름 넣기
        codiBoardVo.setBoardImg(saveFileName);
        
		
		int boardNo = styleMatchDao.styleMatchInset(codiBoardVo);
		
		
        ObjectMapper codiImgMapper = new ObjectMapper();
        List<CodiImgVo> codiImgList = new ArrayList<CodiImgVo>();
        try {
        	codiImgList = codiImgMapper.readValue(clothImgData, new TypeReference<List<CodiImgVo>>(){});
        }catch(Exception e) {
        	System.out.println(e);
        }

        for(int i=0;i<codiImgList.size();i++) {
        	codiImgList.get(i).setBoardNo(boardNo);
        	styleMatchDao.insertCodiImgList(codiImgList.get(i));
        }
	}
	
	//답글 채택
	public void reMatchAdopt(int matchNo , int userNo) {
		System.out.println("스타일 매칭 답글 채택 service matchNo :"+matchNo +" userNo :" +userNo);
		//채택
		styleMatchDao.reMatchAdopt(matchNo);
		//포인트  + 100
		styleMatchDao.reMatchPoint(userNo);

	}
	
	
	
	//스타일 매칭 삭제 
	
	public void codiDelete(int boardNo) {
		styleMatchDao.codiDelete(boardNo);
	}

	//옷 저장
	public void insertReply(String file, String jsonFile){
		String saveDir = "D:/closet/FileUp";
		//String saveDir= "/var/webapps/closet/FileUp"; //리눅스 서버
		
		String saveFileName = ScreenShotSave.saveFile(saveDir, file);
		
		//mapping
		MatchBoardVo matchBoardVo = new MatchBoardVo();
		
		ObjectMapper objectMapper = new ObjectMapper();
        try {
        	matchBoardVo = objectMapper.readValue(jsonFile, MatchBoardVo.class);
        } catch (Exception e) {
           System.out.println(e);
        }

        // clothesVo에 timeMill과 uuid로 바꾼 이미지 이름 넣기
        matchBoardVo.setMatchImg(saveFileName);
        
        styleMatchDao.insertReply(matchBoardVo);
	}
	//이미지 답글 삭제
	public void deleteReply(int matchNo) {
		styleMatchDao.deleteReply(matchNo);
		
	}
	//대댓글 가져오기
	public List<CommentVo> reReCommentList(int matchNo) {
		
		return styleMatchDao.reReCommentList(matchNo);
	}
	//대댓글 달기
	public void insertReReComment(int matchNo, String content, int userNo) {
		Map<String,Object> insertVo = new HashMap<String,Object>();
		insertVo.put("matchNo", matchNo);
		insertVo.put("content", content);
		insertVo.put("userNo", userNo);
		
		styleMatchDao.insertReReComment(insertVo);
	}
	//대댓글 삭제하기
	public void deleteReReComment(int matchComNo) {
		styleMatchDao.deleteReReComment(matchComNo);
	}

	public void modiReReComment(int matchComNo, String content) {
		Map<String,Object> updateVo = new HashMap<String,Object>();
		updateVo.put("matchComNo", matchComNo);
		updateVo.put("content", content);
		
		styleMatchDao.modiReReComment(updateVo);
	}

	public List<CodiImgVo> getClothes(int boardNo) {
		
		return styleMatchDao.getClothes(boardNo);
	}	
	
	public FeelingVo selectFeeling(int userNo, int matchNo,int emotion) {
		
		String feelType="";
		
		if(emotion == 1) {
			feelType = "good";
		}else {
			feelType = "hate";
		}
		return styleMatchDao.selectFeeling(feelType, userNo, matchNo);
	}

	public void deleteFeeling(int userNo, int feelingNo,int emotion) {
		
		String feelType="";
		
		if(emotion == 1) {
			feelType = "good";
		}else {
			feelType = "hate";
		}
		
		styleMatchDao.deleteFeeling(feelType,userNo,feelingNo);
		
	}
	public int feelingCount(int matchNo,int emotion) {
		
		if(emotion == 1) {
			return styleMatchDao.goodFeelingCount(matchNo);
		}else {
			return styleMatchDao.hateFeelingCount(matchNo);
		}
	}

	public void insertFeeling(int userNo, int matchNo,int emotion) {
		String feelType="";
		
		if(emotion == 1) {
			feelType = "good";
		}else {
			feelType = "hate";
		}
		
		styleMatchDao.insertFeeling(feelType,userNo,matchNo);
		
	}

	public void insertWishList(int userNo, int matchNo, String content) {
		styleMatchDao.insertWishList(userNo,matchNo,content);
		
	}
}
