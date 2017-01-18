package com.dao;

public class CommonString {
	public static String DB_URL = "jdbc:mysql://10.36.1.102:3306/TEST";
	public static String DB_USER = "root";
	public static String DB_PW = "3edc2wsx!QAZ";
	public static String DB_DRIVER = "com.mysql.jdbc.Driver";
	
	public static final String PARAMETER_SELECT = "select";
	public static final String PARAMETER_GAMEID = "gameID";
	public static final String PARAMETER_PAGEINDEX = "pageIndex";
	public static final String PAREMETER_USERID = "userID";
	public static final String PARAMETER_DATE = "date";
	
	public static final String BALANCE = "balance";
	public static final String ONLINEPLAYERS = "OnlinePlayers";
	public static final String YYYYMMDD = "YYYY/MM/dd";
	public static final String BETTING = "betting";
	public static final String LINES = "lines";
	public static final String RESULTS = "results";
	public static final String ROUNDSTATUS = "roundStatus";
	public static final String PRIZERESULTS= "prizeResults";
	public static final String BEFOREBALANCE = "beforeBalance";
	public static final String AFTERBALANCE = "afterBalance";
	public static final String SPECIALNUMBER = "specialNumber";
	public static final String RESULTSDATE = "resultsDate";
	public static final String RESULTSPARAMS = "resultsParams";
	public static final String TIME = "time";
	public static final String ROUNDUUID = "roundUUID";
	public static final String CURRENCY = "currency";
	public static final String LOGINID = "loginID";
	public static final String PASSWORD = "passWord";
	public static final String NICKNAME = "nickName";
	public static final String USERSTATUS = "userStatus";
	public static final String STATUS = "status";
	public static final String REGTYPE = "regType";
	public static final String GM = "gm";
	
	public static final String[] days_array = new String[] {"01","02","03","04","05","06","07","08","09","10",
															"11","12","13","14","15","16","17","18","19","20",
															"21","22","23","24","25","26","27","28","29","30","31"};
	public static final String[] months_array = new String[] {"01","02","03","04","05","06","07","08","09","10","11","12"};
	
	// db table: test_report
	public static final String[] gameid_array = new String[] {"game01+game02+game03+game04+game05+game06",
															  "game01", "game02","game03", "game04", "game05", "game06"};
}
