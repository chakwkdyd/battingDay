package com.bet.project.common.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;

import com.bet.project.common.model.Criteria;
import com.bet.project.model.MoneySave;
import com.bet.project.model.Want;

public interface PagingService {

	List<Criteria> selectPagingList(Criteria cri);

	int getTotalCnt();
	
}
