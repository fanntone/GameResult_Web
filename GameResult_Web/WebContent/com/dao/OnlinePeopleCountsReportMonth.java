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

public class OnlinePeopleCountsReportMonth {

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
	
	public List<Map<String, String>> getAllData() {  
        List<Map<String, String>> list =new ArrayList<Map<String, String>>();
        openConn();
        
        try {
        	String sql = "select * from test_report_month ";
        	psmt=conn.prepareStatement(sql);  
        	rs = psmt.executeQuery(sql);
        	  	
			while(rs.next()) {
				Map<String, String> map=new HashMap<String, String>();
				map.put("Time", rs.getString("time"));
				map.put("Day1", rs.getString("day1"));
				map.put("Day2", rs.getString("day2"));
				map.put("Day3", rs.getString("day3"));
				map.put("Day4", rs.getString("day4"));
				map.put("Day5", rs.getString("day5"));
				map.put("Day6", rs.getString("day6"));
				map.put("Day7", rs.getString("day7"));
				map.put("Day8", rs.getString("day8"));
				map.put("Day9", rs.getString("day9"));
				map.put("Day10", rs.getString("day10"));
				map.put("Day11", rs.getString("day11"));
				map.put("Day12", rs.getString("day12"));
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
