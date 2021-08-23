package com.bet.project.controller;

import java.io.File;
import java.util.UUID;

import javax.annotation.Resource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bet.project.HomeController;
import com.bet.project.service.MiracleService;

@Controller
@RequestMapping("/miracle")
public class MiracleController {
	
	// private static final Logger logger = LoggerFactory.getLogger(MiracleController.class);
	private static final Logger logger = LoggerFactory.getLogger(MiracleController.class);
	
	@Resource(name="uploadPath")
	String uploadPath;
	
	
	@Autowired
	MiracleService service;
	
	
	// ===== 미라클 모닝 화면시작 =======
	@RequestMapping("miracle.do")
	public String planing(ModelAndView mav) {
		return "/miracle/miracleMorning";
	}
	
	
	// ===== 파일 정보가 file에 저장 -> 지정된 디렉토리에 저장 =======
	@RequestMapping("miracleInsert.do")
	public ModelAndView routinesInsert(ModelAndView mav, MultipartFile file) throws Exception {
		
		logger.info("파일이름: " + file.getOriginalFilename());
		String savedName = file.getOriginalFilename();
		
		logger.info("파일크기 : "+file.getSize());
		logger.info("컨텐트 타입 : "+ file.getContentType());
		
		savedName = uploadFile(savedName, file.getBytes());
		
		mav.setViewName("/miracle/miracleMorning/");
		mav.addObject("savedName",savedName);
		
		return mav;
	}
	
	
	// =====< 파일 이름이 중복되지 않도록 처리 >=======
	private String uploadFile(String originalNm, byte[] fileData) throws Exception {
		
		// uuid 생성 (Universal Unique IDentifier, 범용 고유 식별자)
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString()+"_"+originalNm;
		File target = new File(uploadPath, savedName);
		// 임시 디렉토리에 저장된 디렉토리로 복사
		FileCopyUtils.copy(fileData, target);
		
		
		return savedName;
	}
	
	

}
