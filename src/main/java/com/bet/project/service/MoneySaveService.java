package com.bet.project.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import com.bet.project.model.MoneySave;

public interface MoneySaveService {

	void inertMoneykeeping(ArrayList<MoneySave> dto);
	
	List<MoneySave> getList(MoneySave dto);
	
	int delete(int num);
	
	int update(MoneySave dto);
	

	void getExcelDown(HttpServletResponse response, HttpServletRequest req, MoneySave param);


}
