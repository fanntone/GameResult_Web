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

public class AllGamesOnlinePlayers {

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
	
	public List<Map<String, String>> getAllData() {  
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();  
        List<String> game_list = new ArrayList<String>();
        for(EnumAllGamesList eu : EnumAllGamesList.values()) {
        	game_list.add(eu.getValue());
        }
		
		for(int i = 1; i < game_list.size(); i++) {  
		    Map<String, String> map=new HashMap<String, String>();
		    String game_id = game_list.get(i);
		    map.put(CommonString.PARAMETER_GAMEID, String.valueOf(game_id));
		    map.put(CommonString.ONLINEPLAYERS, String.valueOf(countRs(game_id)));
		    list.add(map);
		}  
        return list;
	}
	
    public int countRs(String game_id){  
        int count = 0;  
        String sql = " select count(*) from member_Login where gameID = " + game_id ;   
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
	
}
