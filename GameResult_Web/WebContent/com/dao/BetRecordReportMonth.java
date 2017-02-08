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
	    String url = "jdbc:mysql://10.36.1.102:3306/GF_ResultsRecords";  
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
   			// TODO Auto-generated catch block
   			e.printStackTrace();
   		}
	}
	
	public List<Map<String, String>> getAllRecords(String year, String month, String sel_gameID){
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
    	String sql_gameID = " and gameID = " + sel_gameID;
    	if(sel_gameID.equalsIgnoreCase("ALL"))
    		sql_gameID = "";
    	sql = " select resultsDate as Day, "
    		+ " count(distinct gameID) as Games, "
    		+ " count(distinct userID) as Players, "
    		+ " count(betting) as Rounds, "
    		+ " sum(betting) as Bet, "
    		+ " sum(results) as Win, "
    		+ " sum(CONVERT(betting, SIGNED) - CONVERT(results, SIGNED)) as Profit, "
    		+ " sum(results)/sum(betting)*100 as PayRate "
    		+ " from resultsRecords "
    		+ " where resultsDate "
    		+ " between '" + year + "/" + month + "/01 00:00:00'"
    		+ " and '" + year + "/" + month + "/31 23:59:59'"
    		+ sql_gameID
    		+ " GROUP by Date(resultsDate)" 
    		+ CommonString.SQLQUERYEND;
	    try {
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {
		    	Map<String, String> map = new HashMap<String, String>();  
	    		map.put(CommonString.DAY, rs.getString(CommonString.DAY).substring(0,10));
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
