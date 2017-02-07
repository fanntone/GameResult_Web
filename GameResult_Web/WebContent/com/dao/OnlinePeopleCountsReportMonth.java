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
	
	private void closeConn() {
        try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<Map<String,String>> getAllTimeList() {
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		openConn();
		
        try {
        	String sql_1 = "set @test_1:= '2017/01/01 00:00:00';";
        	String sql_2 = "set @test_2:= '2017/01/31 23:59:59';";
        	String sql_3 = "select all Time(time) as Times from test_report group by Time(time);";
        	psmt = conn.prepareStatement(sql_1);  
        	rs = psmt.executeQuery(sql_1);
        	psmt = conn.prepareStatement(sql_2);  
        	rs = psmt.executeQuery(sql_2);
        	psmt = conn.prepareStatement(sql_3);  
        	rs = psmt.executeQuery(sql_3);      	
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
	
	public int[] getAllData(String datetime, int sel_month, int sel_year, int sel_game, String times) {          
        openConn();
        int max = 31;
        if (sel_month == 2) {
        	max = 28;
        	if(sel_year%4 == 0)
        		max = 29;
        }
        else if (sel_month == 4 || sel_month == 6 || sel_month == 9 || sel_month == 11)
        	max = 30;
        int[] count_day = new int[max];       
        try {
        	String sql = "set @test_1:= '" + datetime + "';";
        	psmt=conn.prepareStatement(sql);  
        	rs = psmt.executeQuery(sql);
			String sql_2;
			sql_2 = " select Sum(" + CommonString.gameid_array[sel_game] + ")as counts "
				  + " ,DAY(time)as days"
				  + " from test_report "
				  + " where Time(time) = '" + times + "' "
				  + " and Month(time) = " + sel_month
				  + " group by DAY(time)"
				  + CommonString.SQLQUERYEND;
        	psmt = conn.prepareStatement(sql_2);
        	rs = psmt.executeQuery(sql_2);       	
        	while (rs.next())
        	{
        		int index = rs.getInt("days");
				count_day[index-1] = rs.getInt("counts");
        	}        	
        } catch (SQLException e) {  
          e.printStackTrace();  
        }
    	closeConn();    
        return count_day;  
	}
	
    public String getMaxGamePeopleByGameID(String date, int sel_game) {
        int max = 0;
        String sql = " select MAX(" + CommonString.gameid_array[sel_game] + ")from test_report"
        		   + " where time BETWEEN " + "'" + date +" 00:00:00'"
        		   + " AND " +  "'" + date +" 23:59:59'"
        		   + CommonString.SQLQUERYEND;
        openConn();  
        try {  
            psmt = conn.prepareStatement(sql);
            rs = psmt.executeQuery();  
            while(rs.next()){
            	if(rs.getInt(1) != 0 && rs.getInt(1)> max)
            		max = rs.getInt(1);
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }
    	closeConn();        
    	return String.valueOf(max);
    }
    
    public String getAvgGamePeopleByGameID(String datetime,  int sel_game) {
        float avg = 0;  
        String sql = " select AVG( "+ CommonString.gameid_array[sel_game] + ") from test_report"
        		   + " where time BETWEEN " + "'" + datetime +" 00:00:00'"
        		   + " AND " +  "'" + datetime +" 23:59:59'";
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
