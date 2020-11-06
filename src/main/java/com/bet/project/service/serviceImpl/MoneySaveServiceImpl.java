package com.bet.project.service.serviceImpl;

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

import com.bet.project.dao.MoneySaveDAO;
import com.bet.project.model.MoneySave;
import com.bet.project.service.MoneySaveService;
import org.apache.poi.ss.usermodel.Row;


@Service
public class MoneySaveServiceImpl implements MoneySaveService {

	@Autowired
	MoneySaveDAO dao;
	
	@Override
	public void inertMoneykeeping(ArrayList<MoneySave> dto) {
		dao.inertMoneykeeping(dto);
	}

	@Override
	public List<MoneySave> getList(MoneySave dto) {
		return dao.getList(dto);
	}

	@Override
	public int delete(int num) {
		return dao.delete(num);
	}

	@Override
	public int update(MoneySave dto) {
		return dao.update(dto);
	}
	
	

	@Override
	public void getExcelDown(HttpServletResponse response
			,HttpServletRequest req 
			,MoneySave param) {
        List<MoneySave> dto = dao.getList(param);
        		
        try{
            //Excel Down 시작
            Workbook workbook = new HSSFWorkbook();
            //시트생성
            Sheet sheet = workbook.createSheet("가게부");
            
            //행, 열, 열번호
            Row row = null;
            Row row2 = null;
            Cell cell = null;
            int rowNo = 0;
            
            // 테이블 헤더용 스타일
            CellStyle headStyle = workbook.createCellStyle();
    
            // 가는 경계선을 가집니다.
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);
    
            // 배경색은 노란색입니다.
            headStyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
            headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
    
            // 데이터는 가운데 정렬합니다.
            headStyle.setAlignment(HorizontalAlignment.CENTER);
    
            // 데이터용 경계 스타일 테두리만 지정
            CellStyle bodyStyle = workbook.createCellStyle();
            bodyStyle.setBorderTop(BorderStyle.THIN);
            bodyStyle.setBorderBottom(BorderStyle.THIN);
            bodyStyle.setBorderLeft(BorderStyle.THIN);
            bodyStyle.setBorderRight(BorderStyle.THIN);
    
            // -- 고정값 style
            CellStyle bodyStyle2 = workbook.createCellStyle();
            
            bodyStyle2.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
            bodyStyle2.setFillPattern(FillPatternType.SOLID_FOREGROUND);

            bodyStyle2.setBorderTop(BorderStyle.THIN);
            bodyStyle2.setBorderBottom(BorderStyle.THIN);
            bodyStyle2.setBorderLeft(BorderStyle.THIN);
            bodyStyle2.setBorderRight(BorderStyle.THIN);
            
            
            // 헤더 생성
            row  = sheet.createRow(rowNo++);
            
    
            cell = row.createCell(0);
            cell.setCellStyle(headStyle);
            cell.setCellValue("날짜");
    
            cell = row.createCell(1);
            cell.setCellStyle(headStyle);
            cell.setCellValue("수입 내용");
    
            cell = row.createCell(2);
            cell.setCellStyle(headStyle);
            cell.setCellValue("수입 가격");
            
            cell = row.createCell(3);
            cell.setCellStyle(headStyle);
            cell.setCellValue("지출 내용");
    
            cell = row.createCell(4);
            cell.setCellStyle(headStyle);
            cell.setCellValue("지출 가격");
            
            
            
            /// --------------------
           // row2 = sheet.createRow(1);
            
            // == 총 합계 ==
            cell = row.createCell(6);
            cell.setCellStyle(headStyle);
            cell.setCellValue("총합계");
            
            
            // == 총 수입 ==
            cell = row.createCell(7);
            cell.setCellStyle(headStyle);
            cell.setCellValue("총 수입");
            
            
            // == 총 지출 ==
            cell = row.createCell(8);
            cell.setCellStyle(headStyle);
            cell.setCellValue("총 지출");
            
            
            // 숫자 소수점 
            DecimalFormat fmt = new DecimalFormat("###,###");


            int index = 0;
            // 데이터 부분 생성
            for(MoneySave list : dto) {
            	// -- 날짜 --
            	String date = ""+list.getYears()+"년"+ list.getMonths()+"월"+list.getDays()+"일";
                
            	row = sheet.createRow(rowNo++);
            	// --- 고정 값 ---
                if(list.getFixe().equals("Y")) {
	                cell = row.createCell(0);
	                cell.setCellStyle(bodyStyle2);
	                cell.setCellValue(list.getYears()+"년 [고정값]");
	                
	                cell = row.createCell(1);
	                cell.setCellStyle(bodyStyle2);
	                cell.setCellValue(list.getP_txt());
	                
	                cell = row.createCell(2);
	                cell.setCellStyle(bodyStyle2);
	                cell.setCellValue(fmt.format(Integer.parseInt(list.getP_price())));
	                
	                cell = row.createCell(3);
	                cell.setCellStyle(bodyStyle2);
	                cell.setCellValue(list.getM_txt());
	                
	                cell = row.createCell(4);
	                cell.setCellStyle(bodyStyle2);
	                cell.setCellValue(fmt.format(Integer.parseInt(list.getM_price())));
            	// --- 일반 값 ---
                }else {
                	 cell = row.createCell(0);
 	                cell.setCellStyle(bodyStyle);
 	                cell.setCellValue(date);
 	                
 	                cell = row.createCell(1);
 	                cell.setCellStyle(bodyStyle);
 	                cell.setCellValue(list.getP_txt());
 	                
 	                cell = row.createCell(2);
 	                cell.setCellStyle(bodyStyle);
 	                cell.setCellValue(fmt.format(Integer.parseInt(list.getP_price())));
 	                
 	                cell = row.createCell(3);
 	                cell.setCellStyle(bodyStyle);
 	                cell.setCellValue(list.getM_txt());
 	                
 	                cell = row.createCell(4);
 	                cell.setCellStyle(bodyStyle);
 	                cell.setCellValue(fmt.format(Integer.parseInt(list.getM_price())));
                }
                
                if(index == 0){
	                // -- 총 합계 --
	                cell = row.createCell(6);
	                cell.setCellStyle(bodyStyle);
	                cell.setCellValue(fmt.format(Integer.parseInt(param.getMonthResult())));
	                
	                // -- 총 수입 --
	                cell = row.createCell(7);
	                cell.setCellStyle(bodyStyle);
	                cell.setCellValue(fmt.format(Integer.parseInt(param.getP_result())));
	                
	                // -- 총 지출 --
	                cell = row.createCell(8);
	                cell.setCellStyle(bodyStyle);
	                cell.setCellValue(fmt.format(Integer.parseInt(param.getM_result())));
                }
                index++;
            }
            
            String str = ""+param.getYears()+"년 "+param.getMonths()+"월 가계부 .xls" ;
            
            String userAgent = req.getHeader("User-Agent");
            if (userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("Trident") >-1) {
            	str  = URLEncoder.encode(str, "UTF-8");
			}else {
				str  = new String(str.getBytes("UTF-8"), "iso-8859-1");
			}
            
            // 컨텐츠 타입과 파일명 지정
            response.setContentType("ms-vnd/excel");
            response.setHeader("Content-Disposition", "attachment;filename=\""+str+"\";");
 
            // 엑셀 출력
            workbook.write(response.getOutputStream());
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        
    }



}
