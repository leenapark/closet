package com.closet.util;

import java.util.HashMap;
import java.util.Map;

public class Paging {

	// 페이징 추후 따로 정리 필요(영관)
	public static Map<String, Object> beginEnd(Map<String, Object> data, int listCnt, int crtPage) {

		crtPage = (crtPage > 0) ? crtPage : (crtPage = 1);

		int begin = listCnt * (crtPage - 1) + 1;
		int end = (listCnt * crtPage);

		data.put("begin", begin);
		data.put("end", end);
		return data;
	}

	public static Map<String, Object> startEndPageBtn(int pageBtnCount, int crtPage, int listCnt, int totalCount) {

		int endPageBtnNo = (int) Math.ceil(crtPage / (double) pageBtnCount) * pageBtnCount;
		int startPageBtnNo = endPageBtnNo - (pageBtnCount - 1);

		boolean next;

		if (endPageBtnNo * listCnt < totalCount) {
			next = true;
		} else {
			next = false;
			endPageBtnNo = (int) Math.ceil(totalCount / (double) listCnt);
		}

		boolean prev;

		if (startPageBtnNo != 1) {
			prev = true;
		} else {
			prev = false;
		}

		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("prev", prev);
		pMap.put("startPageBtnNo", startPageBtnNo);
		pMap.put("endPageBtnNo", endPageBtnNo);
		pMap.put("next", next);

		return pMap;
	}

	// 페이징 추후 따로 정리 필요(재철)
	public static Map<String, Object> setPaging(int crtPage, int postCnt, int pageBtnCnt, int totalPostCnt) {
		// postCnt => 페이지 당 글 갯수, pageBtnCnt => 페이지 버튼 갯수

		// **************************게시글 리스트 시작, 끝번호 연산
		// crtPage 음수 오류 방지
		crtPage = crtPage > 0 ? crtPage : 1;

		// 시작글 번호
		int startPostNo = postCnt * (crtPage - 1) + 1;

		// 끝 글 번호
		int endPostNo = startPostNo + postCnt - 1;

		// **************************페이징
		// 끝 페이지 번호
		int endPageNo = (int) Math.ceil(crtPage / (double) pageBtnCnt) * pageBtnCnt;

		// 시작 페이지 번호
		int startPageNo = endPageNo - pageBtnCnt + 1;

		// 이전, 다음버튼
		boolean prev, next;

		if (startPageNo != 1) {
			prev = true;
		} else {
			prev = false;
		}

		if (endPageNo * postCnt < totalPostCnt) {
			next = true;
		} else {
			next = false;
			endPageNo = (int) Math.ceil(totalPostCnt / (double) postCnt);
		}

		// 맵으로 묶음
		Map<String, Object> pageMap = new HashMap<String, Object>();
		pageMap.put("startPostNo", startPostNo);
		pageMap.put("endPostNo", endPostNo);
		pageMap.put("startPageNo", startPageNo);
		pageMap.put("endPageNo", endPageNo);
		pageMap.put("prev", prev);
		pageMap.put("next", next);

		return pageMap;
	}
}
