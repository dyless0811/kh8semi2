package com.kh.zipggu.repository;

import java.util.List;

import com.kh.zipggu.entity.OrdersDto;

public interface OrdersDao {
	int sequence();
	void insert(OrdersDto ordersDto);
	OrdersDto get(int no);
	List<OrdersDto> list();
	void refresh(int OrderNo);
}
