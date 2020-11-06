package com.bet.project.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bet.project.model.MoneySave;

@Repository
public class MoneySaveDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	public void inertMoneykeeping(ArrayList<MoneySave> dto) {
		sqlSession.insert("Money.inertMoneykeeping", dto);
	}

	public List<MoneySave> getList(MoneySave dto) {
		return sqlSession.selectList("Money.getList", dto);
	}

	public int delete(int num) {
		return sqlSession.update("Money.delte", num);
	}

	public int update(MoneySave dto) {
		return sqlSession.update("Money.update", dto);
	}


}
