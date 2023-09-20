package com.closet.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.closet.vo.HashTagVo;
import com.closet.vo.TrendSetterVo;

@Repository
public class HashTagDao {
	@Autowired
	private SqlSession sqlSession;
	
	//태그 카테고리 조회하기(날씨별, 색깔별, 테마별)
	public List<HashTagVo> tagCateList() {
		System.out.println("HashTagDao/tagCateList()");
		
		List<HashTagVo> tagCateList = sqlSession.selectList("hashTag.tagCateList");
	
		return tagCateList;
	}

	//태그 리스트 조회하기(모달창에 들어갈 리스트)
	public List<HashTagVo> hashTagList(int tagDivNo) {
		System.out.println("HashTagDao/hashTagList()");
			
		List<HashTagVo> tagList = sqlSession.selectList("hashTag.tagList", tagDivNo);

		return tagList;
	}
	
	//trendSetter 게시판 글 한개에 있는 태그 리스트 조회
	public List<HashTagVo> boardTagList(int boardNo) {
		System.out.println("HashTagDao/boardTagList()");
		
		return sqlSession.selectList("hashTag.boardTagList", boardNo);
	}
	
	//선택한 태그리스트 뿌리기
	public HashTagVo selectTagList(int tagNo) {
		System.out.println("HashTagDao/selectTagList()");
		System.out.println("tagNo는 : " + tagNo);
		return sqlSession.selectOne("hashTag.selectTagList", tagNo);
	}

}
