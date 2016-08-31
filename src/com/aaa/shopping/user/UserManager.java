package com.aaa.shopping.user;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.aaa.shopping.util.DB;

public class UserManager {
	/**
	 * 从数据库中取出所有的User
	 */
	public static List<User> getUsers() {
		List<User> userList = new ArrayList<User>();
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		String sql = "select * from user";
		ResultSet resultSet = DB.getResultSet(statement, sql);
		try {
			while (resultSet.next()) {
				User user = new User();
				userList.add(user);
				user.setId(resultSet.getInt("id"));
				user.setUsername(resultSet.getString("username"));
				user.setPassword(resultSet.getString("password"));
				user.setPhone(resultSet.getString("phone"));
				user.setAddr(resultSet.getString("addr"));
				user.setRdate(resultSet.getTimestamp("rdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(resultSet);
			DB.close(statement);
			DB.close(connection);
		}

		return userList;
	}

	/**
	 * 删除指定id号的User
	 */
	public static void deleteById(int id) {
		Connection connection = null;
		Statement statement = null;
		connection = DB.getConnection();
		statement = DB.getStatement(connection);
		String sql = "delete from user where id=" + id;
		try {
			statement.execute(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(statement);
			DB.close(connection);
		}

	}
}
