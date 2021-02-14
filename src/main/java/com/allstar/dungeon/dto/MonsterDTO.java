package com.allstar.dungeon.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MonsterDTO {

	int id;
	int level;
	int life;
	int map;
	int minX;
	int maxX;
	int minY;
	int maxY;
	int x;
	int y;
	String position;
}
