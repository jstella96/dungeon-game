package com.allstar.dungeon.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberDTO {

	String id;
	String password;
    java.sql.Date lastSave;
	String life;
	int map;
	int x;
	int y;
}
