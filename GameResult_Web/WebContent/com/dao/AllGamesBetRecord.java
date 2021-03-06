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
	
	public List<Map<String, String>> getAllRecords(String date, String orderby, String asc, String sel_gameID) {
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
    	String orderby_str;
    	String sub_query = "";
    	if(asc.equalsIgnoreCase("1"))
    		orderby_str = " order by " + orderby + " DESC "; 
    	else
    		orderby_str = " order by " + orderby + " DESC ";
    	if(sel_gameID.equalsIgnoreCase("ALL"))
    		sub_query = "";
    	else
    		sub_query = " and gameType = " + CommonString.TIMEDATE_QUATO + sel_gameID + CommonString.TIMEDATE_QUATO;
    	sql = " select Date(times) as times, "
    		+ " betRecordsByFiveMins.gameID, "
    		+ " gameList.gameType as gameType, "
    		+ " Players, Rounds, Bet, Win, Profit, PayRate "
    		+ " from betRecordsByFiveMins, gameList "
    		+ " where Date(times) = "
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO
    		+ " and times = (select Max(times) from betRecordsByFiveMins where Date(times) = " 
    		+ CommonString.TIMEDATE_QUATO + date + CommonString.TIMEDATE_QUATO
    		+  ") "
    		+ " and betRecordsByFiveMins.gameID = gameList.gameID "
    		+ sub_query
    		+ orderby_str
    		+ CommonString.SQLQUERYEND;
	    try {
		    	psmt = conn.prepareStatement(sql);  
		    	rs = psmt.executeQuery();
		    	while(rs.next()) {
		    		Map<String, String> map = new HashMap<String, String>();  
		    		map.put(CommonString.TIMES, rs.getString(CommonString.TIMES));
		    		map.put(CommonString.PARAMETER_GAMEID, rs.getString(CommonString.PARAMETER_GAMEID));
		    		map.put(CommonString.PLAYERS, FormatDecimal(rs.getString(CommonString.PLAYERS)));
		    		map.put(CommonString.ROUNDS, FormatDecimal(rs.getString(CommonString.ROUNDS)));
		    		map.put(CommonString.BET, FormatDecimal(rs.getString(CommonString.BET)));
		    		map.put(CommonString.WIN, FormatDecimal(rs.getString(CommonString.WIN)));
		    		map.put(CommonString.PROFIT, FormatDecimal(rs.getString(CommonString.PROFIT)));
		    		float rtp = Float.valueOf(rs.getString(CommonString.PAYRATE));
		    		map.put(CommonString.PAYRATE, FormatDecimal(this.FormatDecimal(rtp)));
		    		list.add(map);
		    	}

        } catch (SQLException e) {  
            e.printStackTrace();  
        }
	    closeConn();
		return list;
	}
	
    public String FormatDecimal(String x) {
    	DecimalFormat df = new DecimalFormat("#,###");
    	String s = df.format(Double.parseDouble(x));
    	return s;
    }
    
    public String FormatDecimal(float x) {
    	DecimalFormat df = new DecimalFormat("#.#");
    	String s = df.format(x);
    	return s;
    }
}
