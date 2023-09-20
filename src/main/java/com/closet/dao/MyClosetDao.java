package com.closet.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.closet.vo.ClothesVo;
import com.closet.vo.CodiBoardVo;
import com.closet.vo.CodiImgVo;
import com.closet.vo.MyRoomVo;
import com.closet.vo.WishListVo;

@Repository
public class MyClosetDao {

	@Autowired
	private SqlSession sqlSession;
	
	//옷 넣기
	public void insertClothes(ClothesVo clothesVo) {
		sqlSession.insert("closet.insertClothes", clothesVo);
		
	}
	//myCloset Session 정보 가져오기
	public MyRoomVo getMyRoomData(String id) {
		
		return sqlSession.selectOne("closet.getMyRoomData",id);
	}
	//옷 리스트 가져오기
	public List<ClothesVo> getClothesList(Map<String,Object> clothesData) {
		
		System.out.println(clothesData.toString());
		return sqlSession.selectList("closet.getClothesList",clothesData);
	}
	//총 옷 숫자(카테고리별)
	public int getClothesCount(Map<String,Object> clothesData) {
		
		return sqlSession.selectOne("closet.getClothesListCount",clothesData);
	}
	//위시 리스트 가져오기
	public List<WishListVo> getWishList(Map<String,Object> wishList){
		return sqlSession.selectList("closet.getWishList",wishList);
	}
	//총 위시 리스트  숫자
	public int getWishListCount(int userNo) {
		return sqlSession.selectOne("closet.getWishListCount",userNo);
	}
	//스타일매치 리스트 가져오기
	public List<CodiBoardVo> getStyleMatchList(Map<String,Object> data) {
		return sqlSession.selectList("closet.getStyleMatch",data);
	}
	public int getStyleMatchListCount(Map<String,Object> data) {
		return sqlSession.selectOne("closet.getStyleMatchCount",data);
	}
	//옷장 옷 삭제(업데이트로 delFlag 'Y'로 변경)
	public void deleteClothes(int clothNo) {
		sqlSession.update("closet.deleteClothes",clothNo);
	}
	//위시리스트 삭제
	public void deleteWishList(int wishNo) {
		sqlSession.delete("closet.deleteWishList",wishNo);
	}
	//코디구함 삭제
	public void deleteStyZipList(int boardNo) {
		sqlSession.update("closet.deleteStyZipList",boardNo);
	}
	//코디하기 글 갯수 가져오기
	public int selectCodiListCnt(Map<String,Object> pMap) {
		System.out.println("[MyClosetDao] selectCodiListCnt");
		
		return sqlSession.selectOne("closet.selectCodiListCnt", pMap);
	}
	//코디하기 리스트 가져오기
	public List<CodiBoardVo> selectCodiList(Map<String,Object> pMap){
		System.out.println("[MyClosetDao] selectCodiList()");
		
		System.out.println(pMap);
		return sqlSession.selectList("closet.selectCodiList", pMap);
	}
	//코디하기 글 정보 가져오기
	public CodiBoardVo selectCodiPost(int boardNo){
		System.out.println("[MyClosetDao] selectCodiPost()");

		return sqlSession.selectOne("closet.selectCodiPost", boardNo);
	}
	
	//total update
	public void total(int userNo) {
		sqlSession.update("closet.updateTotal",userNo);	
	}
	
	public Integer getUserToday(Map<String,Object>getToday) {
		return sqlSession.selectOne("closet.hasUserToday",getToday);
	}
	public void updateUserToday(Map<String, Object> todayMap) {
		sqlSession.update("closet.updateToday",todayMap);
	}
	public void createUserToday(Map<String, Object> todayMap) {
		sqlSession.insert("closet.insertToday",todayMap);
		
	}
	public Integer getUserTodayCount(Map<String, Object> todayMap) {
		
		return sqlSession.selectOne("closet.getTodayCount",todayMap);
	}
	
	//코디하기 글 트렌드 세터에 등록시 정보 업데이트
	public int updateTrendSetterNo(CodiBoardVo codiBoardVo){
		System.out.println("[MyClosetDao] updateTrendSetterNo()");

		return sqlSession.update("closet.updateTrendSetterNo", codiBoardVo);
	}
	
	//코디하기 게시글 저장
	public int insertDoCodi(CodiBoardVo codiBoardVo) {
		System.out.println("[MyClosetDao] insertDoCodi()");
		
		return sqlSession.insert("closet.insertDoCodi", codiBoardVo);
	}
	   
	//코디 옷 리스트 저장
	public int insertCodiClothes(CodiImgVo codiImgVo) {
		System.out.println("[MyClosetDao] insertCodiImg()");
		
		return sqlSession.insert("closet.insertCodiImg", codiImgVo);
	}
	
	//코디 옷 리스트 삭제
	public int deleteCodiClothes(int boardNo) {
		System.out.println("[MyClosetDao] deleteCodiClothes()");
		
		return sqlSession.delete("closet.deleteCodiClothes", boardNo);
	} 
	
	//코디 옷 리스트 가져오기
	public List<CodiImgVo> selectClothes(int boardNo) {
		System.out.println("[MyClosetDao] selectClothes()");
		
		return sqlSession.selectList("closet.selectClothes", boardNo);
	}
	
	//코디하기 게시글 수정
	public int updateDoCodi(CodiBoardVo codiBoardVo) {
		System.out.println("[MyClosetDao] updateDoCodi()");
		
		return sqlSession.update("closet.updateDoCodi", codiBoardVo);
	}
	
	//코디하기 글 삭제 (delFlag 변경)
	public int deleteCodiPost(int boardNo) {
		System.out.println("[MyClosetDao] deleteCodiPost()");
		
		return sqlSession.update("closet.deleteCodiPost", boardNo);
	}
	
	//코디하기 공개여부 변경
	public int updateOpenFlag(CodiBoardVo codiBoardVo) {
		System.out.println("[MyClosetDao] updateOpenFlag()");
		
		return sqlSession.update("closet.updateOpenFlag", codiBoardVo);
	}
	
	// 코디하기 트렌드세터 번호 Null로 변경 (트렌드 세터 글 삭제)
	public int updateNullTSNo(int trendSetterNo) {
		System.out.println("[MyClosetDao] updateNullTSNo()");
		
		return sqlSession.update("closet.updateNullTSNo", trendSetterNo);
	}
}
