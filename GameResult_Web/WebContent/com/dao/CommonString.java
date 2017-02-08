package com.dao;

public class CommonString {
//	public static String DB_URL = "jdbc:mysql://10.36.1.102:3306/TEST";
	public static String DB_URL = "jdbc:mysql://10.36.1.102:3306/GF_Member";
	public static String DB_USER = "root";
	public static String DB_PW = "3edc2wsx!QAZ";
	public static String DB_DRIVER = "com.mysql.jdbc.Driver";
	
	public static final String PARAMETER_SELECT = "select";
	public static final String PARAMETER_GAMEID = "gameID";
	public static final String PARAMETER_PAGEINDEX = "pageIndex";
	public static final String PAREMETER_USERID = "userID";
	public static final String PARAMETER_DATE = "date";
	public static final String PARAMETER_ORDERBY = "orderby";
	public static final String PARAMETER_ASC = "asc";
	public static final String PARAMETER_SELPAGESIZE = "selPageSize";
	public static final String PARAMETER_YEAR = "year";
	public static final String PARAMETER_MONTH = "month";
	
	public static final String BALANCE = "balance";
	public static final String ONLINEPLAYERS = "OnlinePlayers";
	public static final String YYYYMMDD = "YYYY/MM/dd";
	public static final String BETTING = "betting";
	public static final String LINE = "line";
	public static final String RESULTS = "results";
	public static final String ROUNDSTATUS = "roundStatus";
	public static final String PRIZERESULTS= "prizeResults";
	public static final String BEFOREBALANCE = "beforeBalance";
	public static final String AFTERBALANCE = "afterBalance";
	public static final String AGENT = "agent";
	public static final String ORDERID = "orderID";
	public static final String RESULTSDATE = "resultsDate";
	public static final String RESULTSPARAMS = "resultsParams";
	public static final String TIME = "time";
	public static final String TIMES = "times";
	public static final String ROUNDUUID = "roundUUID";
	public static final String CURRENCY = "currency";
	public static final String LOGINID = "loginID";
	public static final String PASSWORD = "passWord";
	public static final String NICKNAME = "nickName";
	public static final String USERSTATUS = "userStatus";
	public static final String STATUS = "status";
	public static final String REGTYPE = "regType";
	public static final String GM = "gm";
	public static final String TEST_UESRID = "8846614";
	public static final String ALL = "ALL";
	public static final String DEFAULTMONTH = "01";
	public static final String DEFAULTYEAR = "2017";
	public static final String FREEGAME = "FreeGame";
	public static final String BONUSGAME = "BonusGame";
	public static final String ENTERFREEGAME = "EnterFreeGame";
	public static final String ENTERBONUSGAME = "EnterBonusGame";
	public static final String PLAYERS = "Players";
	public static final String ROUNDS = "Rounds";
	public static final String BET = "Bet";
	public static final String WIN = "Win";
	public static final String PROFIT = "Profit";
	public static final String PAYRATE  = "PayRate";
	public static final String COUNTS = "counts";
	public static final String GAMES = "Games";
	public static final String DAY = "Day";
	public static final String DAYS = "Days";
	public static final String MONTH = "Month";
	
	public static final String[] days_array = new String[] {"01","02","03","04","05","06","07","08","09","10",
															"11","12","13","14","15","16","17","18","19","20",
															"21","22","23","24","25","26","27","28","29","30","31"};
	public static final String[] months_array = new String[] {"01","02","03","04","05","06","07","08","09","10","11","12"};
	
	// db table: test_report
	public static final String[] gameid_array = new String[] {"game01+game02+game03+game04+game05+game06",
															  "game01", "game02","game03", "game04", "game05", "game06"};
	public static final String DAYTIMEBRGIN = " 00:00:00 ";
	public static final String DAYTIMEEND = " 23:59:59 ";
	public static final String TIMEDATE_QUATO = "'";
	public static final String SQLQUERYEND = ";";
	public static final String DOTS = ",";	
}
