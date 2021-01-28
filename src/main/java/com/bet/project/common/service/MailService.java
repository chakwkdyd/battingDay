package com.bet.project.common.service;

public interface MailService {
	
	public boolean send(String subject, String text, String from, String to, String filePath);
	
}

