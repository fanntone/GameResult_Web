package com.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PlayersMoneyChange {
	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;  
	
	private void openConn() {  
	    String url="jdbc:mysql://10.36.1.102:3306/GF_ResultsRecords";
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
	        if(userID.equalsIgnoreCase("ALL"))
	        	sub_query = " ";
	    	String sql = " select gameID, "
	    			   + " SUM(CONVERT(afterBalance, SIGNED) - CONVERT(beforeBalance, SIGNED)) AS counts "
	    			   + " from resultsRecords "
	    			   + " where resultsDate between " 
	    			   + CommonString.TIMEDATE_QUATO + sel_year + "/" + sel_month + "/" + Day + CommonString.DAYTIMEBRGIN + CommonString.TIMEDATE_QUATO
	    			   + " and " + CommonString.TIMEDATE_QUATO + sel_year + "/" + sel_month + "/" + Day + CommonString.DAYTIMEEND + CommonString.TIMEDATE_QUATO
	    			   + sub_query
	    			   + " group by gameID ";
	    	sql += CommonString.SQLQUERYEND;
	    	psmt=conn.prepareStatement(sql);  
	    	rs=psmt.executeQuery();
	    	while(rs.next()) {
	    		if(rs.getString("gameID").equalsIgnoreCase(EnumAllGamesList.GAME_1.getValue())) {
	    			list[1] = rs.getInt("counts");
	    			list[0] +=  rs.getInt("counts");
	    		}
	    		if(rs.getString("gameID").equalsIgnoreCase(EnumAllGamesList.GAME_2.getValue())) {
	    			list[2] = rs.getInt("counts");
	    			list[0] +=  rs.getInt("counts");
	    		}
	    		if(rs.getString("gameID").equalsIgnoreCase(EnumAllGamesList.GAME_3.getValue())) {
	    			list[3] = rs.getInt("counts");
	    			list[0] +=  rs.getInt("counts");
	    		}
	    		if(rs.getString("gameID").equalsIgnoreCase(EnumAllGamesList.GAME_4.getValue())) {
	    			list[4] = rs.getInt("counts");
	    			list[0] +=  rs.getInt("counts");
	    		}
	    		if(rs.getString("gameID").equalsIgnoreCase(EnumAllGamesList.GAME_5.getValue())) {
	    			list[5] = rs.getInt("counts");
	    			list[0] +=  rs.getInt("counts");
	    		}
	    		if(rs.getString("gameID").equalsIgnoreCase(EnumAllGamesList.GAME_6.getValue())) {
	    			list[6] = rs.getInt("counts");
	    			list[0] +=  rs.getInt("counts");
	    		}
	    	}
	    	
        } catch (SQLException e) {  
            e.printStackTrace();  
        }
	    
	    closeConn();
		return list;
	}
}
