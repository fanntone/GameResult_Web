package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
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
    	sql = " select times, "
    		+ " count(distinct gameID) as Games, "
    		+ " sum(Players) as Players, "
    		+ " sum(Rounds) as Rounds, "
    		+ " sum(Bet) as Bet, "
    		+ " sum(Win) as Win, "
    		+ " sum(Profit) as Profit, "
    		+ " (select sum(Win) from betRecordsByFiveMins where Date(times) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO
    		+ " and times = "
    		+ " (select Max(times) from betRecordsByFiveMins where Date(times) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO + ") "
    		+ ")/( select sum(Bet) from betRecordsByFiveMins where Date(times) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO
    		+ " and times = "
    		+ " (select Max(times) from betRecordsByFiveMins where Date(times) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO + ")) "
    		+ " as PayRate "
    		+ " from betRecordsByFiveMins where Date(times) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO 
    		+ " and times = "
    		+ " (select Max(times) from betRecordsByFiveMins where Date(times) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO + ") "
    		+ CommonString.SQLQUERYEND;
	    try {
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();
	    	while(rs.next()) {
	    		Map<String, String> map = new HashMap<String, String>();  
	    		map.put(CommonString.TIMES, rs.getString(CommonString.TIMES));
	    		map.put(CommonString.GAMES, FormatDecimal(rs.getString(CommonString.GAMES)));
	    		map.put(CommonString.PLAYERS, FormatDecimal(rs.getString(CommonString.PLAYERS)));
	    		map.put(CommonString.ROUNDS, FormatDecimal(rs.getString(CommonString.ROUNDS)));
	    		map.put(CommonString.BET, FormatDecimal(rs.getString(CommonString.BET)));
	    		map.put(CommonString.WIN, FormatDecimal(rs.getString(CommonString.WIN)));
	    		map.put(CommonString.PROFIT, FormatDecimal(rs.getString(CommonString.PROFIT)));
	    		if(rs.getString(CommonString.PAYRATE) == null)
	    			map.put(CommonString.PAYRATE, "0");
	    		else {
		    		float rtp = Float.valueOf(rs.getString(CommonString.PAYRATE));
		    		map.put(CommonString.PAYRATE, FormatDecimal(rtp*100));
	    		}
	    		list.add(map);
	    	}	    	
        } catch (SQLException e) {  
            e.printStackTrace();  
        }	    
	    closeConn();
		return list;
	}
	
    public String FormatDecimal(String x) {
    	if(x == null)
    		return "0";
    	DecimalFormat df = new DecimalFormat("#,###");
    	String s = df.format(Double.parseDouble(x));
    	return s;
    }
    
    public String FormatDecimal(float x) {
    	DecimalFormat df = new DecimalFormat("#.###");
    	String s = df.format(x);
    	return s;
    }
}
