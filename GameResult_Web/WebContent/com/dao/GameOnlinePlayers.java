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
	        conn=DriverManager.getConnection(url,user,password);  
	    } catch (ClassNotFoundException e) {  
	        e.printStackTrace();  
	    } catch (SQLException e) {  
	        e.printStackTrace();  
	    }  
	}
	
	public List<Map<String, String>> getAllByPage(int pageSize,int pageIndex,String gameid) {  
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        openConn();  
        String sql="select * from resultsRecords";  
        try {  
            psmt=conn.prepareStatement(sql);  
            rs=psmt.executeQuery();  
            while(rs.next()) {  
                Map<String, String> map=new HashMap<String, String>();  
                map.put("roundUUID", rs.getString("roundUUID"));  
                map.put("userID",rs.getString("userID"));
                map.put("gameID", rs.getString("gameID"));
                map.put("betting", rs.getString("betting"));  
                map.put("lines",rs.getString("lines"));
                map.put("results", rs.getString("results"));
                map.put("roundStatus", rs.getString("roundStatus"));  
                map.put("prizeResults",rs.getString("prizeResults"));
                map.put("beforeBalance", rs.getString("beforeBalance"));
                map.put("afterBalance", rs.getString("afterBalance"));  
                map.put("specialNumber",rs.getString("specialNumber"));
                map.put("resultsDate", rs.getString("resultsDate"));
                map.put("resultsParams", rs.getString("resultsParams"));
                list.add(map);  
            }  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return list;  
	}
	
    public int countRs(String gameid){  
        int count = 0;  
        String sql = " select count(*)" +
        		" from member_Login, member_Account" +
   			 	" where member_Login.userID = member_Account.userID" + 
   			 	" and member_Login.gameID = " +
	   			 gameid;
        
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

    public int getTotalPage(int pageSize, String gameid) {  
        int totalPage=countRs(gameid);
        if(pageSize> totalPage)
        	return 1;
        return (totalPage%pageSize==0)?(totalPage/pageSize):(totalPage/pageSize+1);  
    }
}
