package com.bet.project.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.bet.project.model.MoneySave;


public interface ExcelDownService {
	
	void getExcelDown(HttpServletResponse response, HttpServletRequest req, MoneySave param);
}
