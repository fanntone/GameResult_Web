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

public class OnlineMember {

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
	
	public List<Map<String, String>> getAllData() {  
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        openConn();  
        String sql = "select * from member_Login where loginStatus > 0";  
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();  
            while(rs.next()) {  
                Map<String, String> map=new HashMap<String, String>();  
                map.put("userID", rs.getString("userID"));  
                map.put("gameID",rs.getString("gameID"));
                list.add(map);
            }
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return list;
	}
}
