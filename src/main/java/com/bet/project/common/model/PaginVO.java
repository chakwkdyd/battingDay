package com.bet.project.common.model;

import java.util.Date;

public class PaginVO {
	private int idx;
	private String title;
	private String writer;
	private Date insert_day;
	private int enter_cnt;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getInsert_day() {
		return insert_day;
	}
	public void setInsert_day(Date insert_day) {
		this.insert_day = insert_day;
	}
	public int getEnter_cnt() {
		return enter_cnt;
	}
	public void setEnter_cnt(int enter_cnt) {
		this.enter_cnt = enter_cnt;
	}
	
	@Override
	public String toString() {
		return "PaginVO [idx=" + idx + ", title=" + title + ", writer=" + writer + ", insert_day=" + insert_day
				+ ", enter_cnt=" + enter_cnt + "]";
	}
	
		
}
