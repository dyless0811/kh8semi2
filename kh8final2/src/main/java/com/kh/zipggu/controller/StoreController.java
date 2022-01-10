package com.kh.zipggu.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.zipggu.repository.OrdersDao;
import com.kh.zipggu.service.ReviewService;
import com.kh.zipggu.service.StoreService;
import com.kh.zipggu.vo.ReviewListVO;
import com.kh.zipggu.vo.ReviewOrderListVO;

@Controller
@RequestMapping("/store")
public class StoreController {
	
	@Autowired
	private StoreService storeService;
	

	@Autowired
	private OrdersDao ordersDao;
	
	@Autowired
	private ReviewService reviewService;
	
	
	
	@RequestMapping({"/list/{categoryNo}", "/list", ""})
	public String list(@PathVariable(required = false) Integer categoryNo) {
		return "store/list";

	}
	
	@RequestMapping("/detail/{itemNo}")
	public String detail(@PathVariable("itemNo") int itemNo, Model model, HttpSession session) {
		
		int memberNo = (int)session.getAttribute("loginNo");
		
		//리뷰 작성시 구매한 목록 출력
		List<ReviewOrderListVO>list = ordersDao.orderList(memberNo); 
		
		//리뷰 출력 기능
		List<ReviewListVO>reviewListVO = reviewService.reviewList(itemNo);
		
		model.addAttribute("itemDto", storeService.getItemDto(itemNo));
		model.addAttribute("itemOptionGroupMap", storeService.getOptionGroupMap(itemNo));
		model.addAttribute("itemFileDtoList", storeService.nonThumbnailListByItemNo(itemNo));
		model.addAttribute("list", list);
		model.addAttribute("reviewListVO", reviewListVO);
		return "store/detail";
	}
}
