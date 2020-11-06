package com.bet.project.model;

public class MoneySave {
	private String P_result;	
	private String M_result;
	
	private String popTxt;
	private String popPrice;
	
	private String  fseq;// PK
	private String  fixe;// 고정값
	private String  flag;
    private String	years;
    private String	months;
    private String	days;
    private String	P_txt;
    private String	P_price;
    private String	M_txt;
    private String	M_price;   
    
    private String monthResult; // 이달의 총 값
    
    
	
	public String getMonthResult() {
		return monthResult;
	}
	public void setMonthResult(String monthResult) {
		this.monthResult = monthResult;
	}
	public String getPopTxt() {
		return popTxt;
	}
	public void setPopTxt(String popTxt) {
		this.popTxt = popTxt;
	}
	public String getPopPrice() {
		return popPrice;
	}
	public void setPopPrice(String popPrice) {
		this.popPrice = popPrice;
	}
	public String getFseq() {
		return fseq;
	}
	public void setFseq(String fseq) {
		this.fseq = fseq;
	}
	public String getFixe() {
		return fixe;
	}
	public void setFixe(String fixe) {
		this.fixe = fixe;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
	public String getMonths() {
		return months;
	}
	public void setMonths(String months) {
		this.months = months;
	}
	public String getDays() {
		return days;
	}
	public void setDays(String days) {
		this.days = days;
	}
	public String getP_txt() {
		return P_txt;
	}
	public void setP_txt(String p_txt) {
		P_txt = p_txt;
	}
	public String getP_price() {
		return P_price;
	}
	public void setP_price(String p_price) {
		P_price = p_price;
	}
	public String getM_txt() {
		return M_txt;
	}
	public void setM_txt(String m_txt) {
		M_txt = m_txt;
	}
	public String getM_price() {
		return M_price;
	}
	public void setM_price(String m_price) {
		M_price = m_price;
	}
	public String getP_result() {
		return P_result;
	}
	public void setP_result(String p_result) {
		P_result = p_result;
	}
	public String getM_result() {
		return M_result;
	}
	public void setM_result(String m_result) {
		M_result = m_result;
	}
	
	@Override
	public String toString() {
		return "MoneySave [P_result=" + P_result + ", M_result=" + M_result + ", fseq=" + fseq + ", fixe=" + fixe
				+ ", flag=" + flag + ", years=" + years + ", months=" + months + ", days=" + days + ", P_txt=" + P_txt
				+ ", P_price=" + P_price + ", M_txt=" + M_txt + ", M_price=" + M_price + "]";
	}
	
	
	
	
}
