package com.bet.project.model;

import org.springframework.web.multipart.MultipartFile;

public class Miracle {

	
	private String miracle_id;
	private String year;
	private String month;
	private String day;
	private String num;
	private String routine;
	private String times;
	private String image_url;
	private MultipartFile file1;
	private String delYn;
	
	public String getMiracle_id() {
		return miracle_id;
	}
	public void setMiracle_id(String miracle_id) {
		this.miracle_id = miracle_id;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getRoutine() {
		return routine;
	}
	public void setRoutine(String routine) {
		this.routine = routine;
	}
	public String getTimes() {
		return times;
	}
	public void setTimes(String times) {
		this.times = times;
	}
	public String getImage_url() {
		return image_url;
	}
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	public MultipartFile getFile1() {
		return file1;
	}
	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}
	public String getDelYn() {
		return delYn;
	}
	public void setDelYn(String delYn) {
		this.delYn = delYn;
	}
	@Override
	public String toString() {
		return "Miracle [miracle_id=" + miracle_id + ", year=" + year + ", month=" + month + ", day=" + day + ", num="
				+ num + ", routine=" + routine + ", times=" + times + ", image_url=" + image_url + ", file1=" + file1
				+ ", delYn=" + delYn + "]";
	}	

	
	
	
}
