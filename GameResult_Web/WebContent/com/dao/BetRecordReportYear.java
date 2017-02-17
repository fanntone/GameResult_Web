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

public class BetRecordReportYear {

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
	
	public List<Map<String, String>> getAllRecords(String year, String sel_gameID) {
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
    	String sql_gameID = " and gameID = " + sel_gameID;
    	if(sel_gameID.equalsIgnoreCase("ALL"))
    		sql_gameID = "";
    	
        for(int month = 1 ; month <= 12; month++) {
        	sql = " select "
    			+ " Month(times) as times,"
    	    	+ " count(distinct gameID) as Games, "
    	    	+ " sum(Players) as Players, "
    	    	+ " sum(Rounds) as Rounds, "
	    		+ " sum(Bet) as Bet, "
    	    	+ " sum(Win) as Win, "
    	    	+ " sum(Profit) as Profit, "
    	    	+ " AVG(PayRate) as PayRate "
    	    	+ " from betRecordsByDay "
    	    	+ " where Year(times) = " + year
    	    	+ " and Month(times) = " + month
        		+ sql_gameID
        		+ CommonString.SQLQUERYEND;
    	    try {
    	    	psmt = conn.prepareStatement(sql);  
    	    	rs = psmt.executeQuery();
    	    	while(rs.next()) {
    		    	Map<String, String> map = new HashMap<String, String>();  
    		    	if(rs.getString(CommonString.TIMES) == null)
    		    		break;
    	    		map.put(CommonString.TIMES, rs.getString(CommonString.TIMES));
    	    		map.put(CommonString.GAMES, rs.getString(CommonString.GAMES));
    	    		map.put(CommonString.PLAYERS, rs.getString(CommonString.PLAYERS));
    	    		map.put(CommonString.ROUNDS, rs.getString(CommonString.ROUNDS));
    	    		map.put(CommonString.BET, rs.getString(CommonString.BET));
    	    		map.put(CommonString.WIN, rs.getString(CommonString.WIN));
    	    		map.put(CommonString.PROFIT, rs.getString(CommonString.PROFIT));
    	    		float rtp = Float.valueOf(rs.getString(CommonString.PAYRATE));
    	    		map.put(CommonString.PAYRATE, this.FormatDecimal(rtp));
    	    		list.add(map);
    	    	}	    	
            } catch (SQLException e) {  
                e.printStackTrace();  
            }	
        }
   	
	    closeConn();
		return list;
	}
	
    public String FormatDecimal(float x) {
    	DecimalFormat df = new DecimalFormat("#.#");
    	String s = df.format(x);
    	return s;
    }
}
