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

public class PlayerDetail {

	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null; 	
	
	private void openConn() {  
	    String url = CommonString.DB_GF_MEMBER;  
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
	
	public List<Map<String, String>> getAllData(int userID) {  
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();  
        openConn();  
        String sql = " select * from member_Account where userID = " + String.valueOf(userID);  
        try {  
            psmt = conn.prepareStatement(sql);  
            rs = psmt.executeQuery();  
            while(rs.next()) {  
                Map<String, String> map=new HashMap<String, String>();  
                map.put(CommonString.PAREMETER_USERID, rs.getString(CommonString.PAREMETER_USERID));  
                map.put(CommonString.CURRENCY, rs.getString(CommonString.CURRENCY));
                map.put(CommonString.LOGINID, rs.getString(CommonString.LOGINID));
                map.put(CommonString.PASSWORD, rs.getString(CommonString.PASSWORD));
                map.put(CommonString.NICKNAME, rs.getString(CommonString.NICKNAME));  
                map.put(CommonString.BALANCE, rs.getString(CommonString.BALANCE));
                map.put(CommonString.USERSTATUS, rs.getString(CommonString.USERSTATUS));
                map.put(CommonString.STATUS, rs.getString(CommonString.STATUS)); 
                map.put(CommonString.REGTYPE, rs.getString(CommonString.REGTYPE));
                map.put(CommonString.GM, rs.getString(CommonString.GM)); 
                list.add(map); 
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }      
        closeConn();
        return list;
	}
}
