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
	
	public List<Map<String,String>> getAllTimeList() {
		List<Map<String, String>> list =new ArrayList<Map<String, String>>();
		openConn();
		
        try {
        	String sql_1 = "set @test_1:= '2017/01/13 00:00:00';";
        	String sql_2 = "select distinct Time(time) as Times from test_report where time between @test_1 and ADDDATE(@test_1, interval  1 DAY);";
        	psmt=conn.prepareStatement(sql_1);  
        	rs = psmt.executeQuery(sql_1);
        	psmt=conn.prepareStatement(sql_2);  
        	rs = psmt.executeQuery(sql_2);   	
        	while (rs.next())
        	{
    			Map<String, String> map=new HashMap<String, String>();
				map.put("Times", rs.getString("Times"));
				list.add(map);
        	}
        	
			conn.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
			
		return list;
	}
	
	public List<Map<String, String>> getAllData(String datetime, int sel_month, int sel_year, int sel_game, String time) {  
        List<Map<String, String>> list =new ArrayList<Map<String, String>>();
        openConn();
        
        int max = 12;       	
        try {
        	String sql = "set @test_1:= '" + datetime +"';";
        	psmt=conn.prepareStatement(sql);  
        	rs = psmt.executeQuery(sql);
			String sql_2 = " select Sum(" + CommonString.gameid_array[sel_game] + ")as counts from test_report"
						 + " where time between @test_1"
						 + " and ADDDATE(@test_1, interval 1 Month)"
						 + " and Time(time) = '" + time + "'";
        	for(int i = 1; i<max; i++) {
        		sql_2 += " UNION ALL "
        				 + " select Sum(" + CommonString.gameid_array[sel_game] + ")as counts from test_report"
						 + " where time between ADDDATE(@test_1, interval " + i +" Month)"
						 + " and ADDDATE(@test_1, interval " + (i+1) +" Month)"
						 + " and Time(time) = '" + time + "'";
        	}
        	sql_2 += ";";
        	psmt=conn.prepareStatement(sql_2);
        	rs = psmt.executeQuery(sql_2);
        	
        	while (rs.next())
        	{
    			Map<String, String> map=new HashMap<String, String>();
				map.put("Counts_1", rs.getString("counts"));
				list.add(map);
        	}
        	closeConn();
        	
        } catch (SQLException e) {  
          e.printStackTrace();  
        }
            
        return list;  
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
