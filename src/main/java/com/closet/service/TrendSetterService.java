package com.closet.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.closet.dao.HashTagDao;
import com.closet.dao.MyClosetDao;
import com.closet.dao.TrendSetterDao;
import com.closet.util.Paging;
import com.closet.vo.CodiBoardVo;
import com.closet.vo.CommentVo;
import com.closet.vo.HashTagVo;
import com.closet.vo.TrendSetterVo;

@Service
public class TrendSetterService {
	
	@Autowired
	private TrendSetterDao trendSetterDao;
	
	@Autowired
	private HashTagDao hashTagDao;
	
	@Autowired
	private MyClosetDao myClosetDao;
	
	//중복제거를 하기 위해 먼저 리스트에 모든 boardNo를 담아두기 위한 리스트
	//List<TrendSetterVo> trendTagIncludeList = new ArrayList<TrendSetterVo>();
	
	//트렌드세터 리스트 뿌리기(+선택한 태그가 포함된 리스트 뿌리기)
	public Map<String, Object> trendSetterList(String division, String feel, String delFlag, int follower, String keyword, String searchCate, String gender, 
												int crtPage, int postCnt, int pageBtnCnt) {
		System.out.println("trendSetterService/trendSetterList()");
		
		Map<String, Object> totalMap = new HashMap<String, Object>();
		
		totalMap.put("division", division);
		totalMap.put("feel", feel);
		totalMap.put("delFlag", delFlag);
		totalMap.put("follower", follower);
		totalMap.put("keyword", keyword);
		totalMap.put("searchCate", searchCate);
		totalMap.put("gender", gender);
		
		int totalPostCnt = trendSetterDao.trendSetterListCnt(division, feel, delFlag, follower, keyword, searchCate, gender);
		
		Map<String,Object> pMap = Paging.setPaging(crtPage, postCnt, pageBtnCnt, totalPostCnt);

		totalMap.put("startPostNo", pMap.get("startPostNo"));
		totalMap.put("endPostNo", pMap.get("endPostNo"));
		
	
		List<TrendSetterVo> trendSetterList = trendSetterDao.trendSetterList(totalMap);
		
		pMap.put("trendSetterList", trendSetterList);
		
		return pMap;
	}
	
	//선택한 태그가 포함된 리스트 뿌리기
	public Map<String, Object> trendTagResultList(String division, String feel, String delFlag, List<Integer> tagNoList, int follower, String gender,
													int crtPage, int postCnt, int pageBtnCnt) {
		System.out.println("trendSetterService/trendTagResultList()");
		//List<TrendSetterVo> trendTagResultList = new ArrayList<TrendSetterVo>();
	
		//태그 한개당 조회할때 겹치틑 게시판이 있으므로 중복을 제거하기 위해 리스트 하나더 생성
		List<Integer> resultTagList = new ArrayList<Integer>();
		List<TrendSetterVo> result = new ArrayList<TrendSetterVo>();
		List<TrendSetterVo> emptyTest = new ArrayList<TrendSetterVo>();
		List<TrendSetterVo> test = new ArrayList<TrendSetterVo>();
		
		List<TrendSetterVo> includeTagList = new ArrayList<TrendSetterVo>();
		
		for(int i = 0; i < tagNoList.size(); i++) {
			//List를 또 List에 넣어줘야해서 addAll을 사용 
			includeTagList.addAll(trendSetterDao.includeTagBoardList(tagNoList.get(i)));
		}
		
		for(int i = 0; i < includeTagList.size(); i++) {
			//System.out.println("결과는요: " + i + ", " + includeTagList.get(i));
			
			int boardNo = includeTagList.get(i).getBoardNo();
			
			//boardNo 중복제거 해주는 로직
			if(!resultTagList.contains(boardNo)) {
				resultTagList.add(boardNo);
			}
		}
		//System.out.println("잘나오니 : " + resultTagList);
		Map<String, Object> tagListMap = new HashMap<String, Object>();
		
		tagListMap.put("division", division);
		tagListMap.put("feel", feel);
		tagListMap.put("delFlag", delFlag);
		tagListMap.put("follower", follower);
		tagListMap.put("gender", gender);
		
		int totalPostCnt = resultTagList.size();
		System.out.println("총갯수" + totalPostCnt);
		System.out.println(crtPage + ", " + postCnt + ", " + pageBtnCnt);
		Map<String,Object> tagpMap = Paging.setPaging(crtPage, postCnt, pageBtnCnt, totalPostCnt);
		
		tagListMap.put("startPostNo", tagpMap.get("startPostNo"));
		tagListMap.put("endPostNo", tagpMap.get("endPostNo"));

		//중복제거된 boardNo리스트를 하나씩 꺼내서 게시글들을 조회함.
		for(int i = 0; i < resultTagList.size(); i++) {
			int boardNo = resultTagList.get(i);
			
			tagListMap.put("boardNo", boardNo);
			//조회된 게시글들을 하나의 리스트에 넣어줌
			result.add(trendSetterDao.trendSetterTagBoard(tagListMap));
		}

		int start = (int)tagpMap.get("startPostNo") - 1;
		int end = (int)tagpMap.get("endPostNo");
		
		boolean next = (boolean)tagpMap.get("next");
		int endPageNo = (int)tagpMap.get("endPageNo");

		for(int i = 0; i < result.size(); i++) {
			//성별 선택하면 null인 값들이 들어가서 null제거하고 다시 list에 넣어줌
			if (result.get(i) != null) {
				emptyTest.add(result.get(i));
				//emptyTest 리스트 내림차순
				Collections.sort(emptyTest);
				
			}
		}
		
		//System.out.println("결과 : " + emptyTest);
		
		int listSize = emptyTest.size();

		//다음번호로 넘어가는 화살표가 있을때
		if (next == true) {
			for(int k = start; k < end; k++) {
				test.add(emptyTest.get(k));
				System.out.println("어디타는지 4");
			}
		} 
		//다음번호로 넘어가는 화살표가 없을때
		if (next == false) {
			//클릭한 페이지가 마지막 페이지일때
			if(crtPage == endPageNo) {
				
				System.out.println("start : " + start + ", end : " + end);
				System.out.println("endPageNo : " + endPageNo);
				
				if(listSize < (endPageNo * postCnt)) {	//마지막 페이지를 클릭했을때 페이지에 postCnt 갯수가  부족할때
					for(int j = start; j < start + (listSize - ((endPageNo - 1) * postCnt)); j++) {
						
						test.add(emptyTest.get(j));
					
					}
				} else {	//마지막 페이지를 클릭했을때 게시물 갯수가 postCnt갯수와 같을때
					for(int j = start; j < end; j++) {
						
						test.add(emptyTest.get(j));
					
					}
				}
			} else {	//클릭한 페이지가 마지막 페이지가 아닐때
				for(int j = start; j < end; j++) {
					
					test.add(emptyTest.get(j));
					
				}
			}
		}

		tagpMap.put("trendSetterList", test);
		
		return tagpMap;
	}
	
	//태그 카테고리 조회하기
	public List<HashTagVo> tagCateList() {
		System.out.println("trendSetterService/tagCateList()");
		
		List<HashTagVo> tagCateList = hashTagDao.tagCateList();
		
		return tagCateList;
	}
	
	//전체 태그 리스트 조회하기
	public List<HashTagVo> hashTagList(int tagDivNo) {
		System.out.println("trendSetterService/hashTagList()");
		
		List<HashTagVo> tagList = hashTagDao.hashTagList(tagDivNo);

		return tagList;
	}
	
	//trendSetter 게시판 글 읽기
	public TrendSetterVo trendSetterRead(int boardNo) {
		System.out.println("trendSetterService/trendSetterRead()");
		
		String division = "trendSetter";
		
		return trendSetterDao.codiBoardSelectOne(boardNo, division);
	}

	//trendSetter 게시판 글 한개에 있는 태그 리스트 조회
	public List<HashTagVo> boardTagList(int boardNo) {
		System.out.println("trendSetterService/boardTagList()");
		
		return hashTagDao.boardTagList(boardNo);
	}
	
	
	//trendSetter 게시판 글 한개에 좋아요 갯수 카운드
	public int boardGoodCnt(int boardNo) {
		System.out.println("trendSetterService/boardGoodCnt()");
		
		String feelType = "good";
		
		return trendSetterDao.boardGoodCnt(feelType, boardNo);
	}
	
	//trendSetter 게시판 글 삭제(update)
	public int deleteTrendSetter(int boardNo, String delFlag) {
		System.out.println("trendSetterService/deleteTrendSetter()");
		
		//코디하기 글에서 trendsetterNo를 지움
		myClosetDao.updateNullTSNo(boardNo);
		
		return trendSetterDao.updateDelFlag(boardNo, delFlag);
	}
	
	//선택한 태그 리스트 조회
	public HashTagVo selectTagList(int tagNo) {
		System.out.println("trendSetterService/selectTagList()");
		
		HashTagVo hashTagVo = hashTagDao.selectTagList(tagNo);
		
		return hashTagVo;
	}
	
	//위시리스트 모달화면에 들어갈 해당 게시글 정보 불러오기
	public TrendSetterVo selectBoardImg(int boardNo) {
		System.out.println("trendSetterService/selectBoardImg()");
		
		return trendSetterDao.selectBoardImg(boardNo);
	}
	
	//위시리스트 insert
	public void wishListAdd(int boardNo, int userNo, String content) {
		System.out.println("trendSetterService/wishListAdd()");
		
		trendSetterDao.wishListInsert(boardNo, userNo, content);
	}
	
	//해당 게시물에 좋아요 한 이력이 있는지 조회
	public TrendSetterVo selectFeeling(int userNo, int boardNo) {
		System.out.println("trendSetterDao/selectFeeling");
		
		String feelType = "good";
		
		return trendSetterDao.selectFeeling(feelType, userNo, boardNo);
	}
	
	//좋아요를 취소할때 feeling 테이블에서 삭제 
	public int deleteGood(int userNo, int boardNo) {
		System.out.println("trendSetterDao/deleteGood");
		
		return trendSetterDao.deleteFeeling(userNo, boardNo);
	}
	
	// 좋아요를 선택할때 feeling 테이블에서 insert
	public int insertGood(int userNo, int boardNo) {
		System.out.println("trendSetterDao/insertGood");
		
		String feelType = "good";

		return trendSetterDao.insertFeeling(userNo, boardNo, feelType);
	}

	//댓글 정보 가져오기
	public Map<String, Object> getCmt(int boardNo, int startCmtNo, int endCmtNo){
		System.out.println("[TrendSetterService] getCmt()");
		
		//전체 댓글 갯수 가져오기
		int totalCmtCnt = trendSetterDao.selectCmtOne(boardNo);
		
		//댓글 더보기 활성화 유무 - boolean
		boolean readMore;
		
		if(totalCmtCnt > endCmtNo) {
			readMore = true;
		}else {
			readMore = false;
		}
		
		//갯수를 맞춰서 리스트 불러오기
		Map<String, Object> listInfo = new HashMap<String, Object>();
		listInfo.put("boardNo", boardNo);
		listInfo.put("startCmtNo", startCmtNo);
		listInfo.put("endCmtNo", endCmtNo);
		
		List<CommentVo> cmtList =  trendSetterDao.selectCmtList(listInfo);
		
		Map<String, Object> cMap = new HashMap<String, Object>();
		cMap.put("readMore", readMore);
		cMap.put("cmtList", cmtList);
		
		return cMap;
		
	}
	
	//댓글 등록
	public int writeCmt(CommentVo cVo) {
		System.out.println("[TrendSetterService] writeCmt()");
		
		return trendSetterDao.insertCmt(cVo);
	}
	
	//댓글 삭제
	public int removeCmt(int comNo) {
		System.out.println("[TrendSetterService] removeCmt()");
		
		return trendSetterDao.deleteCmt(comNo);
	}
	
	//댓글 수정
	public int modifyCmt(CommentVo cVo) {
		System.out.println("[TrendSetterService] modifyCmt()");
		
		return trendSetterDao.updateCmt(cVo);
	}
	
	//트렌드세터 글 등록
	public int writeTrendSetter(TrendSetterVo trendSetterVo, List<Integer> selectTagList) {
		System.out.println("[TrendSetterService] writeTrendSetter()");
		
		CodiBoardVo codiBoardVo = new CodiBoardVo();
		codiBoardVo.setBoardNo(trendSetterVo.getBoardNo());
		
		//int insertCnt =
		trendSetterDao.insertTrendSetter(trendSetterVo);
		
		codiBoardVo.setTrendSetterNo(trendSetterVo.getBoardNo());
		
		//int intertTagCnt = 0; 
		for(int i=0; i<selectTagList.size() ; i++) {
			trendSetterVo.setTagNo(selectTagList.get(i));
			//intertTagCnt +=
			trendSetterDao.insertTrendSetterTag(trendSetterVo);
		}
		
		//int doCoidUpdate =
		myClosetDao.updateTrendSetterNo(codiBoardVo);
		
		//String result = "[TrendSetter Insert] " +insertCnt+ ", [TrendSetterTag Insert] " +intertTagCnt+ ", [doCodiPsot update] " +doCoidUpdate ;
		
		return trendSetterVo.getBoardNo();
	}
}
