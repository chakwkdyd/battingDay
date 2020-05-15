package com.bet.project.model;

import java.util.Date;

public class BetBoard {

	private int room_no;				// PK	
	private int file_id;				// PK
	private String bet_title;			// 제목
	private Date bet_start_date;		// 시작날짜 
	private Date bet_end_date;			// 종료날짜
	private String bet_contents;		// betting 상품
	private String bet_condition; 		// betting 조건
	private String del_yn;				// 삭제 여부
	private String bet_open_status_yn; 	// 공개 여부
	private String bet_join_yn;			// 참여 여부
	private int    bet_person_count;	// 인원 제안수
	
	
	public String getBet_title() {
		return bet_title;
	}
	public void setBet_title(String bet_title) {
		this.bet_title = bet_title;
	}
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public int getFile_id() {
		return file_id;
	}
	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}
	public Date getBet_start_date() {
		return bet_start_date;
	}
	public void setBet_start_date(Date bet_start_date) {
		this.bet_start_date = bet_start_date;
	}
	public Date getBet_end_date() {
		return bet_end_date;
	}
	public void setBet_end_date(Date bet_end_date) {
		this.bet_end_date = bet_end_date;
	}
	public String getBet_contents() {
		return bet_contents;
	}
	public void setBet_contents(String bet_contents) {
		this.bet_contents = bet_contents;
	}
	public String getBet_condition() {
		return bet_condition;
	}
	public void setBet_condition(String bet_condition) {
		this.bet_condition = bet_condition;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getBet_open_status_yn() {
		return bet_open_status_yn;
	}
	public void setBet_open_status_yn(String bet_open_status_yn) {
		this.bet_open_status_yn = bet_open_status_yn;
	}
	public String getBet_join_yn() {
		return bet_join_yn;
	}
	public void setBet_join_yn(String bet_join_yn) {
		this.bet_join_yn = bet_join_yn;
	}
	public int getBet_person_count() {
		return bet_person_count;
	}
	public void setBet_person_count(int bet_person_count) {
		this.bet_person_count = bet_person_count;
	}

	
}
