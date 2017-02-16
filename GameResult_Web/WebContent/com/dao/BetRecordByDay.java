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
	    	
	    	sql = " select * " 
	    		+ " from betRecordsByDay where Date(times) = "
	    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO
	    		+ " order by 1 DESC "
	    		+ " Limit 1 "
	    		+ CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();
	    	while(rs.next()) {
	    		Map<String, String> map = new HashMap<String, String>();  
	    		map.put(CommonString.TIMES, rs.getString(CommonString.TIMES));
	    		map.put(CommonString.GAMES, rs.getString(CommonString.GAMES));
	    		map.put(CommonString.PLAYERS, rs.getString(CommonString.PLAYERS));
	    		map.put(CommonString.ROUNDS, rs.getString(CommonString.ROUNDS));
	    		map.put(CommonString.BET, rs.getString(CommonString.BET));
	    		map.put(CommonString.WIN, rs.getString(CommonString.WIN));
	    		map.put(CommonString.PROFIT, rs.getString(CommonString.PROFIT));
	    		map.put(CommonString.PAYRATE, rs.getString(CommonString.PAYRATE));
	    		list.add(map);
	    	}	    	
        } catch (SQLException e) {  
            e.printStackTrace();  
        }	    
	    closeConn();
		return list;
	}
}
