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

public class BettingListForEachGame {


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
	
	public List<Map<String, String>> getAllRecords(String date, String gameID, String orderby, String asc){
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
    	String orderby_str;
    	if(asc.equalsIgnoreCase("1"))
    		orderby_str = " order by " + orderby + " ASC;"; 
    	else
    		orderby_str = " order by " + orderby + " DESC;";
    	String sql_quato = "'";
	    try {
	    	sql = " select userID," 
	    		+ " count(betting) as Rounds,"
	    		+ " sum(betting) as Bet,"
	    		+ " sum(results) as Win,"
	    		+ " sum(betting)-sum(results) as Profit,"
	    		+ " sum(results)/sum(betting)*100 as PayRate"
	    		+ " from resultsRecords where Date(resultsDate) = "
	    		+ sql_quato + date + sql_quato 
	    		+ " and gameID = " +  gameID
	    		+ " GROUP by userID"
	    		+ orderby_str;
	    	
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();  
	    	while(rs.next()) {
		    	Map<String, String> map = new HashMap<String, String>();
	    		map.put("Players", rs.getString("userID"));
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
