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

public class GameOnlinePlayers {
	
	private Connection conn=null;  
	private PreparedStatement psmt=null;  
	private ResultSet rs=null;
	
	private void openConn() {  
	    String url=CommonString.DB_URL;  
	    String user=CommonString.DB_USER;  
	    String password=CommonString.DB_PW;  
	    try {  
	        Class.forName(CommonString.DB_DRIVER);  
	        conn=DriverManager.getConnection(url, user, password);  
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
	
	public List<Map<String, String>> getAllByPage(int pageSize, int pageIndex, String gameid) {  
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        openConn();  
        String sql = " select *"
        		   + " from member_Login, member_Account"
        		   + " where member_Login.userID = member_Account.userID"
        		   + " and member_Login.gameID = "
        		   + gameid
        		   + CommonString.SQLQUERYEND; 
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();  
            while(rs.next()) {  
                Map<String, String> map=new HashMap<String, String>();  
                map.put(CommonString.PAREMETER_USERID,rs.getString(CommonString.PAREMETER_USERID));
                map.put(CommonString.PARAMETER_GAMEID, rs.getString(CommonString.PARAMETER_GAMEID));
                map.put(CommonString.BALANCE, rs.getString(CommonString.BALANCE));  
                list.add(map);  
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        
        closeConn();
        return list;  
	}
	
    public int countRs(String gameid){  
        int count = 0;  
        String sql = " select count(*)"
        		   + " from member_Login, member_Account"
        		   + " where member_Login.userID = member_Account.userID"
        		   + " and member_Login.gameID = "
        		   + gameid
        		   + CommonString.SQLQUERYEND;
        
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
        
        try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return count;  
    }  

    public int getTotalPage(int pageSize, String gameid) {  
        int totalPage=countRs(gameid);
        if(pageSize> totalPage)
        	return 1;
        return (totalPage%pageSize==0)?(totalPage/pageSize):(totalPage/pageSize+1);  
    }
}
