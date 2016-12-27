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
	
	public List<Map<String, String>> getAllempByPage(int pageSize,int pageIndex) {  
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        openConn();
        String dots = ",";
        String sql = " select member_Login.userID,member_Account.balance,member_Login.gameID" +
        			 " from member_Login, member_Account" +
        			 " where member_Login.userID = member_Account.userID Limit "
        			 + pageSize*(pageIndex-1) + dots +(pageSize);  
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();  
            while(rs.next()) {  
                Map<String, String> map=new HashMap<String, String>();  
                map.put("userID", rs.getString("member_Login.userID"));
                map.put("blance", rs.getString("member_Account.balance"));
                map.put("gameID",rs.getString("member_Login.gameID"));
                list.add(map);
            }
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return list;
	}
	
    public int countRs(){  
        int count = 0;  
        String sql = " select count(*) from member_Login";   
        openConn();  
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();  
            while(rs.next()){  
                count=rs.getInt(1);
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return count;  
    }  

    public int getTotalPage(int pageSize) {  
        int totalPage=countRs();  
        return (totalPage%pageSize==0)?(totalPage/pageSize):(totalPage/pageSize+1);  
    }
}
