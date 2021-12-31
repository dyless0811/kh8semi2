package com.kh.zipggu.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.service.ItemService;
import com.kh.zipggu.vo.ItemInsertVO;
import com.kh.zipggu.vo.ItemSearchVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("")
	public String main() {
		return "admin/main";
	}
	
	@RequestMapping("/item")
	public String item() {
		return "admin/item/main";
	}
	
	@GetMapping("/item/insert")
	public String itemInsert(Model model) {
		model.addAttribute("categoryVOList", categoryService.list());
		return "admin/item/insert";
	}
	
	@PostMapping("/item/insert")
	public String itemInsert(@ModelAttribute ItemInsertVO vo,@RequestParam MultipartFile thumbnail , @RequestParam List<MultipartFile> attach) throws IllegalStateException, IOException {
	
		return "redirect:/store/detail/"+itemService.insert(vo,thumbnail , attach);
	}
	
	@GetMapping("/item/update/{itemNo}")
	public String itemUpdate(@PathVariable("itemNo") int itemNo, Model model) {
		model.addAttribute("categoryVOList", categoryService.list());
		model.addAttribute("itemDto", itemService.get(itemNo));
		return "admin/item/update";
	}
	
	@RequestMapping("/item/category")
	public String category() {
		
		return "admin/item/category";
	}
	
	@RequestMapping("/item/list")
	public String list(@ModelAttribute ItemSearchVO itemSearchVO, Model model){
		
		model.addAttribute("itemList", itemService.listBySearchVO(itemSearchVO));
		return "admin/item/list";
	}
}
