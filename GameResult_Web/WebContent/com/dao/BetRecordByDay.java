package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BetRecordByDay {

	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;  
	
	private void openConn() {  
	    String url = CommonString.DB_GF_RECOREDRESULT;  
	    String user = CommonString.DB_USER;  
	    String password = CommonString.DB_PW;  
	     try {  
	        Class.forName(CommonString.DB_DRIVER);  
	        conn = DriverManager.getConnection(url, user, password);  
	    } catch (ClassNotFoundException e) {  
	        e.printStackTrace();  
	    } catch (SQLException e) {  
	        e.printStackTrace();  
	    }
	}
	
	private void closeConn() {
        try {
        	conn.close();
   		} catch (SQLException e) {
   			e.printStackTrace();
   		}
	}
	
	public List<Map<String, String>> getAllRecords(String date){
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
	    try {
	    	Map<String, String> map = new HashMap<String, String>();  
	    	sql = "select count(distinct gameID) as counts from resultsRecords where Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put(CommonString.GAMES, rs.getString(CommonString.COUNTS));
	    	}
	    	
	    	sql = "select count(distinct userID) as counts from resultsRecords where Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put(CommonString.PLAYERS, rs.getString(CommonString.COUNTS));
	    	}

	    	sql = "select count(betting) as counts from resultsRecords where betting >= 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put(CommonString.ROUNDS, rs.getString(CommonString.COUNTS));
	    	}
	    	
	    	sql = "select sum(betting) as counts from resultsRecords where betting >= 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put(CommonString.BET, rs.getString(CommonString.COUNTS));
	    	}
	    	
	    	sql = "select sum(results) as counts from resultsRecords where results >= 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put(CommonString.WIN, rs.getString(CommonString.COUNTS));
	    	}
	    	
	    	sql = "select sum(CONVERT(betting, SIGNED) - CONVERT(results, SIGNED)) as counts from resultsRecords where betting >= 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put(CommonString.PROFIT, rs.getString(CommonString.COUNTS));
	    	}
	    	
	    	sql = "select sum(results)/sum(betting)*100 as counts from resultsRecords where betting >= 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put(CommonString.PAYRATE, rs.getString(CommonString.COUNTS));
	    	}
    		list.add(map);	    	
        } catch (SQLException e) {  
            e.printStackTrace();  
        }	    
	    closeConn();
		return list;
	}
}
