package com.kh.zipggu.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.kh.zipggu.service.StoreService;

@Controller
@RequestMapping("/store")
public class StoreController {
	
	@Autowired
	private StoreService storeService;
	
	@RequestMapping({"/list/{categoryNo}", "/list", ""})
	public String list(@PathVariable(required = false) Integer categoryNo) {
		return "store/list";
	}
	
	@RequestMapping("/detail/{itemNo}")
	public String detail(@PathVariable("itemNo") int itemNo, Model model) {
	
		model.addAttribute("itemDto", storeService.getItemDto(itemNo));
		model.addAttribute("itemOptionGroupMap", storeService.getOptionGroupMap(itemNo));
		model.addAttribute("itemFileDtoList", storeService.nonThumbnailListByItemNo(itemNo));
		return "store/detail";
	}
}
