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
        String create1_1st = parser1("`Game_1`");
        String create1_2nd = parser2("`Game_1`");
		String create1_3rd = parser3("`Game_1`", EnumAllGamesList.GAME_1.getValue());

        String create2_1st = parser1("`Game_2`");
        String create2_2nd = parser2("`Game_2`");
		String create2_3rd = parser3("`Game_2`", EnumAllGamesList.GAME_2.getValue());
		
        String create3_1st = parser1("`Game_3`");
        String create3_2nd = parser2("`Game_3`");
		String create3_3rd = parser3("`Game_3`", EnumAllGamesList.GAME_3.getValue());
		
        String create4_1st = parser1("`Game_4`");
        String create4_2nd = parser2("`Game_4`");
		String create4_3rd = parser3("`Game_4`", EnumAllGamesList.GAME_4.getValue());
		
        String create5_1st = parser1("`Game_5`");
        String create5_2nd = parser2("`Game_5`");
		String create5_3rd = parser3("`Game_5`", EnumAllGamesList.GAME_5.getValue());
		
        String create6_1st = parser1("`Game_6`");
        String create6_2nd = parser2("`Game_6`");
		String create6_3rd = parser3("`Game_6`", EnumAllGamesList.GAME_6.getValue());
		
		String query_show = 
			" SELECT Game_1.t_time, Game_1.t_count, Game_2.t_count, Game_3.t_count,"
			+" Game_4.t_count, Game_5.t_count, Game_6.t_count"
			+" FROM Game_1, Game_2, Game_3, Game_4, Game_5, Game_6"
			+" WHERE Game_1.t_time = Game_2.t_time"
			+" AND Game_1.t_time = Game_3.t_time"
			+" AND Game_1.t_time = Game_4.t_time"
			+" AND Game_1.t_time = Game_5.t_time"
			+" AND Game_1.t_time = Game_6.t_time"
			+" AND Game_1.t_time BETWEEN " + "'" + datetime +" 00:00:00'"
			+" AND " +  "'" + datetime +" 23:59:59'"
			+" ORDER BY Game_1.t_time;";
		
		String remove_1 = parser1("`Game_1`");
		String remove_2 = parser1("`Game_2`");
		String remove_3 = parser1("`Game_3`");
		String remove_4 = parser1("`Game_4`");
		String remove_5 = parser1("`Game_5`");
		String remove_6 = parser1("`Game_6`");
		
         try {  
        	// create temp table1
            psmt=conn.prepareStatement(create1_1st);  
            psmt.executeUpdate(create1_1st);            
            psmt=conn.prepareStatement(create1_2nd);  
            psmt.executeUpdate(create1_2nd);            
            psmt=conn.prepareStatement(create1_3rd);  
            psmt.executeUpdate(create1_3rd);
            // create temp table2
            psmt=conn.prepareStatement(create2_1st);  
            psmt.executeUpdate(create2_1st);           
            psmt=conn.prepareStatement(create2_2nd);  
            psmt.executeUpdate(create2_2nd);           
            psmt=conn.prepareStatement(create2_3rd);  
            psmt.executeUpdate(create2_3rd);
            // create temp table3
            psmt=conn.prepareStatement(create3_1st);  
            psmt.executeUpdate(create3_1st);           
            psmt=conn.prepareStatement(create3_2nd);  
            psmt.executeUpdate(create3_2nd);            
            psmt=conn.prepareStatement(create3_3rd);  
            psmt.executeUpdate(create3_3rd);
            // create temp table4
            psmt=conn.prepareStatement(create4_1st);  
            psmt.executeUpdate(create4_1st);           
            psmt=conn.prepareStatement(create4_2nd);  
            psmt.executeUpdate(create4_2nd);            
            psmt=conn.prepareStatement(create4_3rd);  
            psmt.executeUpdate(create4_3rd);
            // create temp table5
            psmt=conn.prepareStatement(create5_1st);  
            psmt.executeUpdate(create5_1st);           
            psmt=conn.prepareStatement(create5_2nd);  
            psmt.executeUpdate(create5_2nd);            
            psmt=conn.prepareStatement(create5_3rd);  
            psmt.executeUpdate(create5_3rd);
            // create temp table6
            psmt=conn.prepareStatement(create6_1st);  
            psmt.executeUpdate(create6_1st);           
            psmt=conn.prepareStatement(create6_2nd);  
            psmt.executeUpdate(create6_2nd);            
            psmt=conn.prepareStatement(create6_3rd);  
            psmt.executeUpdate(create6_3rd);
            // query show table
            psmt=conn.prepareStatement(query_show);  
            rs =psmt.executeQuery(query_show);
    
            while(rs.next()) {
                Map<String, String> map=new HashMap<String, String>();
                map.put("time", rs.getString("Game_1.t_time"));
                map.put("Game1",rs.getString("Game_1.t_count"));
                map.put("Game2",rs.getString("Game_2.t_count"));
                map.put("Game3",rs.getString("Game_3.t_count"));
                map.put("Game4",rs.getString("Game_4.t_count"));
                map.put("Game5",rs.getString("Game_5.t_count"));
                map.put("Game6",rs.getString("Game_6.t_count"));
                list.add(map);
            }
            
            // clean temp tables
            psmt=conn.prepareStatement(remove_1);  
            psmt.executeUpdate(remove_1);
            psmt=conn.prepareStatement(remove_2);  
            psmt.executeUpdate(remove_2);
            psmt=conn.prepareStatement(remove_3);  
            psmt.executeUpdate(remove_3);
            psmt=conn.prepareStatement(remove_4);  
            psmt.executeUpdate(remove_4);
            psmt=conn.prepareStatement(remove_5);  
            psmt.executeUpdate(remove_5);
            psmt=conn.prepareStatement(remove_6);  
            psmt.executeUpdate(remove_6);
            
      } catch (SQLException e) {  
          e.printStackTrace();  
      }  
      return list;  
	}
    
    private String parser1(String tmp_table_name) {
    	String sql = " DROP TEMPORARY TABLE IF EXISTS "+ tmp_table_name + ";" ;
    	return sql;
    }
    
    private String parser2(String tmp_table_name) {
    	String sql = 
    			"CREATE TEMPORARY TABLE " 
    			+ tmp_table_name 
    			+ " (`t_time` DATETIME NOT NULL, `t_count` INT NOT NULL);";
    	return sql;
    }
    
    private String parser3(String tmp_table_name, String gameID) {
    	String sql = 
    			"INSERT INTO " 
    			+ tmp_table_name.substring(1, tmp_table_name.length()-1) 
    			+" (`t_time`, `t_count`)"
    			+" SELECT time, count"
    			+" FROM online_People_Report"
    			+" WHERE gameID = " + gameID +";";
    	return sql;
    }
    
    public String getMaxGamePeopleByGameID(String gameID, String datetime) {
        int max = 0;  
        String sql = " select MAX(count) from online_People_Report where GameID = " + gameID
        		+" AND time BETWEEN " + "'" + datetime +" 00:00:00'"
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

    	return String.valueOf(max);
    }
    
    public String getAvgGamePeopleByGameID(String gameID, String datetime) {
        float avg = 0;  
        String sql = " select AVG(count) from online_People_Report where GameID = " + gameID
        		+" AND time BETWEEN " + "'" + datetime +" 00:00:00'"
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

    	return String.valueOf(avg);
    }
    
}
