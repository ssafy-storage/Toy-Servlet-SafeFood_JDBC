package com.ssafy.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.ssafy.util.DBUtil;
import com.ssafy.util.FoodSaxParser;
import com.ssafy.vo.Food;
import com.ssafy.vo.PageInfo;

public class FoodDBController {
	private static List<Food> foods;
	private static FoodDBController foodDBController;

	public static FoodDBController getInstance() {
		if (foodDBController == null) foodDBController = new FoodDBController();
		return foodDBController;
	}


	public static PageInfo insertFoodDB() throws SQLException {
		FoodSaxParser parser = FoodSaxParser.getInstance();
		foods = parser.getFoods();
		Connection conn = null;
		PreparedStatement stmt = null, stmt2 = null, stmt3 = null;
		ResultSet rs = null;
		String sql = "INSERT INTO FOOD VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		String sql2 = "INSERT INTO MATERIAL (food_code, name,origin) VALUES (?, ?, ?)";
		String sql3 = "insert into food_has_allergy select m.food_code,a.idx from (select food_code,name from material where name = any(( select name from allergy ))) m, allergy a where m.name = a.name";
		try {
			conn = DBUtil.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.prepareStatement(sql);
			stmt2 = conn.prepareStatement(sql2);
			stmt3 = conn.prepareStatement(sql3);
			for(Food food : foods) {
				System.out.println(food.getCode() + "번 음식");
				stmt.setInt(1, food.getCode());
				stmt.setString(2, food.getName());
				stmt.setDouble(3, food.getSupportpereat());
				stmt.setDouble(4, food.getCarbo());
				stmt.setDouble(5, food.getCalory());
				stmt.setDouble(6, food.getProtein());
				stmt.setDouble(7, food.getFat());
				stmt.setDouble(8, food.getSugar());
				stmt.setDouble(9, food.getNatrium());
				stmt.setDouble(10, food.getChole());
				stmt.setDouble(11, food.getFattyacid());
				stmt.setDouble(12, food.getTransfat());
				stmt.setString(13, food.getMaker());
				stmt.setString(14, food.getMaterial());
				stmt.setString(15, food.getImg());
				stmt.addBatch();

				String materialStr = food.getMaterial();
				String[] strArr = materialStr.split(",");

				for(int i = 0; i < strArr.length; i++) {
					String material = null;
					String origin = null; 
					if(strArr[i].contains("(")) {
						// 잘라야함
						// System.out.println(strArr[i]);
						material = strArr[i].substring(0, strArr[i].indexOf("("));
						origin = strArr[i].substring(strArr[i].indexOf(("("))+ 1, strArr[i].indexOf(")"));
					}else {
						System.out.println(strArr[i]);
						material = strArr[i];
					}
					stmt2.setInt(1, food.getCode());
					stmt2.setString(2, material);
					stmt2.setString(3, origin);
					stmt2.addBatch();
				}
			}
			stmt3.addBatch();
			
			stmt.executeBatch();
			stmt2.executeBatch();
			stmt3.executeBatch();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback(); // 롤백이 있기 때문에 catch를 지우면 안됨.
			throw e; // 예외 던짐
		} finally {
			DBUtil.close(stmt);
			DBUtil.close(conn);
		}

		return new PageInfo(false, "main.do?action=foodList");
	}

}
