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

public class GameResultRecordsDao {
	private Connection conn=null;  
	private PreparedStatement psmt=null;  
	private ResultSet rs=null;  
	
	private void openConn(){  
		
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

    public List<Map<String, String>> getAllemp(){  
        List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        openConn();  
        String sql="select * from resultsRecords";  
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
                map.put("results", rs.getString("results"));  
                map.put("prizeREsults",rs.getString("prizeREsults"));
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

    public List<Map<String, String>> getAllempByPage(int pageSize,int pageIndex){  
          List<Map<String, String>> list =new ArrayList<Map<String, String>>();  
          String dots = ",";
          String sql= "select * from resultsRecords order by roundUUID ASC Limit "
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
                  map.put("results", rs.getString("results"));  
                  map.put("prizeREsults",rs.getString("prizeREsults"));
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

    public int countEmp(){  
        int count=0;  
        String sql="select count(*) from resultsRecords";  
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

    public int getTotalPage(int pageSize){  
        int totalPage=countEmp();  
        return (totalPage%pageSize==0)?(totalPage/pageSize):(totalPage/pageSize+1);  
    }  
}
