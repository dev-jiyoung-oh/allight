package com.all.light.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;

import com.all.light.dto.CorporationDTO;
import com.all.light.dto.ReviewDTO;
import com.all.light.dto.ShoppingDTO;
import com.all.light.util.PageUtil;

public class ShoppingDAO extends SqlSessionDaoSupport {
	
	@Autowired
	SqlSessionTemplate session;
	
	// 쇼핑 해당 카테고리 상품 개수 가져오기
	public int getTotalCnt(String icategory) {
		int cnt = session.selectOne("Shopping.totalCnt", icategory);
		return cnt;
	}

	// 쇼핑 전체 상품 개수 가져오기
	public int getAllTotalCnt() {
		int cnt = session.selectOne("Shopping.totalCntAll");
		return cnt;
	}
	
	// 쇼핑 리스트(카테고리별로 보여주기)
	public ArrayList<ShoppingDTO> list(PageUtil pInfo,String icategory,int sort) {
		ArrayList<ShoppingDTO> list = new ArrayList<ShoppingDTO>(); // 결과받을 리스트
		HashMap<String,Object> map = new HashMap<String,Object>(); 	// 파라미터 보낼 맵
		
		map.put("startNo", pInfo.getStartNo());
		map.put("endNo", pInfo.getEndNo());
		map.put("icategory", icategory);
		
		// sort 0:인기순, 1:낮은가격순, 2:높은가격순
		if(sort==0) {
			list=(ArrayList)session.selectList("Shopping.listItem",map);
		}else if(sort==1) {
			list=(ArrayList)session.selectList("Shopping.listItemRow",map);
		}else if(sort==2) {
			list=(ArrayList)session.selectList("Shopping.listItemHigh",map);
		}
		return list;
	}
	
	// 쇼핑리스트(모두 보여주기)
	public ArrayList<ShoppingDTO> listAll(PageUtil pInfo,int sort) {
		ArrayList<ShoppingDTO> list = new ArrayList<ShoppingDTO>();
		// sort 0:인기순, 1:낮은가격순, 2:높은가격순
		if(sort==0) {
			list=(ArrayList)session.selectList("Shopping.listItemAll",pInfo);
		}else if(sort==1) {
			list=(ArrayList)session.selectList("Shopping.listItemRowAll",pInfo);
		}else if(sort==2) {
			list=(ArrayList)session.selectList("Shopping.listItemHighAll",pInfo);
		}
		return list;
	}
	
	// 대표 이미지 가져오기
	public String getRepreImage(int ino) {
		HashMap<String,Object> map = new HashMap<String,Object>(); 
		map.put("ino", ino);
		
		String repreImg = (String)session.selectOne("Shopping.getRepreImage",map);
		return repreImg;
	}
	
	// 검색된 게시물 가져오기 
	public ArrayList<ShoppingDTO> searchList(String searchWord) {
		ArrayList<ShoppingDTO> list = new ArrayList<ShoppingDTO>();
		list=(ArrayList)session.selectList("Shopping.searchList",searchWord);
		return list;
	}
	
	// ---------브랜드관--------------------------------------------------------
	// 브랜드관 브랜드 목록 가져오기
	public ArrayList<String> brandNames() {
		ArrayList<CorporationDTO> brandList = new ArrayList<CorporationDTO>();
		ArrayList<String> brandNames = new ArrayList<String>();
		brandList = (ArrayList)session.selectList("corporation.brandList");
		for(int i=0;i<brandList.size();i++) {
			brandNames.add(brandList.get(i).getConame());
		}
		return brandNames;
	}
	
	// 브랜드관 해당 브랜드 상품 개수 가져오기
	public int getBrandTotalCnt(String brand) {
		int cnt = session.selectOne("Shopping.totalCntBrand",brand);
		return cnt;
	}
	
	// 브랜드관 해당 브랜드 상품 리스트 가져오기
	public ArrayList<ShoppingDTO> brandContent(String brand,int sort,PageUtil pInfo) {
		ArrayList<ShoppingDTO> list = new ArrayList<ShoppingDTO>();
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("brand", brand);
		map.put("startNo", pInfo.getStartNo());
		map.put("endNo", pInfo.getEndNo());
		
		// sort 0:인기순, 1:낮은가격순, 2:높은가격순
		if(sort==0) {
			list = (ArrayList)session.selectList("Shopping.brandContent",map);
		}else if(sort==1) {
			list = (ArrayList)session.selectList("Shopping.brandContentRow",map);
		}else if(sort==2) {
			list = (ArrayList)session.selectList("Shopping.brandContentHigh",map);
		}
		return list;
	}
	
	// ---------상세 페이지--------------------------------------------------------
	// 상품 상세 정보 가져오기
	public ShoppingDTO getDetail(int ino) {
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("ino", ino);
		System.out.println(ino);
		ShoppingDTO shopDTO = (ShoppingDTO)session.selectOne("Shopping.detailByIno",map);
		return shopDTO;
	}
	
	// 상품 상세 이미지 가져오기
	public ArrayList<String> getImgs(int ino) {
		ArrayList<ShoppingDTO> imgList = new ArrayList<ShoppingDTO>();
		ArrayList<String> list = new ArrayList<String>();
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("ino", ino);
		
		imgList = (ArrayList)session.selectList("Shopping.detailImgs",map);
		for(int i=0;i<imgList.size();i++) {
			list.add(imgList.get(i).getImgimage());
		}
		
		return list;
	}
	
	// 상품 후기 전체 개수 가져오기
	public int getRTotalCnt(int ino) {
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("ino", ino);
		int cnt = session.selectOne("Shopping.rTotalCnt", map);
		return cnt;
	}
	
	// 상품 후기(좋아요 수)가져오기
	public ArrayList<ReviewDTO> getReview(int ino, PageUtil rPInfo) {
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("ino", ino);
		map.put("startNo", rPInfo.getStartNo());
		map.put("endNo", rPInfo.getEndNo());
		
		ArrayList<ReviewDTO> list = 
				(ArrayList)session.selectList("Shopping.rList", map);
		
		for(int i=0;i<list.size();i++) {
			int likeCnt = session.selectOne("Shopping.rLikeCnt",list.get(i).getRno());
			list.get(i).setRlamount(likeCnt);
		}
		
		return list;
	}
	
	// 해당 아이디의 해당 리뷰에 대한 좋아요 정보 가져오기
	public int getIsLike(int rno, String mid) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("rno", rno);
		map.put("mid", mid);
		
		int isLike = session.selectOne("Shopping.isLike",map);
		return isLike;
	}
	
	// 리뷰 좋아요 insert
	public void rLikeIns(int rno, String mid) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("rno", rno);
		map.put("mid", mid);
		
		int isOk = session.insert("Shopping.reviewIns",map); //1이면 성공/0이면 실패
		if(isOk==1)System.out.println(rno+"리뷰에 "+mid+"의 좋아요 insert 성공");
		if(isOk==0)System.out.println("리뷰 좋아요 insert 실패");
	}
	
	// 리뷰 좋아요 delete
	public void rLikeDel(int rno, String mid) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("rno", rno);
		map.put("mid", mid);
		
		int isOk = session.delete("Shopping.reviewDel",map); //1이면 성공/0이면 실패
		if(isOk==1)System.out.println(rno+"리뷰에 "+mid+"의 좋아요 delete 성공");
		if(isOk==0)System.out.println("리뷰 좋아요 delete 실패");
	}

	
}
