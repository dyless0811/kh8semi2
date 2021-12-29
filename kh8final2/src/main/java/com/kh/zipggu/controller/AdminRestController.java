package com.kh.zipggu.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.zipggu.entity.CategoryDto;
import com.kh.zipggu.service.CategoryService;
import com.kh.zipggu.vo.CategoryVO;

@RestController
@RequestMapping("/admin/data")
public class AdminRestController {
	
	@Autowired
	private CategoryService categoryService;
	
	@GetMapping("/category/list")
	public List<CategoryVO> categoryList() {
		
		return categoryService.list();
	}
	
	@GetMapping("/category/add")
	public void categoryAdd(@RequestParam String categoryName, @RequestParam int categorySuper) {
		categoryService.add(categoryName, categorySuper);
	}
	
	@PostMapping("/category/child")
	public List<CategoryDto> listBySuper(@RequestParam int categorySuper) {
		return categoryService.listBySuper(categorySuper);
	}
}