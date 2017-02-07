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

public class OnlinePeopleCountsReportYear {

	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;
	
	private void openConn() {  
	    String url = CommonString.DB_URL;  
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
	
	public List<Map<String,String>> getAllTimeList() {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		openConn();
		
        try {
        	String sql_1 = "set @test_1:= '2017/01/31 00:00:00';";
        	String sql_2 = "select distinct Time(time) as Times from people_count where time between @test_1 and ADDDATE(@test_1, interval  1 DAY);";
        	psmt = conn.prepareStatement(sql_1);  
        	rs = psmt.executeQuery(sql_1);
        	psmt = conn.prepareStatement(sql_2);  
        	rs = psmt.executeQuery(sql_2);   	
        	while (rs.next())
        	{
    			Map<String, String> map = new HashMap<String, String>();
				map.put("Times", rs.getString("Times"));
				list.add(map);
        	}
        	
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        closeConn();	
		return list;
	}
	
	public int[] getAllData(String datetime, int sel_month, int sel_year, int sel_game, String time) {  
		int[] count_mounts = new int[12];
        openConn();    	
        try {
        	String sql = "set @test_1:= '" + datetime +"';";
        	psmt = conn.prepareStatement(sql);  
        	rs = psmt.executeQuery(sql);
			String sql_2 = " select Month(time) as mounts, "
						 + " Sum(" + CommonString.gameid_array[sel_game] + ")as counts "
						 + " from people_count "
						 + " where Time(time) = '" + time + "'"
						 + " and Year(time) = " + sel_year
						 + " group by Month(time) "
						 + CommonString.SQLQUERYEND;
        	psmt = conn.prepareStatement(sql_2);
        	rs = psmt.executeQuery(sql_2);      	
        	while (rs.next())
        	{
        		count_mounts[rs.getInt("mounts")-1] = rs.getInt("counts");
        	}      	
        } catch (SQLException e) {  
          e.printStackTrace();  
        }
    	closeConn(); 
        return count_mounts;  
	}
	
	public void closeConn() {
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
