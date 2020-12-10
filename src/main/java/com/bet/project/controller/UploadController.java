package com.bet.project.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.apache.taglibs.standard.lang.jstl.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

public class UploadController {
	
	private static final Logger logger = (Logger) LoggerFactory.getLogger(UploadController.class);
	
	// xml에 설정된 리소스 참조
	//@Resource(name = "uploadPath")
	String uploadPath="dd";
		
	
	@RequestMapping(value ="/upload/uploadForm", method = RequestMethod.GET)
	public void uploadForm() {}
	
	// 업로드 버튼 => 임시디렉토리에 업로드
	@RequestMapping(value = "/upload/uploadForm", method = RequestMethod.POST) 
	public ModelAndView uploadForm(ModelAndView mav, MultipartFile file) throws Exception{
			System.out.println("파일이름: " +file.getOriginalFilename());
			String savedName = file.getOriginalFilename();
			
			System.out.println("파일크기: "+file.getSize());
			System.out.println("컨텐트 타입: "+file.getContentType());
			
			savedName = uploadFile(savedName, file.getBytes());
			
			mav.setViewName("upload/uploadResult");
			mav.addObject("saveName", savedName);
			
		return mav;
	
	}
	
	// === 파일 중복 않도록 처리 ===
	private String uploadFile(String origianlName, byte[] fileData) throws IOException {
		
		// uuid 생성 (Universal Unique Identifier, 범용 고유 식별자)
		UUID uid = UUID.randomUUID();
		String savedName = uid.toString()+"_"+ origianlName;
		File target = new File(uploadPath, savedName);
		
		// 임시 디렉토리에 저장된 업로드된 파일을
		// 지정된 디렉토리로 복사
		// FileCopyUtils.copy( 바이트배열, 파일객체)
		FileCopyUtils.copy(fileData, target);
		
		return savedName;
	}
	
}
