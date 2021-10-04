package com.bet.project.common.model;

public class Criteria {
    
    private int page;
    private int perPageNum;
    
    
    // 특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
    public int getPageStart11() {
    	//현재 페이지의 게시글 시작 번호 
        return (this.page-1)*perPageNum;
    }
    
    public Criteria() {
        this.page 		= 1;	// 현재 페이지 번호
        this.perPageNum = 10;	// 한 페이지당 보여줄 게시글의 갯수
    }
    
    public int getPage() {
        return page;
    }
    
    
    // 페이지가 음수값이 되지 않게 설정. 음수가 되면 1페이지를 나타낸다.
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    
    public int getPerPageNum() {
        return perPageNum;
    }
    
    // 페이지당 보여줄 게시글 수가 변하지 않게 설정했다.
    public void setPerPageNum(int pageCount) {
    	if(pageCount <= 0) {
    		this.perPageNum = this.perPageNum ;
    	}else {
    		this.perPageNum = pageCount;
    	}
    }
}


