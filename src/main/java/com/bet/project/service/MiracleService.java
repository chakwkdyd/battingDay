package com.bet.project.service;

import java.util.List;

import com.bet.project.model.Miracle;



public interface MiracleService {
	
	public List<Miracle> listMiracle();
	
	void insertMiracle(Miracle model);
	
	void updateMiracle(Miracle model);
	
	void deleteMiracle(int Miracle_id);
	
	String fileInfo(int Miracle_id);

}

