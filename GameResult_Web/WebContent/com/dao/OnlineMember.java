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

	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;

	private void openConn() {  
	    String url = CommonString.DB_URL;  
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
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<Map<String, String>> getAllempByPage(int pageSize, int pageIndex, String gameID) {  
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        openConn();
        String sub_query = " and member_Login.gameID = " + gameID;
        if(gameID.equalsIgnoreCase("ALL"))
        	sub_query = " ";
        String sql = " select member_Login.userID, member_Account.balance, member_Login.gameID"
        		   + " from member_Login, member_Account"
        		   + " where member_Login.userID = member_Account.userID "
        		   + sub_query
        		   + " Limit "
        		   + pageSize*(pageIndex-1) + CommonString.DOTS +(pageSize)
        		   + CommonString.SQLQUERYEND;  
        try {  
            psmt = conn.prepareStatement(sql);  
            rs = psmt.executeQuery();  
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
        closeConn();
        return list;
	}
	
    public int countRs(String gameID){  
        int count = 0;
        String sub_query = " where member_Login.gameID = " + gameID;
        if(gameID.equalsIgnoreCase("ALL"))
        	sub_query = " ";
        String sql = " select count(*) from member_Login " + sub_query + CommonString.SQLQUERYEND;   
        openConn();  
        try {  
            psmt = conn.prepareStatement(sql);  
            rs = psmt.executeQuery();  
            while(rs.next()){  
                count = rs.getInt(1);
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }
        closeConn();
        return count;  
    }  

    public int getTotalPage(int pageSize, String gameID) {  
        int totalPage = countRs(gameID);
        if(pageSize > totalPage)
        	return 1;
        return (totalPage%pageSize == 0)?(totalPage/pageSize):(totalPage/pageSize + 1);  
    }
}
