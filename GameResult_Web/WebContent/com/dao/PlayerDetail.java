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

	private Connection conn=null;  
	private PreparedStatement psmt=null;  
	private ResultSet rs=null; 	
	
	private void openConn() {  
	    String url="jdbc:mysql://10.36.1.102:3306/TEST";  
	    String user="root";  
	    String password="3edc2wsx!QAZ";  
	     try {  
	        Class.forName("com.mysql.jdbc.Driver");  
	        conn=DriverManager.getConnection(url,user,password);  
	    } catch (ClassNotFoundException e) {  
	        e.printStackTrace();  
	    } catch (SQLException e) {  
	        e.printStackTrace();  
	    }  
	} 
	
	public List<Map<String, String>> getAllData(int userID) {  
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        openConn();  
        String sql="select * from member_Account where userID = " + String.valueOf(userID);  
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();  
            while(rs.next()) {  
                Map<String, String> map=new HashMap<String, String>();  
                map.put("userID", rs.getString("userID"));  
                map.put("currency",rs.getString("currency"));
                map.put("loginID", rs.getString("loginID"));
                map.put("passWord", rs.getString("passWord"));
                map.put("nickName", rs.getString("nickName"));  
                map.put("balance",rs.getString("balance"));
                map.put("userStatus", rs.getString("userStatus"));
                map.put("status", rs.getString("status")); 
                map.put("regType", rs.getString("regType"));
                map.put("gm", rs.getString("gm")); 
                list.add(map);
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }
        return list;
	}
}
