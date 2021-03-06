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

public class OnlinePeopleCountsReport {

	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null; 	
	
	private void openConn() {  
	    String url = CommonString.DB_GF_MEMBER;  
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
	
	public List<Map<String, String>> getAllData(String datetime) {  
        List<Map<String, String>> list = new ArrayList<Map<String, String>>();
        openConn();
        try {
        	String sql = "select * from people_count "
        			   +" where time BETWEEN " + "'" + datetime + " 00:00:00'"
        			   +" AND " + "'" + datetime + " 23:59:59'"
        			   + CommonString.SQLQUERYEND;
        	psmt = conn.prepareStatement(sql);
        	rs = psmt.executeQuery(sql);	
			while(rs.next()) {
			Map<String, String> map = new HashMap<String, String>();
				map.put(CommonString.TIME, rs.getString(CommonString.TIME));
				map.put(CommonString.gameid_array[1], rs.getString(CommonString.gameid_array[1]));
				map.put(CommonString.gameid_array[2], rs.getString(CommonString.gameid_array[2]));
				map.put(CommonString.gameid_array[3], rs.getString(CommonString.gameid_array[3]));
				map.put(CommonString.gameid_array[4], rs.getString(CommonString.gameid_array[4]));
				map.put(CommonString.gameid_array[5], rs.getString(CommonString.gameid_array[5]));
				map.put(CommonString.gameid_array[6], rs.getString(CommonString.gameid_array[6]));
				list.add(map);
			}            
        } catch (SQLException e) {  
          e.printStackTrace();  
        }
        closeConn();     
        return list;
	}
	
    public String getMaxGamePeopleByGameID(String gameID, String datetime, String label_name) {
        int max = 0;  
        String sql = " select MAX(" + label_name + ") from people_count"
        		   + " where time BETWEEN " + "'" + datetime +" 00:00:00'"
        		   + " AND " + "'" + datetime +" 23:59:59'"
        		   + CommonString.SQLQUERYEND;
        openConn();  
        try {  
            psmt = conn.prepareStatement(sql);  
            rs = psmt.executeQuery();  
            while(rs.next()){
                max = rs.getInt(1);
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }   
        closeConn();        
    	return String.valueOf(max);
    }
    
    public String getAvgGamePeopleByGameID(String gameID, String datetime,  String label_name) {
        float avg = 0;  
        String sql = " select AVG( "+ label_name + ") from people_count"
        		   + " where time BETWEEN " + "'" + datetime +" 00:00:00'"
    			   + " AND " +  "'" + datetime +" 23:59:59'"
    			   + CommonString.SQLQUERYEND;
        openConn();  
        try {  
            psmt = conn.prepareStatement(sql);
            rs = psmt.executeQuery();
            while(rs.next()){
                avg = rs.getFloat(1);
            }  
        } catch (SQLException e) {
            e.printStackTrace();  
        }   
        closeConn();
    	return String.valueOf(avg);
    }    
}
