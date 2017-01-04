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

public class GameResultRecords {
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

    public List<Map<String, String>> getAllRecordsByPage(int pageSize, int pageIndex, String userID, String datetime, String gameid){  
          List<Map<String, String>> list =new ArrayList<Map<String, String>>();  
          String dots = ",";
          String sql = " select * from resultsRecords where userID = " + userID 
        		  	 + " AND resultsDate BETWEEN " + "'" + datetime +" 00:00:00'"
        		  	 + " AND " +  "'" + datetime +" 23:59:59'"
        		  	 + " AND gameID = " + gameid
        		  	 + " order by roundUUID ASC Limit "
        		  	 + pageSize*(pageIndex-1) + dots +(pageSize);
           try {  
              psmt=conn.prepareStatement(sql);  
              rs=psmt.executeQuery();  
              while(rs.next()){  
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

    public int countRs(String userID, String datetime, String gameid){  
        int count = 0;  
        String sql = "select count(*) from resultsRecords where userID = " + userID
   		  	 + " AND resultsDate BETWEEN " + "'" + datetime +" 00:00:00'"
   		  	 + " AND " +  "'" + datetime +" 23:59:59'"
   		  	 + " AND gameID = " + gameid;
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

    public int getTotalPage(int pageSize, String userID, String datetime, String gameid) {  
        int totalPage=countRs(userID, datetime, gameid);  
        return (totalPage%pageSize==0)?(totalPage/pageSize):(totalPage/pageSize+1);  
    }  
}
