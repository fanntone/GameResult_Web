package com.dao;

public enum EnumAllGamesList {
	GAME_0("25000"),
	GAME_1("25001"),
	GAME_2("25002"),
	GAME_3("25003"),
	GAME_4("25004"),
	GAME_5("25005"),
	GAME_6("25006"),
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
