package com.allstar.dungeon.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemDTO {
	
	int id;
	int map;
	int x;
	int y;
	String name;
	String state;
	String use;
}
