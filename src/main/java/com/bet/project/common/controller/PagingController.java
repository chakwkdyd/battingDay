package com.bet.project.common.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bet.project.common.model.Criteria;
import com.bet.project.common.model.PageMaker;
import com.bet.project.common.service.PagingService;
import com.bet.project.service.MemberService;

@Controller
public class PagingController {
	
	@Autowired
	PagingService pagingService;
	
	
	@RequestMapping(value="/paing/testPaging")
	public void testPaging(){}
	
	 
	@RequestMapping(value="/paing/boardList")
	public ModelAndView openBoardList(Criteria cri) {
	    ModelAndView mav = new ModelAndView();
	        
	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);				
	    pageMaker.setTotalCount(pagingService.getTotalCnt());
	    
	        
	    List<Criteria> list = pagingService.selectPagingList(cri);
	    mav.addObject("list", list);
	    mav.addObject("perPageNum", cri.getPerPageNum());
	    mav.addObject("pageMaker", pageMaker);
	    mav.setViewName("/paging/testPaging");     
	    return mav;
	}


}
