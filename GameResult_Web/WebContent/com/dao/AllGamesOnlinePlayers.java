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
        List<String> game_list = new ArrayList<String>();
		game_list.add("1001");
		game_list.add("1002");
		game_list.add("1003");
		game_list.add("1004");
		game_list.add("1005");
		game_list.add("1006");
		
		for(int i = 0; i < game_list.size(); i++) {  
		    Map<String, String> map=new HashMap<String, String>();
		    String game_id = game_list.get(i);
		    map.put("GameID", String.valueOf(game_id));
		    map.put("OnlinePlayers", String.valueOf(countRs(game_id)));
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
        return count;  
    }  
	
}
