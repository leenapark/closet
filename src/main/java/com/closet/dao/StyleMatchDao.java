package com.closet.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.closet.vo.ClothesVo;
import com.closet.vo.CodiBoardVo;
import com.closet.vo.CodiImgVo;
import com.closet.vo.CommentVo;
import com.closet.vo.FeelingVo;
import com.closet.vo.MatchBoardVo;

@Repository
public class StyleMatchDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	//스타일매치 리스트 가져오기
	public List<CodiBoardVo> matchBoardList(Map<String,Object> totalMap){
		System.out.println("CodiBoardDao matchBoardList()");		
		
		Map<String, Object> sMap = new HashMap<String, Object>();
		
		
		return sqlSession.selectList("style.matchBoardList" , totalMap);	
		
	}	
	
	//스타일 매치 글 갯수 가져오기
	public int matchBoardListCnt(String keyword,String searchCate,String gender, int follower) {
		
		Map<String, Object> sMap = new HashMap<String, Object>();
		
		sMap.put("keyword", keyword);
		sMap.put("searchCate", searchCate);
		sMap.put("gender", gender);
		sMap.put("follower", follower);
		
		return sqlSession.selectOne("style.matchBoardListCnt" , sMap);	
		
	}
	
	//게시글 한개 가져오기
	public CodiBoardVo codiBoardOne(int boardNo) {		
		System.out.println("게시글 읽기 dao" + boardNo);		
		return sqlSession.selectOne("style.matchBoardOne" , boardNo);
	}
	
	//부위별 옷 리스트 가져오기
	public List<ClothesVo> closetList(ClothesVo clothesVo){
		System.out.println("CodiBoardDao closetList()" + clothesVo);
		return sqlSession.selectList("style.matchClosetList" , clothesVo);
	}
		
	//답글 리스트 가져오기
	public List<CodiBoardVo> reMatchBoardList(Map<String,Object> totalMap){
		System.out.println("CodiBoardDao reMatchBoardList()");		
		return sqlSession.selectList("style.reMatchBoardList", totalMap);
		
	}
	
	//스타일 매치 답글 갯수 가져오기
	public int reMatchBoardListCnt(int follower, int boardNo) {
		
		Map<String, Object> sMap = new HashMap<String, Object>();
		
		sMap.put("follower", follower);
		sMap.put("boardNo", boardNo);
		
		return sqlSession.selectOne("style.reMatchBoardListCnt" , sMap);	
		
	}
	
	//답글 대댓글 리스트 가져오기
	public List<CodiBoardVo> matchCommentList(int matchNo){
		System.out.println("CodiBoardDao matchCommentList()");		
		return sqlSession.selectList("style.matchCommentList", matchNo);
		
	}
	
	//스타일 매칭 게시글 인서트
	public int styleMatchInset(CodiBoardVo codiBoardVo) {		
		System.out.println("CodiBoardDao styleMatchInset()");		
		sqlSession.insert("style.styleMatchInsert", codiBoardVo);
		return codiBoardVo.getBoardNo();
		
	}
	
	//게시글 답글한개 가져오기
	public CodiBoardVo reMatchOne(int matchNo) {		
		System.out.println("게시글 답글 읽기 dao" +  matchNo);		
		return sqlSession.selectOne("style.reMatchBoardOne" ,  matchNo);
	}
	
	//답글 채택 adopt = 'Y'로 업데이트
	public int reMatchAdopt(int matchNo) {
		System.out.println("CodiBoardDao reMatchAdopt()");
		return sqlSession.update("style.adoptUpdate" ,matchNo );
	}
	
	//답글 채택시 point + 100으로 update
	public int reMatchPoint(int userNo) {
		System.out.println("CodiBoardDao reMatchPoint()");
		return sqlSession.update("style.pointUpdate" , userNo );
	}
	
	//스타일 매칭 삭제
	public void codiDelete(int boardNo) {
		sqlSession.update("style.codiDelete", boardNo);
	}
	//답글 입력
	public void insertReply(MatchBoardVo matchBoardVo) {
		sqlSession.insert("style.insertReply",matchBoardVo);
	}
	
	//답글 삭제
	public void deleteReply(int matchNo) {
		sqlSession.delete("style.deleteReply",matchNo);
		
	}

	public List<CommentVo> reReCommentList(int matchNo) {
		return sqlSession.selectList("style.matchCommentList",matchNo);
	}

	public void insertReReComment(Map<String, Object> insertVo) {
		sqlSession.insert("style.matchCommentInsert",insertVo);
		
	}

	public void deleteReReComment(int matchComNo) {
		sqlSession.delete("style.matchCommentDelete",matchComNo);
	}

	public void modiReReComment(Map<String, Object> updateVo) {
		sqlSession.update("style.modiMatchComment",updateVo);
		
	}

	public void insertCodiImgList(CodiImgVo codiImgVo) {
		sqlSession.insert("style.insertCodiImgList",codiImgVo);
	}

	public List<CodiImgVo> getClothes(int boardNo) {
		
		return sqlSession.selectList("style.getClothes",boardNo);
		
	}
	public FeelingVo selectFeeling(String feelType, int userNo, int matchNo) {
		
		Map<String, Object> feelMap = new HashMap<String, Object>();
		
		feelMap.put("feelType", feelType);
		feelMap.put("matchNo", matchNo);
		feelMap.put("userNo", userNo);
		
		return sqlSession.selectOne("style.feelingSelect", feelMap);
	}

	public void deleteFeeling(String feelType,int userNo, int feelingNo) {
		Map<String, Object> feelMap = new HashMap<String, Object>();
		
		feelMap.put("feelType", feelType);
		feelMap.put("feelingNo", feelingNo);
		feelMap.put("userNo", userNo);
		
		sqlSession.delete("style.deleteFeeling", feelMap);
	}
	
	public int goodFeelingCount(int matchNo) {
		
		return sqlSession.selectOne("style.goodFeelingCount", matchNo);
	}

	public void insertFeeling(String feelType, int userNo, int matchNo) {
		Map<String, Object> feelMap = new HashMap<String, Object>();
		
		feelMap.put("feelType", feelType);
		feelMap.put("matchNo", matchNo);
		feelMap.put("userNo", userNo);
		
		sqlSession.insert("style.insertFeeling", feelMap);
	}

	public int hateFeelingCount(int matchNo) {
		
		return sqlSession.selectOne("style.hateFeelingCount", matchNo);
	}

	public void insertWishList(int userNo, int matchNo, String content) {
		Map<String, Object> wishMap = new HashMap<String, Object>();
		wishMap.put("userNo", userNo);
		wishMap.put("matchNo", matchNo);
		wishMap.put("content", content);
		
		sqlSession.insert("style.insertWish",wishMap);
	}
}
