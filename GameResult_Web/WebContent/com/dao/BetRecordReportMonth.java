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

public class BetRecordReportMonth {

	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;  
	
	private void openConn() {  
	    String url=CommonString.DB_URL;  
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
	
	public List<Map<String, String>> getAllRecords(String year, String month){
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
    	String sql_end = ";";
	    try {
	    	sql = " select resultsDate as Day, "
	    		+ " count(distinct gameID) as Games, "
	    		+ " count(userID) as Players, "
	    		+ " count(betting) as Rounds, "
	    		+ " sum(betting) as Bet, "
	    		+ " sum(results) as Win, "
	    		+ " sum(betting) - sum(results) as Profit, "
	    		+ " sum(results)/sum(betting)*100 as PayRate "
	    		+ " from resultsRecords "
	    		+ " where resultsDate "
	    		+ " between '" + year + "/" + month + "/01 00:00:00'"
	    		+ " and '" + year + "/" + month + "/31 23:59:59'"
	    		+ " GROUP by Date(resultsDate)" 
	    		+ sql_end;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {
		    	Map<String, String> map = new HashMap<String, String>();  
	    		map.put("Day", rs.getString("Day"));
	    		map.put("Games", rs.getString("Games"));
	    		map.put("Players", rs.getString("Players"));
	    		map.put("Rounds", rs.getString("Rounds"));
	    		map.put("Bet", rs.getString("Bet"));
	    		map.put("Win", rs.getString("Win"));
	    		map.put("Profit", rs.getString("Profit"));
	    		map.put("PayRate", rs.getString("PayRate"));
	    		list.add(map);
	    	}
	    	
        } catch (SQLException e) {  
            e.printStackTrace();  
        }
	    
	    closeConn();
		return list;
	}
}