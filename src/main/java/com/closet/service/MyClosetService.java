package com.closet.service;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.closet.dao.MyClosetDao;
import com.closet.dao.TrendSetterDao;
import com.closet.util.Paging;
import com.closet.util.ScreenShotSave;
import com.closet.vo.ClothesVo;
import com.closet.vo.CodiBoardVo;
import com.closet.vo.CodiImgVo;
import com.closet.vo.MyRoomVo;
import com.closet.vo.WishListVo;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MyClosetService {

   @Autowired
   private MyClosetDao myClosetDao;
   
   @Autowired
   private TrendSetterDao trendSetterDao;

   public void insertClothes(MultipartFile file, String jsonFile) {

      String saveDir = "D:/closet/FileUp";
      //String saveDir= "/var/webapps/closet/FileUp"; //리눅스 서버
      
      String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
      String logoFile = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;

      String filePath = saveDir + "/" + logoFile;

      // 이미지 흰색 배경 날리기
      BufferedImage image = null;
      try {
         byte[] fileData = file.getBytes();
         image = ImageIO.read(new ByteArrayInputStream(fileData));
         int width = image.getWidth();
         int height = image.getHeight();
         int deletePix = 0;
         for (int w = 0; w < width; w++) {
            for (int h = 0; h < height; h++) {
               if(h==00 && w==0) {
            	   deletePix = image.getRGB(w, h);
            	   
               }
               if (image.getRGB(w, h) == deletePix) {
            	   
                  image.setRGB(w, h, Color.TRANSLUCENT);
               }
               
            }
         }
         
         ImageIO.write(image, "png", new File(filePath));

         // string으로 json 형식으로 넘어오는 것을
         // ObjectMapper를 통해서 vo에 데이터를 넣음
         ClothesVo clothesVo = new ClothesVo();

         ObjectMapper objectMapper = new ObjectMapper();
         try {
            clothesVo = objectMapper.readValue(jsonFile, ClothesVo.class);
         } catch (Exception e) {
            System.out.println(e);
         }

         // clothesVo에 timeMill과 uuid로 바꾼 이미지 이름 넣기
         clothesVo.setClothImg(logoFile);
         // 옷 db에 넣기
         myClosetDao.insertClothes(clothesVo);
       
      } catch (Exception e) {

      }

   }

   // mycloset정보 가져오기
   public MyRoomVo getMyRoomData(String id) {
      return myClosetDao.getMyRoomData(id);

   }

   // 리스트 뿌리고 페이징
   public Map<String, Object> getClothesList(int userNo, int clothCateNo, int crtPage, int listCnt, int pageBtnCount) {

      Map<String, Object> data = new HashMap<String, Object>();
      data.put("userNo", userNo);
      data.put("clothCateNo", clothCateNo);

      int totalCount = myClosetDao.getClothesCount(data);

      data = Paging.beginEnd(data, listCnt, crtPage);

      List<ClothesVo> clothesList = myClosetDao.getClothesList(data);
      System.out.println(clothesList.toString());

      Map<String, Object> pMap = Paging.startEndPageBtn(pageBtnCount, crtPage, listCnt, totalCount);
      pMap.put("clothesList", clothesList);

      return pMap;
   }

   // 옷 삭제하기(update로 delFlag Y로 변경)
   public void deleteClothes(int clothNo) {
      myClosetDao.deleteClothes(clothNo);
   }

   // 위시리스트 가져오기 및 페이징
   public Map<String, Object> getWishList(int userNo, int crtPage, int listCnt, int pageBtnCount) {

      Map<String, Object> data = new HashMap<String, Object>();

      int totalCount = myClosetDao.getWishListCount(userNo);
      
      data = Paging.beginEnd(data, listCnt, crtPage);
      data.put("userNo", userNo);

      List<WishListVo> wishList = myClosetDao.getWishList(data);
      System.out.println(wishList.toString());

      Map<String, Object> pMap = Paging.startEndPageBtn(pageBtnCount, crtPage, listCnt, totalCount);
      pMap.put("wishList", wishList);

      return pMap;
   }

   // 위시리스트 삭제
   public void deleteWishList(int wishNo) {
      myClosetDao.deleteWishList(wishNo);

   }

   // 코디구함 가져오기 및 페이징
   public Map<String, Object> getStyleMatchList(int userNo, int crtPage, int categoryNo, int listCnt, int pageBtnCount) {
      Map<String, Object> data = new HashMap<String, Object>();
      data.put("userNo", userNo);
      data.put("categoryNo", categoryNo);

      int totalCount = myClosetDao.getStyleMatchListCount(data);

      data = Paging.beginEnd(data, listCnt, crtPage);

      List<CodiBoardVo> codiBoardList = myClosetDao.getStyleMatchList(data);

      Map<String, Object> pMap = Paging.startEndPageBtn(pageBtnCount, crtPage, listCnt, totalCount);
      pMap.put("codiBoardList", codiBoardList);

      return pMap;
   }

   public void deleteStyZipList(int boardNo) {
      myClosetDao.deleteStyZipList(boardNo);
   }

   // 코디하기 리스트 가져오기
   public Map<String, Object> getCodiList(int userNo, int authUserNo, int listType, int crtPage, int postCnt, int pageBtnCnt) {
      System.out.println("[MyClosetService] getCodiList()");
      
      String openFlag = "";
      
      if(userNo != authUserNo) {
    	  openFlag = "Y";
      }
      
      Map<String, Object> postRangeMap = new HashMap<String, Object>();
      postRangeMap.put("userNo", userNo);
      postRangeMap.put("listType", listType);
      postRangeMap.put("openFlag", openFlag);
      
      // 전체 글 수 가져오기
      int totalPostCnt = myClosetDao.selectCodiListCnt(postRangeMap);

      // 페이징 정보를 한번에 불러옴
      Map<String, Object> pMap = Paging.setPaging(crtPage, postCnt, pageBtnCnt, totalPostCnt);
      
      // 페이징 정보 중 리스트 범위만큼 글을 가져오기 위한 정보만 맵으로 묶음
      postRangeMap.put("startPostNo", pMap.get("startPostNo"));
      postRangeMap.put("endPostNo", pMap.get("endPostNo"));

      // 페이징 정보에서 리스트 범위 정보를 삭제함
      pMap.remove("startPostNo");
      pMap.remove("endPostNo");

      // 출력한 리스트를 불러옴
      List<CodiBoardVo> codiList = myClosetDao.selectCodiList(postRangeMap);
      pMap.put("codiList", codiList);

      return pMap;
   }
   
   //코디하기 글 정보 가져오기
   public CodiBoardVo getCodiPost(int boardNo) {
	   System.out.println("[MyClosetService] getCodiPost()");
	   
	   return myClosetDao.selectCodiPost(boardNo);
	   
   }
   
   public int todayTotal(int userNo) {
		myClosetDao.total(userNo);
		
		Map<String,Object> todayMap = new HashMap<String,Object>();
		todayMap.put("userNo", userNo);
		
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
		Date time = new Date();
		todayMap.put("date", format.format(time));
		
		Integer hasUser = myClosetDao.getUserToday(todayMap);
		
		if(hasUser!=null) {
			myClosetDao.updateUserToday(todayMap);
		}else {
			myClosetDao.createUserToday(todayMap);
		}
		return myClosetDao.getUserTodayCount(todayMap);
	}
   
   public Integer getTodayCount(int userNo) {
	   Map<String,Object> todayMap = new HashMap<String,Object>();
		todayMap.put("userNo", userNo);
		
		SimpleDateFormat format = new SimpleDateFormat("yy/MM/dd");
		Date time = new Date();
		todayMap.put("date", format.format(time));
		
		return myClosetDao.getUserTodayCount(todayMap);
   }
   
   //코디하기 글쓰기
   public String writeCodi(CodiBoardVo cbVo, String clothInCanvas, String canvasImg, int boardNo) {
	   System.out.println("[MyClosetService] writeCodi()");
	   
	   String saveDir = "D:/closet/FileUp";
	   //String saveDir= "/var/webapps/closet/FileUp"; //리눅스 서버
		
	   String saveFileName = ScreenShotSave.saveFile(saveDir, canvasImg);
	   
	   cbVo.setBoardImg(saveFileName);
	   
	   //clothInCanvas의 앞뒤 불필요한 문자열을 잘라서 배열로 정리
	   String target = "\"type\"";
	   int target_num = clothInCanvas.indexOf(target);
	   String cleanClothInCanvas = clothInCanvas.substring(target_num,(clothInCanvas.substring(target_num).indexOf("}]}")+target_num));
	   
	   //"},{"기준으로 나누어 배열로 정리
	   String[] splitArray = cleanClothInCanvas.split("\\},\\{");
	   
	   int CodiClothesCnt = 0;
	   
	   int doCodiCnt;
	   
	   if(boardNo > 0) {
		   //게시글 정보 수정
		   doCodiCnt = myClosetDao.updateDoCodi(cbVo);
		   
		   //옷리스트 삭제
		   myClosetDao.deleteCodiClothes(cbVo.getBoardNo());
	   }else {
		 //게시글 정보 저장
		   doCodiCnt = myClosetDao.insertDoCodi(cbVo);
	   }
	   
	   CodiImgVo codiImgVo = new CodiImgVo();
	   codiImgVo.setBoardNo(cbVo.getBoardNo());
	   
	   //옷 리스트 저장
	   for(int i=0;i<splitArray.length;i++) {
		   codiImgVo.setCanvasJson(splitArray[i]);
		   CodiClothesCnt += myClosetDao.insertCodiClothes(codiImgVo);
	   }
	   
	   String result = "doCodi: " +doCodiCnt+ ", codiClothes: " +CodiClothesCnt;
	   
	   return result;
   }
   
   //코디하기 수정 정보 가져오기
   public Map<String, Object> getCodiModify(int boardNo){
	   
	   List<CodiImgVo> clothesList = myClosetDao.selectClothes(boardNo);
	   
	   String canvasJson = "{\"version\":\"4.3.1\",\"objects\":[{";
	   
	   for(int i=0; i< clothesList.size(); i++){
		   canvasJson += clothesList.get(i).getCanvasJson();
		   
		   if( i != (clothesList.size() - 1)) {
			   canvasJson += "},{";
		   }
	   }
	   canvasJson += "}]}";
	   
	   Map<String, Object> bMap = new HashMap<String, Object>();
	   bMap.put("canvasJson", canvasJson);
	   bMap.put("codiBoardVo", getCodiPost(boardNo));
	   
	   return bMap;
   }
   
   //코디하기 글 삭제
   public void removeCodi(CodiBoardVo codiBoardVo) {
	   System.out.println("[MyClosetService] removeCodi()");
	   
	   int delTrendSetterResult = 0;
	   
	   System.out.println(codiBoardVo);
	   
	   if(codiBoardVo.getTrendSetterNo() > 0) {
		   delTrendSetterResult = trendSetterDao.updateDelFlag(codiBoardVo.getTrendSetterNo(), "N");
	   }
	   
	   int delCodiPostResult = myClosetDao.deleteCodiPost(codiBoardVo.getBoardNo());
	   
	   System.out.println("[MyClosetService] delTrendSetterResult:" +delTrendSetterResult+ ", delCodiPostResult: " + delCodiPostResult);
   }
   //코디하기 공개여부 변경
   public int modifyOpenFlag(CodiBoardVo codiBoardVo) {
	   System.out.println("[MyClosetService] modifyOpenFlag()");
	   
	   return myClosetDao.updateOpenFlag(codiBoardVo);
   }
}