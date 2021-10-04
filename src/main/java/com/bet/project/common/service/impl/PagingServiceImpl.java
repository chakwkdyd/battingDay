package com.bet.project.common.service.impl;

import java.io.IOException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bet.project.common.dao.PagingDAO;
import com.bet.project.common.model.Criteria;
import com.bet.project.common.service.PagingService;
import com.bet.project.dao.MoneySaveDAO;
import com.bet.project.model.MoneySave;
import com.bet.project.model.Want;
import com.bet.project.service.MoneySaveService;

import org.apache.poi.ss.usermodel.Row;


@Service
public class PagingServiceImpl implements PagingService {

	@Autowired
	PagingDAO dao;

	
	@Override
	public List<Criteria> selectPagingList(Criteria  cri) {
		return dao.selectPagingList(cri);
	}


	@Override
	public int getTotalCnt() {
		return dao.getTotalCnt();
	}
	
	



}
