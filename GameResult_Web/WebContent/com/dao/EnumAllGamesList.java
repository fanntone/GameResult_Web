package com.dao;

public enum EnumAllGamesList {
	GAME_0("0000"),
	GAME_1("1001"),
	GAME_2("1002"),
	GAME_3("1003"),
	GAME_4("1004"),
	GAME_5("1005"),
	GAME_6("1006"),
	;
	private String value;
	private EnumAllGamesList(String value) {
		this.value = value;
	}
	public String getValue() {
		return this.value;
	}
	
	public static int length() {
		int count = 0;
        for(EnumAllGamesList eu : EnumAllGamesList.values()) {
        	if(eu != null)
        		count++;
        }
        return count;
	}
}
