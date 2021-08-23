package com.bet.project.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bet.project.model.MoneySave;
import com.bet.project.model.Want;
import com.bet.project.service.ExcelDownService;
import com.bet.project.service.MoneySaveService;



@Controller
@RequestMapping("/callinder")
public class MoneySaveController {

	@Autowired
	MoneySaveService service;
	
	@Autowired
	ExcelDownService ExcelService;
	
	@RequestMapping(value = "/excelDown.do", method = RequestMethod.POST)
    public void  downloadExcelFile(HttpServletResponse response
    		,HttpServletRequest req
    		,MoneySave param) {
		ExcelService.getExcelDown(response, req, param);
    }
	
	@RequestMapping("/popupWant.do")
	public ModelAndView popupWant(ModelAndView mav
			,Map<String, String> map
			,String fixeYn 
			,String flag
			,String years
			,String months
			,@RequestParam(defaultValue = "0")String seq
			,@RequestParam(defaultValue = "내용")String txt 
			,@RequestParam(defaultValue = "0")String price 
			) {
		
		
		map.put("flag", 	flag);
		map.put("years", 	years);
		map.put("months", 	months);
		// ---디테일 ---
		map.put("seq", 	seq);
		map.put("txt", 	txt);
		map.put("price",price);
		
		
		mav.addObject("map", map);
		mav.addObject("fixeYn", fixeYn);

		mav.setViewName("moneySave/popupWant");
		return mav; 
	}
	
	@RequestMapping("/insertWant.do")
	@ResponseBody
	public void insertWant (@ModelAttribute Want dto) {
		
		service.insertWant(dto);
	}
	
	@RequestMapping("/selectWant.do")
	@ResponseBody
	public List<Want> selectWant (String year
			, String month
			, Want dto) {
		
		dto.setYears(year);
		dto.setMonths(month);

		List<Want> list = service.selectWant(dto);
		return list; 
	}
	
	@RequestMapping("/updateWant.do")
	@ResponseBody
	public int updateWant (@ModelAttribute Want dto) {
		return service.updateWant(dto);
	}
	
	
	@RequestMapping("/deleteWant.do")
	@ResponseBody
	public int deleteWant (@ModelAttribute Want dto) {
		return service.deleteWant(dto);
	}
	
	
	
	@RequestMapping("/moneySave.do")
	public ModelAndView callinder(ModelAndView mav
								,String moveYear	// 년
								,String moveMonth	// 월
								,String moveDay		// 일
								,String moveResult	// 구분(prev, thisMonth, next, prevY ,nextY)
								,String flag		// Y
								) {
		SimpleDateFormat fmtY = new SimpleDateFormat("yyyy");
		SimpleDateFormat fmtM = new SimpleDateFormat("MM");
		SimpleDateFormat fmtD = new SimpleDateFormat("dd");
		
		ArrayList<String> lista = new ArrayList<String>();
		
		 lista.add("수입");
		 lista.add("수입합");
		 lista.add("지출");
		 lista.add("지출합");
		 lista.add("결과");
		 
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		 
		
		int[] prevMonth = new int[] { 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11 };
		int[] nextMonth = new int[] {13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 };
		 
		 // === 첫 load ===
		 if(flag == null) {
			 
			 //		년도, 월, 일 (수시로 셋팅을 해줘야함) TODO
			 cal.set(	Integer.parseInt(fmtY.format(date))		// 년
					 , (Integer.parseInt(fmtM.format(date))-1)	// 월은 -1해줘야 해당월로 인식
					 , Integer.parseInt(fmtD.format(date))); 	// 일
			 
			 
		
			 
			 mav.addObject("str", 	lista);
			 mav.addObject("date", 	date);
			 mav.addObject("year", 	fmtY.format(date));		// 년
			 mav.addObject("month", fmtM.format(date));		// 월
			 mav.addObject("day", 	fmtD.format(date));		// 일 
			 mav.addObject("lastDay", 	cal.getActualMaximum(Calendar.DAY_OF_MONTH));// 마지막 일 
			 
			 
			 
		 // === 이후 load ===
		 }else {
			 
			 //		년도, 월, 일 (수시로 셋팅을 해줘야함) TODO
			 //		년도, 월, 일 (수시로 셋팅을 해줘야함) TODO
			 cal.set(  Integer.parseInt(moveYear)		// 년
					 , (Integer.parseInt(moveMonth) -1)	// 월은 -1해줘야 해당월로 인식
					 , Integer.parseInt(moveDay)); 		// 일
			 
			 
			// --- (<) 이전 ---
			if(moveResult.equals("prev")){
				moveMonth = Integer.toString((Integer.parseInt(moveMonth) -1));
				
				int num =(Integer.parseInt(moveMonth) -1);
				boolean f = false;
					
				
				for (int i = 0; i < prevMonth.length; i++) {
					// -- 작년으로  -- 
					if (prevMonth[i] == num) {
						f = true;
						if(prevMonth[i] == -1) 		 { num =12;}
						else if(prevMonth[i] == -2)  { num =11;}
						else if(prevMonth[i] == -3)  { num =10;}
						else if(prevMonth[i] == -4)  { num =9; }
						else if(prevMonth[i] == -5)  { num =8; }
						else if(prevMonth[i] == -6)  { num =7; }
						else if(prevMonth[i] == -7)  { num =6; }
						else if(prevMonth[i] == -8)  { num =5; }
						else if(prevMonth[i] == -9)  { num =4; }
						else if(prevMonth[i] == -10) { num =3; }
						else if(prevMonth[i] == -11) { num =2; }
						else if(prevMonth[i] ==  0)  { num =1;  f= false;}
						
						moveMonth =  Integer.toString(num);
					}
						
				}
				if(f) { moveYear = Integer.toString((Integer.parseInt(moveYear) -1)); f= false;}
				
			// --- (현재 달) ---
			}else if(moveResult.equals("thisMonth")){
				moveMonth = fmtM.format(date);
				moveYear  =	fmtY.format(date);
				moveDay   = fmtD.format(date);
			// --- (>) 이후---
			}else if(moveResult.equals("next")){
				moveMonth =  Integer.toString((Integer.parseInt(moveMonth) +1));
				
				int num =(Integer.parseInt(moveMonth) +1);
				boolean f = false;
				
				
				// -- 내년으로 --
				for (int i = 0; i < nextMonth.length; i++) {
					if (nextMonth[i] == num) {
						f = true;
						
						if(nextMonth[i] == 13) 		{ num =12; f=false;}
						else if(nextMonth[i] == 14) { num =1; }
						else if(nextMonth[i] == 15) { num =2; }
						else if(nextMonth[i] == 16) { num =3; }
						else if(nextMonth[i] == 17) { num =4; }
						else if(nextMonth[i] == 18) { num =5; }
						else if(nextMonth[i] == 19) { num =6; }
						else if(nextMonth[i] == 20) { num =7; }
						else if(nextMonth[i] == 21) { num =8; }
						else if(nextMonth[i] == 22) { num =9; }
						else if(nextMonth[i] == 23) { num =10; }
						else if(nextMonth[i] == 24) { num =11; }
						else if(nextMonth[i] == 25) { num =12; f=false;}
						
						moveMonth =  Integer.toString(num);
					}
					if(f) { moveYear = Integer.toString((Integer.parseInt(moveYear) +1)); f= false;}
					
				}
				
			}else if(moveResult.equals("prevY")){
				moveYear = Integer.toString((Integer.parseInt(moveYear) -1));
			}else if(moveResult.equals("nextY")){
				moveYear = Integer.toString((Integer.parseInt(moveYear) +1));
			}
			
			
			 
			mav.addObject("str", 	lista);	 	// 		- O
			 mav.addObject("year", 	moveYear);	// 년	- O
			 mav.addObject("month", moveMonth); // 월  	- O
			 mav.addObject("day", 	moveDay);	// 일 	- X
			 mav.addObject("lastDay", 	cal.getActualMaximum(cal.DAY_OF_MONTH));// 마지막 일 
			 
		 }
		mav.setViewName("/moneySave/moneySave");
		
		return mav;
	}
	
	// ==== 월별 년도 구하기  ===
	public  int[] getList(int num) {
		int arr[] 	 =  new int [ (int)Math.ceil(num/11)]; // 실제 비교값 들어있는 배열
		int arrNum[] =  new int [ (int)Math.ceil(num/11)]; // 11배수 (루프 조건용)
		
		
		// 입력값 만큼 루프 돌림
		for (int i = 0; i < arr.length; i++) {
			
			// 11배수 초기화
			for (int j = 11; j <= num; j++) {
				if((j%11)==0) {
					arrNum[i] = j; // 한번초기화 하면끝 i +1
				}
			}
			// 11배열 만큼 값 초기화
			for (int jj = arrNum[i]; jj <= arrNum[i+1]; jj++) {
				arr[i] = jj;
			}
		}
		
		
		return arr;
	}
	
	
	
	@RequestMapping("/saveList.do")
	@ResponseBody
	public List<MoneySave> saveList(MoneySave vo
			,String year
			,String month
			,String flag)  {
		ArrayList<MoneySave> dto = new ArrayList<>();
		MoneySave searchModel = new MoneySave();

		// year=2020 	&month=11&	flag=Y
		// --- 신규 저장 값 있을 경우 ---
		if(flag == null) {
				if (vo.getP_result() != null) {
					String[] pResult = vo.getP_result().split(",");
					
					for(String i : pResult){
						String[] pData = i.split("_"); // 2020_10_1_M_sdfs_666_Y
						MoneySave model = new MoneySave();
						
						System.out.println("__P___"+pData.length);
						System.out.println(pData);
						if(pData.length == 7) {
							System.out.println("P true!!!");
							model.setYears(pData[0]);
							model.setMonths(pData[1]);
							model.setDays(pData[2]);
							model.setFlag(pData[3]);
							model.setP_txt(pData[4]);
							model.setP_price(pData[5]);
							model.setFixe(pData[6]);
							
							dto.add(model); 
						}
						// -- 조회 조건용 --
						searchModel.setYears(pData[0]);
						searchModel.setMonths(pData[1]);
						
					}
				}
				
				if(vo.getM_result() != null) {
					String[] mResult = vo.getM_result().split(",");
					
					for(String i : mResult){
						String[] mData = i.split("_"); // 2020_10_1_M_sdfs_666
						MoneySave model = new MoneySave();
						
						
						System.out.println("__M___"+mData.length);
						System.out.println(mData);
						if(mData.length == 7) {
							System.out.println("M true!!!");
							model.setYears(mData[0]);
							model.setMonths(mData[1]);
							model.setDays(mData[2]);
							model.setFlag(mData[3]);
							model.setM_txt(mData[4]);
							model.setM_price(mData[5]);
							model.setFixe(mData[6]);
							
							dto.add(model); 
						}
						// -- 조회 조건용 --
						searchModel.setYears(mData[0]);
						searchModel.setMonths(mData[1]);
						
					}
				}
		
			// === 가계부 값들 저장 ===
			service.inertMoneykeeping(dto); 
			
		// --- 서버애들 ---			
		}else {
			
			// -- 조회 조건용 --
			searchModel.setYears(year);
			searchModel.setMonths(month);
		}
		
		// === 저장된 값들 가져오기 ===
		List<MoneySave> list = service.getList(searchModel);
		System.out.println(list);
		
		return list;
	}
	
	@RequestMapping(value = "/delete.do", method = RequestMethod.POST)
	public ModelAndView delete(ModelAndView mav
			,@RequestParam String  fseq )  {
		
		
		mav.addObject("result", service.delete(Integer.parseInt(fseq)));
		mav.setViewName("moneySave/popupMoneySave");
		
		return mav;
	}
	
	
	@RequestMapping(value = "/update.do", method = RequestMethod.POST)
	public ModelAndView update(ModelAndView mav
			,MoneySave dto)  {
		// 년 월 일  txt 
		//String pk = request.getParameter("pk");
		
		
		// TODO -> 맵퍼에서 if문으로 값들 update 
		if (dto.getFlag().equals("P")) {
			dto.setP_txt(dto.getPopTxt());
			dto.setP_price(dto.getPopPrice());
			dto.setM_txt(" ");
			dto.setM_price("0");
		}else {
			dto.setM_txt(dto.getPopTxt());
			dto.setM_price(dto.getPopPrice());
			dto.setP_txt(" ");
			dto.setP_price("0");
		}
		
		mav.addObject("result", service.update(dto));
		mav.setViewName("moneySave/popupMoneySave");
		
		return mav;
	}
	
	@RequestMapping("/popup.do")
	public ModelAndView popup(ModelAndView mav
			,String txt
			,String price
			,String pk
			,String fixe
			,String id
			,String flag 
			,String p_m
			,String result) {
		
		mav.setViewName("moneySave/popupMoneySave");
		
		mav.addObject("txt", txt);
		mav.addObject("price", price);
		mav.addObject("fixe", fixe);
		mav.addObject("id", id);
		mav.addObject("pk", pk);
		mav.addObject("flag", flag );
		mav.addObject("p_m", p_m);
		mav.addObject("result", result);
		
		return mav;
	}
	
	
}
