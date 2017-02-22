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
	private Connection conn = null;  
	private PreparedStatement psmt = null;  
	private ResultSet rs = null;
	
	private void openConn() {
	    String url = CommonString.DB_GF_RECOREDRESULT;
	    String user = CommonString.DB_USER;  
	    String password = CommonString.DB_PW;  
	     try {  
	        Class.forName(CommonString.DB_DRIVER);  
	        conn = DriverManager.getConnection(url, user, password);  
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
	
    public List<Map<String, String>> getAllRecordsByPage(int pageSize,
    													 int pageIndex,
    													 String userID,
    													 String dateTime,
    													 String gameID){
    	openConn(); 
    	List<Map<String, String>> list =new ArrayList<Map<String, String>>();  
    	String sql_gameID = " ";
    	if(!gameID.equalsIgnoreCase("ALL"))
    		sql_gameID = " AND gameID = " + gameID;
    	String sql_userID = " " ;
    	if(!userID.equalsIgnoreCase("ALL"))
    		sql_userID = " AND userID = " + userID;
    	String sql = " select * from resultsRecords "
    			   + " WHERE resultsDate BETWEEN " + "'" + dateTime +" 00:00:00'"
    			   + " AND " +  "'" + dateTime +" 23:59:59' "
    			   + sql_gameID
    			   + sql_userID
    			   + " order by resultsDate DESC "
    			   + " Limit "
    			   + pageSize*(pageIndex - 1) + CommonString.DOTS + (pageSize)
    			   + CommonString.SQLQUERYEND;
	    try {
	    	psmt = conn.prepareStatement(sql);  
	    	rs = psmt.executeQuery();
	    	while(rs.next()){  
	    		Map<String, String> map = new HashMap<String, String>();
	    		String rs_string = rs.getString(CommonString.ROUNDUUID);
	    		int length = rs_string.length();
	    		int begin_index = 22;
	    		if(rs_string.contains(CommonString.FREEGAME) && !rs_string.contains(CommonString.ENTERFREEGAME))
	    			begin_index = rs_string.indexOf(CommonString.FREEGAME);
	    		else if(rs_string.contains(CommonString.FREEGAME) && rs_string.contains(CommonString.ENTERFREEGAME))
	    			begin_index = rs_string.indexOf(CommonString.ENTERFREEGAME);
	    		if(rs_string.contains(CommonString.BONUSGAME)&& !rs_string.contains(CommonString.ENTERBONUSGAME))
	    			begin_index = rs_string.indexOf(CommonString.BONUSGAME);
	    		else if(rs_string.contains(CommonString.BONUSGAME)&& rs_string.contains(CommonString.ENTERBONUSGAME))
	    			begin_index = rs_string.indexOf(CommonString.ENTERBONUSGAME);
	    		map.put(CommonString.ROUNDUUID, rs.getString(CommonString.ROUNDUUID).substring(begin_index, length));  
	    		map.put(CommonString.PAREMETER_USERID, rs.getString(CommonString.PAREMETER_USERID));
	    		map.put(CommonString.PARAMETER_GAMEID, rs.getString(CommonString.PARAMETER_GAMEID));
	    		map.put(CommonString.BETTING, rs.getString(CommonString.BETTING));
	    		map.put(CommonString.LINE, rs.getString(CommonString.LINE));
	    		map.put(CommonString.RESULTS, rs.getString(CommonString.RESULTS));
	    		map.put(CommonString.ROUNDSTATUS, rs.getString(CommonString.ROUNDSTATUS));  
	    		map.put(CommonString.PRIZERESULTS, rs.getString(CommonString.PRIZERESULTS));
	    		map.put(CommonString.BEFOREBALANCE, rs.getString(CommonString.BEFOREBALANCE));
	    		map.put(CommonString.AFTERBALANCE, rs.getString(CommonString.AFTERBALANCE));  
	    		map.put(CommonString.AGENT, rs.getString(CommonString.AGENT));
	    		map.put(CommonString.ORDERID, rs.getString(CommonString.ORDERID));
	    		map.put(CommonString.RESULTSDATE, rs.getString(CommonString.RESULTSDATE));
	    		map.put(CommonString.RESULTSPARAMS, rs.getString(CommonString.RESULTSPARAMS));
	    		list.add(map);
	    	}  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }             
	    closeConn();
        return list;  
    }  

    public int countRs(String userID, String dateTime, String gameID){
        openConn();
        int count = 0;  
    	String sql_gameID = " ";
    	if(!gameID.equalsIgnoreCase("ALL"))
    		sql_gameID = " AND gameID = " + gameID;
    	String sql_userID = " " ;
    	if(!userID.equalsIgnoreCase("ALL"))
    		sql_userID = " AND userID = " + userID;
        String sql = " select count(1) from resultsRecords "
	   		  	   + " WHERE resultsDate BETWEEN " + "'" + dateTime +" 00:00:00'"
	   		  	   + " AND " +  "'" + dateTime +" 23:59:59' "
	   		  	   + sql_gameID
	   		  	   + sql_userID
	   		  	   + CommonString.SQLQUERYEND;         
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

    public int getTotalPage(int pageSize, String userID, String datetime, String gameid) {  
        int totalPage = countRs(userID, datetime, gameid);
        if(pageSize > totalPage)
        	return 1;
        return (totalPage%pageSize == 0)?(totalPage/pageSize):(totalPage/pageSize + 1);
    }  
}
