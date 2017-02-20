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

public class AllGamesBetRecord {

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
	
	public List<Map<String, String>> getAllRecords(String date, String orderby, String asc) {
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql, sql_2, sql_3;
    	String orderby_str;
    	if(asc.equalsIgnoreCase("1"))
    		orderby_str = " order by " + orderby + " ASC;"; 
    	else
    		orderby_str = " order by " + orderby + " DESC;";
    	sql = " select gameID, " 
    		+ " count(distinct userID) as Players, "
    		+ " count(betting) as Rounds, "
    		+ " sum(betting) as Bet, "
    		+ " sum(results) as Win, "
    		+ " sum(CONVERT(betting, SIGNED) - CONVERT(results, SIGNED)) as Profit, "
    		+ " sum(results)/sum(betting)*100 as PayRate "
    		+ " from resultsRecords where Date(resultsDate) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO;

    	sql_2 = " select distinct gameID "
        	  + " from resultsRecords where Date(resultsDate) = "
        	  + CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO
    	      + CommonString.SQLQUERYEND;
	    try {
	    	psmt = conn.prepareStatement(sql_2);  
	    	rs = psmt.executeQuery();
	    	String[] gameID_array = new String[50];
	    	int i = 0;
	    	while(rs.next()) {
	    		gameID_array[i] = rs.getString(CommonString.PARAMETER_GAMEID);
	    		i++;	
	    	}
	    	for(int j = 0; j < i; j++) {
	        	sql_3 = sql + " and gameID = " + gameID_array[j] + orderby_str;
		    	psmt = conn.prepareStatement(sql_3);  
		    	rs = psmt.executeQuery();  
		    	while(rs.next()) {
			    	Map<String, String> map = new HashMap<String, String>();  
		    		map.put(CommonString.PARAMETER_GAMEID, rs.getString(CommonString.PARAMETER_GAMEID));
		    		map.put(CommonString.PLAYERS, rs.getString(CommonString.PLAYERS));
		    		map.put(CommonString.ROUNDS, rs.getString(CommonString.ROUNDS));
		    		map.put(CommonString.BET, rs.getString(CommonString.BET));
		    		map.put(CommonString.WIN, rs.getString(CommonString.WIN));
		    		map.put(CommonString.PROFIT, rs.getString(CommonString.PROFIT));
		    		String sum_bet = rs.getString(CommonString.BET);
		    		if(sum_bet == null ||  sum_bet.equalsIgnoreCase("0") || sum_bet.equalsIgnoreCase(""))
		    			map.put(CommonString.PAYRATE, "0");
		    		else
		    			map.put(CommonString.PAYRATE, rs.getString(CommonString.PAYRATE));
		    		list.add(map);	
		    	}
	    	}

        } catch (SQLException e) {  
            e.printStackTrace();  
        }
	    closeConn();
		return list;
	}
}
