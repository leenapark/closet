package com.closet.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.closet.vo.UserVo;

@Repository
public class UserDao {

	@Autowired
	private SqlSession sqlSession;

	public UserVo login(UserVo userVo) {
		
		return sqlSession.selectOne("user.login", userVo);
	}
	
	// checkId
	public UserVo selectOne(String id) {
		System.out.println("UserDao checkId: " + id);
		
		UserVo userVo = sqlSession.selectOne("user.selectById", id);
		System.out.println("userVo idcheck: " + userVo);
		
		return userVo;
	}
	
	// checknickname
	public UserVo selectNickName(String nickName) {
		System.out.println("UserDao checknickname: " + nickName);
		
		UserVo userVo = sqlSession.selectOne("user.selectByNickName", nickName);
		System.out.println(userVo);
		
		return userVo;
	}
	
	// 회원가입
	public int insertJoin(UserVo userVo) {
		System.out.println("UserDao insertJoin: " + userVo);
		
		return sqlSession.insert("insertJoin", userVo);
	}
	
	// 회원 정보 수정 폼
	public UserVo selectModify(int userNo) {
		System.out.println("UserDao");
		
		return sqlSession.selectOne("user.selectModify", userNo);
	}
	
	// 프로필 업데이트
	public int updateProfile(UserVo userVo) {
		System.out.println("userDao: " + userVo);

		return sqlSession.update("user.updateProfile", userVo);
	}
	
	
	// 비밀번호 변경
	public int updatePass(UserVo userVo) {
		System.out.println("userDao updatePass");
		
		return sqlSession.update("user.updatePass", userVo);
	}
	
	// 닉네임 변경
	public int updateNickName(UserVo userVo) {
		System.out.println("userDao updateInfo");
		
		return sqlSession.update("user.updateNickName", userVo);
	}
	
	// 이메일 변경
	public int updateEmail(UserVo userVo) {
		System.out.println("userDao updateInfo");
		
		return sqlSession.update("user.updateEmail", userVo);
	}
	
	// 성별 변경
	public int updateGender(UserVo userVo) {
		System.out.println("userDao updateInfo");
		
		return sqlSession.update("user.updateGender", userVo);
	}
	
	// 소셜 로그인
	public void insertKakao(UserVo userInfo) {
		System.out.println("UserDao userVo: " + userInfo);
		
		sqlSession.insert("user.joinKakao", userInfo);
	}
	
	public UserVo loginKakao(UserVo userVo) {
		System.out.println("카카오 로그인" + userVo);
		return sqlSession.selectOne("user.loginKakao", userVo);
	}
	
}
