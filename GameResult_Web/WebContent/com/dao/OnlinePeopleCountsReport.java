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

	private Connection conn=null;  
	private PreparedStatement psmt=null;  
	private ResultSet rs=null; 	
	
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
	
	public List<Map<String, String>> getAllData(String datetime) {  
        List<Map<String, String>> list =new ArrayList<Map<String, String>>();
        openConn();
        try {
        	String sql = "select * from test_report"
        				+" where time BETWEEN " + "'" + datetime +" 00:00:00'"
        				+" AND " +  "'" + datetime +" 23:59:59'";
        	psmt=conn.prepareStatement(sql);  
        	rs = psmt.executeQuery(sql);
        	
			while(rs.next()) {
			Map<String, String> map=new HashMap<String, String>();
			map.put("time", rs.getString("test_report.time"));
			map.put("Game1",rs.getString("test_report.game01"));
			map.put("Game2",rs.getString("test_report.game02"));
			map.put("Game3",rs.getString("test_report.game03"));
			map.put("Game4",rs.getString("test_report.game04"));
			map.put("Game5",rs.getString("test_report.game05"));
			map.put("Game6",rs.getString("test_report.game06"));
			list.add(map);
			}
            
        } catch (SQLException e) {  
          e.printStackTrace();  
        }
        
        try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}      
        return list;  
	}
	
    public String getMaxGamePeopleByGameID(String gameID, String datetime, String label_name) {
        int max = 0;  
        String sql = " select MAX(" + label_name + ") from test_report"
        		+" where time BETWEEN " + "'" + datetime +" 00:00:00'"
    			+" AND " +  "'" + datetime +" 23:59:59'";
        openConn();  
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();  
            while(rs.next()){
                max=rs.getInt(1);
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }   
        
        try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
    	return String.valueOf(max);
    }
    
    public String getAvgGamePeopleByGameID(String gameID, String datetime,  String label_name) {
        float avg = 0;  
        String sql = " select AVG( "+ label_name + ") from test_report"
        		+" where time BETWEEN " + "'" + datetime +" 00:00:00'"
    			+" AND " +  "'" + datetime +" 23:59:59'";
        openConn();  
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();
            while(rs.next()){
                avg=rs.getFloat(1);
            }  
        } catch (SQLException e) {
            e.printStackTrace();  
        }   

        try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return String.valueOf(avg);
    }
    
}
