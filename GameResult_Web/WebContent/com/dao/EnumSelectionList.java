package com.dao;

public enum EnumSelectionList {
	SELECT_0("0"),
	SELECT_1("1"),
	SELECT_2("2"),
	SELECT_3("3"),
	SELECT_4("4"),
	SELECT_5("5"),
	SELECT_6("6"),
	SELECT_10("10"),
	SELECT_25("25"),
	SELECT_50("50"),
	SELECT_100("100"),
	;
	private String value;
	private EnumSelectionList(String value) {
		this.value = value;
	}
	public String getValue() {
		return this.value;
	}
	
	public static int length() {
		int count = 0;
        for(EnumSelectionList eu : EnumSelectionList.values()) {
        	if(eu != null)
        		count++;
        }
        return count;
	}
}
