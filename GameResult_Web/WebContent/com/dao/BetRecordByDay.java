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
	    String url="jdbc:mysql://10.36.1.102:3306/GF_ResultsRecords";  
	    String user=CommonString.DB_USER;  
	    String password=CommonString.DB_PW;  
	     try {  
	        Class.forName(CommonString.DB_DRIVER);  
	        conn=DriverManager.getConnection(url,user,password);  
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
   			// TODO Auto-generated catch block
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
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put("Games", rs.getString("counts"));
	    	}
	    	
	    	sql = "select count(distinct userID) as counts from resultsRecords where Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put("Players", rs.getString("counts"));
	    	}

	    	sql = "select count(betting) as counts from resultsRecords where betting > 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put("Rounds", rs.getString("counts"));
	    	}
	    	
	    	sql = "select sum(betting) as counts from resultsRecords where betting > 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put("Bet", rs.getString("counts"));
	    	}
	    	
	    	sql = "select sum(results) as counts from resultsRecords where results > 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put("Win", rs.getString("counts"));
	    	}
	    	
	    	sql = "select sum(CONVERT(betting, SIGNED) - CONVERT(results, SIGNED)) as counts from resultsRecords where betting > 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put("Profit", rs.getString("counts"));
	    	}
	    	
	    	sql = "select sum(results)/sum(betting)*100 as counts from resultsRecords where betting > 0 and Date(resultsDate) = " 
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO +  CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {  
	    		map.put("PayRate", rs.getString("counts"));
	    	}

    		list.add(map);	
	    	
        } catch (SQLException e) {  
            e.printStackTrace();  
        }
	    
	    closeConn();
		return list;
	}
}
