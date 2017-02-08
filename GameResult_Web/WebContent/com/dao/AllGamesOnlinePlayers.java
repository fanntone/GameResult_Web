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

public class AllGamesOnlinePlayers {

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
	
	public List<Map<String, String>> getAllData(String gameID) {
		openConn();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>(); 
		String sub_query = " where gameID = " + gameID;
		if(gameID.equalsIgnoreCase("ALL"))
			sub_query = " ";
		String sql = " select gameID, userID, count(*) as OnlinePlayers from member_Login "
				   + sub_query
				   + " group by gameID "
				   + CommonString.SQLQUERYEND;
		try {
	        psmt = conn.prepareStatement(sql);  
	        rs = psmt.executeQuery(); 
            while(rs.next()) { 
			    Map<String, String> map = new HashMap<String, String>();
			    map.put(CommonString.PARAMETER_GAMEID, rs.getString(CommonString.PARAMETER_GAMEID));
			    map.put(CommonString.PAREMETER_USERID, rs.getString(CommonString.PAREMETER_USERID));
			    map.put(CommonString.ONLINEPLAYERS, rs.getString(CommonString.ONLINEPLAYERS));
			    list.add(map);
            }			
		} catch (SQLException e) {  
            e.printStackTrace();  
        }
		closeConn();
        return list;
	}	
}
