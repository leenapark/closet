package com.closet.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.closet.vo.CommentVo;
import com.closet.vo.TrendSetterVo;

@Repository
public class TrendSetterDao {

	@Autowired
	private SqlSession sqlSession;
	
	//트렌드 세터 리스트 가져오기
	public List<TrendSetterVo> trendSetterList(Map<String,Object> totalMap) {
		System.out.println("trendSetterDao/trendSetterList()");
		
		List<TrendSetterVo> trendList = sqlSession.selectList("trendSetter.trendSetterList", totalMap);
		
		//System.out.println("잘 가져오나" + trendList);
		
		return trendList;
	}
	
	//트랜드세터 전체 리스트 갯수 조회
	public int trendSetterListCnt(String division, String feel, String delFlag, int follower, String keyword, String searchCate, String gender) {
		System.out.println("trendSetterDao/trendSetterListCnt()");
		
		Map<String, Object> tMap = new HashMap<String, Object>();
		
		tMap.put("division", division);
		tMap.put("feel", feel);
		tMap.put("delFlag", delFlag);
		tMap.put("follower", follower);
		tMap.put("keyword", keyword);
		tMap.put("searchCate", searchCate);
		tMap.put("gender", gender);
		
		return sqlSession.selectOne("trendSetter.trendSetterListCnt", tMap);
	}
	//트렌드 세터 선택한 태그가 포함된 게시글  가져오기
	public TrendSetterVo trendSetterTagBoard(Map<String,Object> tagListMap) {
		System.out.println("trendSetterDao/trendSetterTagBoard()");

		//System.out.println("테스트 : " + tagListMap);
		TrendSetterVo trendTagBoard = sqlSession.selectOne("trendSetter.includeTagList", tagListMap);
		
		//System.out.println("잘 가져오나" + trendTagBoard);
		
		return trendTagBoard;
	}

	//trend setter 글 읽기(codiboard)
	public TrendSetterVo codiBoardSelectOne(int boardNo, String division) {
		System.out.println("trendSetterDao/codiBoardSelelectOne()");
		
		Map<String, Object> tboardMap = new HashMap<String, Object>();
		
		tboardMap.put("boardNo", boardNo);
		tboardMap.put("division", division);
		
		return sqlSession.selectOne("trendSetter.codiBoardSelectOne", tboardMap);
	}
	
	//trendSetter 게시판 글 한개에 좋아요 갯수 카운드
	public int boardGoodCnt(String feelType, int boardNo) {
		System.out.println("trendSetterDao/boardGoodCnt()");
		
		Map<String, Object> goodMap = new HashMap<String, Object>();
		
		goodMap.put("feelType", feelType);
		goodMap.put("boardNo", boardNo);
		
		return sqlSession.selectOne("trendSetter.boardGoodCount", goodMap);
	}
	
	//trendSetter 게시판 글 삭제(update)
	public int updateDelFlag(int boardNo, String delFlag) {
		System.out.println("trendSetterDao/updateDelFlag()");
		
		Map<String, Object> delMap = new HashMap<String, Object>();
		
		delMap.put("boardNo", boardNo);
		delMap.put("delFlag", delFlag);
		
		return sqlSession.update("trendSetter.updateTrendSetterDelFlag", delMap);
	}
	
	//선택한 태그가 포함된 게시글 리스트
	public List<TrendSetterVo> includeTagBoardList(int tagNo) {
		System.out.println("trendSetterDao/includeTagBoardList()");

		return sqlSession.selectList("trendSetter.includeTagBoardList", tagNo);
	}
	
	//위시리스트 모달화면에 들어갈 해당 게시글 정보 불러오기
	public TrendSetterVo selectBoardImg(int boardNo) {
		System.out.println("trendSetterDao/selectBoardImg()");
		
		return sqlSession.selectOne("trendSetter.selectBoardImg", boardNo);
	}
	
	//위시리스트 insert
	public void wishListInsert(int boardNo, int userNo, String content) {
		System.out.println("trendSetterDao/wishListInsert()");
		
		Map<String, Object> wishMap = new HashMap<String, Object>();
		
		//System.out.println("boardNo :" + boardNo);
		//System.out.println("userNo :" + userNo);
		//System.out.println("content :" + content);
		
		wishMap.put("boardNo", boardNo);
		wishMap.put("userNo", userNo);
		wishMap.put("content", content);
		
		sqlSession.insert("trendSetter.wishListInsert", wishMap);
	}
	
	//해당 게시물에 좋아요 한 이력이 있는지 조회
	public TrendSetterVo selectFeeling(String feelType, int userNo, int boardNo) {
		System.out.println("trendSetterDao/selectFeeling()");
		
		Map<String, Object> feelMap = new HashMap<String, Object>();
		
		feelMap.put("feelType", feelType);
		feelMap.put("boardNo", boardNo);
		feelMap.put("userNo", userNo);
		
		return sqlSession.selectOne("trendSetter.feelingSelect", feelMap);
	}

	//좋아요를 취소할때 feeling 테이블에서 삭제 
	public int deleteFeeling(int userNo, int boardNo) {
		System.out.println("trendSetterDao/deleteFeeling()");
		
		Map<String, Object> feeldelMap = new HashMap<String, Object>();
		
		feeldelMap.put("userNo", userNo);
		feeldelMap.put("boardNo", boardNo);
		
		return sqlSession.delete("trendSetter.deleteFeeling", feeldelMap);
	}
	
	// 좋아요를 선택할때 feeling 테이블에 insert
	public int insertFeeling(int userNo, int boardNo, String feelType) {
		System.out.println("trendSetterDao/insertFeeling()");

		Map<String, Object> feelinsertMap = new HashMap<String, Object>();

		feelinsertMap.put("userNo", userNo);
		feelinsertMap.put("boardNo", boardNo);
		feelinsertMap.put("feelType", feelType);

		return sqlSession.insert("trendSetter.insertFeeling", feelinsertMap);
	}
	
	// 게시글의 댓글 수를 가져옴
	public int selectCmtOne(int boardNo) {
		System.out.println("[TrendSetterDao] selectCmtOne()");
		
		return sqlSession.selectOne("trendSetter.selectCmtOne", boardNo);
	}
	
	// cmtPrintCnt이후 getCmtCnt 수(startCmtNo~endCmtNo)만큼 리스트를 가져옴
	public List<CommentVo> selectCmtList(Map<String, Object> listInfo) {
		System.out.println("[TrendSetterDao] selectCmtList()");
		
		return sqlSession.selectList("trendSetter.selectCmtList", listInfo);
	}
	
	//댓글 등록
	public int insertCmt(CommentVo cVo) {
		System.out.println("[TrendSetterDao] insertCmt()");
		
		return sqlSession.insert("trendSetter.insertCmt", cVo);
		
	}
	
	//댓글 삭제
	public int deleteCmt(int comNo) {
		System.out.println("[TrendSetterDao] deleteCmt()");
		
		return sqlSession.insert("trendSetter.deleteCmt", comNo);
	}
	
	//댓글 수정
	public int updateCmt(CommentVo cVo) {
		System.out.println("[TrendSetterDao] updateCmt()");
		
		return sqlSession.update("trendSetter.updateCmt", cVo);
	}
	
	//트렌드세터 게시글 등록
	public int insertTrendSetter(TrendSetterVo trendSetterVo) {
		System.out.println("[TrendSetterDao] insertTrendSetter()");
		
		return sqlSession.insert("trendSetter.insertTrendSetter", trendSetterVo);
	}
	
	//트렌드세터 게시글 태그 등록
	public int insertTrendSetterTag(TrendSetterVo trendSetterVo) {
		System.out.println("[TrendSetterDao] insertTrendSetterTag()");
		
		return sqlSession.insert("trendSetter.insertTrendSetterTag", trendSetterVo);
	}
}
