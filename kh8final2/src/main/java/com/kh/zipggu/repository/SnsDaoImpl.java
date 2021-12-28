package com.kh.zipggu.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.zipggu.entity.SnsDto;
import com.kh.zipggu.vo.SnsListVO;

@Repository
public class SnsDaoImpl implements SnsDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	//게시글 등록 기능
	@Override
	public void write(SnsDto snsDto) {
		
		sqlSession.insert("sns.write", snsDto);
		
	}
	
	//시퀀스 값 먼저 받는 기능
	@Override
	public int sequence() {
		
		return sqlSession.selectOne("sns.sequence");
	}
	
	//게시글 상세조회 기능
	@Override
	public SnsDto get(int snsNo) {
		
		return sqlSession.selectOne("sns.get", snsNo);
	}
	
	//게시글 목록 기능
	@Override
	public List<SnsDto> list() {
		
		return sqlSession.selectList("sns.list");
	}
	
	//게시글 수정 기능
	@Override
	public void edit(SnsDto snsDto) {
		
		sqlSession.update("sns.edit", snsDto);
		
	}
	
	//게시글 삭제 기능
	@Override
	public void delete(int snsNo) {
		
		sqlSession.delete("sns.delete", snsNo);
		
	}
	
	@Override
	public List<SnsListVO> listByPage(int startRow, int endRow) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("startRow", startRow);
		param.put("endRow", endRow);
		
		return sqlSession.selectList("sns.listByPage", param);
	}
}
