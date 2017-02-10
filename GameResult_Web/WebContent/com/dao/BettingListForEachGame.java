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

public class BettingListForEachGame {

	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;  
	private String sql_quato = "'";
	private String dots = ",";
	
	private void openConn() {  
	    String url = CommonString.DB_GF_RECOREDRESULT; 
	    String user = CommonString.DB_USER;  
	    String password = CommonString.DB_PW;  
	    try {  
	        Class.forName(CommonString.DB_DRIVER);  
	        conn=DriverManager.getConnection(url,user,password);  
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
	
	public List<Map<String, String>> getAllRecords(String date,
												   String gameID,
												   String orderby,
												   String asc,
												   String userID,
												   int pageSize,
												   int pageIndex){
		openConn(); 
	    List<Map<String, String>> list = new ArrayList<Map<String, String>>();
    	String sql;
    	String orderby_str;
    	if(asc.equalsIgnoreCase("1"))
    		orderby_str = " order by " + orderby + " ASC "; 
    	else
    		orderby_str = " order by " + orderby + " DESC ";
    	
    	String sub_query = " and userID = " + userID;
    	if(userID.equalsIgnoreCase("ALL"))
    		sub_query = " ";
    	sql = " select userID, " 
    		+ " count(betting) as Rounds, "
    		+ " sum(betting) as Bet, "
    		+ " sum(results) as Win, "
    		+ " sum(CONVERT(betting, SIGNED) - CONVERT(results, SIGNED)) as Profit, "
    		+ " sum(results)/sum(betting)*100 as PayRate "
    		+ " from resultsRecords where Date(resultsDate) = "
    		+ sql_quato + date + sql_quato 
    		+ " and gameID = " +  gameID
    		+ sub_query
    		+ " GROUP by userID "
    		+ orderby_str
		  	+ " Limit "
		  	+ pageSize*(pageIndex-1) + dots +(pageSize)
    		+ CommonString.SQLQUERYEND;
	    try {
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();  
	    	while(rs.next()) {
		    	Map<String, String> map = new HashMap<String, String>();
	    		map.put(CommonString.PLAYERS, rs.getString(CommonString.PAREMETER_USERID));
	    		map.put(CommonString.ROUNDS, rs.getString(CommonString.ROUNDS));
	    		map.put(CommonString.BET, rs.getString(CommonString.BET));
	    		map.put(CommonString.WIN, rs.getString(CommonString.WIN));
	    		map.put(CommonString.PROFIT, rs.getString(CommonString.PROFIT));
	    		map.put(CommonString.PAYRATE, rs.getString(CommonString.PAYRATE));
	    		list.add(map);	
	    	}	    	
        } catch (SQLException e) {  
            e.printStackTrace();
        }	    
	    closeConn();
		return list;
	}
	
    public int countRs(String date, String gameid, String userID){  
        int count = 0;
    	String sub_query = " and userID = " + userID;
    	if(userID.equalsIgnoreCase(CommonString.ALL))
    		sub_query = " ";
        String sql = "select count(distinct userID) as Players"
        		   + " from resultsRecords where Date(resultsDate) = "
	    		   + sql_quato + date + sql_quato 
	    		   + " AND gameID = " + gameid
	    		   + sub_query
	    		   + CommonString.SQLQUERYEND;
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

    public int getTotalPage(int pageSize, String datetime, String gameid, String userID) {  
        int totalPage = countRs(datetime, gameid, userID);
        if(pageSize> totalPage)
        	return 1;
        return (totalPage%pageSize == 0)?(totalPage/pageSize):(totalPage/pageSize + 1);
    }  
}
