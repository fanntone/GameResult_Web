package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;

public class PlayersMoneyChange {
	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;  
	
	private void openConn() {  
	    String url = CommonString.DB_GF_RECOREDRESULT;
	    String user = CommonString.DB_USER;  
	    String password = CommonString.DB_PW;  
	     try {  
	        Class.forName(CommonString.DB_DRIVER);  
	        conn = DriverManager.getConnection(url,user,password);  
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
	
	public int[] getAllRecords(String sel_year,
							   String sel_month,
							   int day,
							   String userID){
		int[] list = new int[] {0,0,0,0,0,0,0};
		openConn();
	    try {
	    	String Day;
	    	if(day < 10)
	    		Day= "0" + String.valueOf(day);
	    	else
	    		Day = String.valueOf(day);	    	
	    	String sub_query = " and userID = " + userID;
	        if(userID.equalsIgnoreCase(CommonString.ALL))
	        	sub_query = " ";
	    	String sql = " select gameID, "
	    			   + " sum(Counts) as counts"
	    			   + " from PlayersWinRankingByFiveMins "
	    			   + " where times = (select Max(times) from PlayersWinRankingByFiveMins where Date(times) = " 
	    			   + "'" + sel_year + "/" + sel_month + "/" + Day + "') "
	    			   + sub_query
	    			   + " group by gameID, userID ";
	    	sql += CommonString.SQLQUERYEND;
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();
	    	while(rs.next()) {
	    		if(rs.getString(CommonString.PARAMETER_GAMEID).equalsIgnoreCase(EnumAllGamesList.GAME_1.getValue())) {
	    			list[1] = rs.getInt(CommonString.COUNTS);
	    			list[0] += rs.getInt(CommonString.COUNTS);
	    		}
	    		if(rs.getString(CommonString.PARAMETER_GAMEID).equalsIgnoreCase(EnumAllGamesList.GAME_2.getValue())) {
	    			list[2] = rs.getInt(CommonString.COUNTS);
	    			list[0] += rs.getInt(CommonString.COUNTS);
	    		}
	    		if(rs.getString(CommonString.PARAMETER_GAMEID).equalsIgnoreCase(EnumAllGamesList.GAME_3.getValue())) {
	    			list[3] = rs.getInt(CommonString.COUNTS);
	    			list[0] += rs.getInt(CommonString.COUNTS);
	    		}
	    		if(rs.getString(CommonString.PARAMETER_GAMEID).equalsIgnoreCase(EnumAllGamesList.GAME_4.getValue())) {
	    			list[4] = rs.getInt(CommonString.COUNTS);
	    			list[0] += rs.getInt(CommonString.COUNTS);
	    		}
	    		if(rs.getString(CommonString.PARAMETER_GAMEID).equalsIgnoreCase(EnumAllGamesList.GAME_5.getValue())) {
	    			list[5] = rs.getInt(CommonString.COUNTS);
	    			list[0] += rs.getInt(CommonString.COUNTS);
	    		}
	    		if(rs.getString(CommonString.PARAMETER_GAMEID).equalsIgnoreCase(EnumAllGamesList.GAME_6.getValue())) {
	    			list[6] = rs.getInt(CommonString.COUNTS);
	    			list[0] += rs.getInt(CommonString.COUNTS);
	    		}
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

}
