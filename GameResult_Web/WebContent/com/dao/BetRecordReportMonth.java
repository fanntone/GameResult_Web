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

public class BetRecordReportMonth {

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
	
	public List<Map<String, String>> getAllRecords(String year, String month, String sel_gameID){
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
    	String sql_gameID = " and gameID = " + sel_gameID;
    	if(sel_gameID.equalsIgnoreCase("ALL"))
    		sql_gameID = "";
    	
    	int sel_month = Integer.valueOf(month);
    	int sel_year = Integer.valueOf(year);
        int max = 31;
        if (sel_month == 2) {
        	max = 28;
        	if(sel_year%4 == 0)
        		max = 29;
        }
        else if (sel_month == 4 || sel_month == 6 || sel_month == 9 || sel_month == 11)
        	max = 30;
    	for(int day = 1; day <= max; day++) {
        	sql = " select Date(times) as times, Players, Rounds, Bet, Win, Profit, PayRate,"
    			+ " (select count(distinct gameID) "
    	    	+ " from betRecordsByDay "
    	    	+ " where Year(times) = " + year
    	    	+ " and Month(times) = " + month
    	    	+ " and DAY(times) = " + day
	    		+ " ) as Games "
    	    	+ " from betRecordsByDay "
    	    	+ " where Year(times) = " + year
    	    	+ " and Month(times) = " + month
    	    	+ " and DAY(times) = " +  day
        		+ sql_gameID
        		+ " group by Date(times) " 
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
    	    		float rtp = Float.valueOf(rs.getString(CommonString.PAYRATE));
    	    		map.put(CommonString.PAYRATE, FormatDecimal(this.FormatDecimal(rtp)));
    	    		list.add(map);
    	    	}	    	
            } catch (SQLException e) {
                e.printStackTrace();  
            }	
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
