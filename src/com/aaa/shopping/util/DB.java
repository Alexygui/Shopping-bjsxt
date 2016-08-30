package com.aaa.shopping.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 用于数据库连接的类
 */
public class DB {

	/**
	 * 新建mysql数据库连接的对象
	 */
	static {
		try {
			new com.mysql.jdbc.Driver();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * private属性的构造器，单例模式禁止新建对象
	 */
	private DB() {
	}

	/**
	 * 获得数据库连接
	 */
	public static Connection getConnection() {
		Connection connection = null;
		try {
			connection = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/shopping?useUnicode=true&characterEncoding=UTF-8&user=root&password=123456");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}

	/**
	 * 获得Statement
	 */
	public static Statement getStatement(Connection connection) {
		Statement statement = null;
		try {
			statement = connection.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return statement;
	}

	/**
	 * 获得PreparedStatement
	 */
	public static PreparedStatement prepare(Connection connection, String sql) {
		PreparedStatement preparedStatement = null;
		try {
			preparedStatement = connection.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return preparedStatement;
	}

	/**
	 * 获得ResultSet
	 */
	public static ResultSet getResultSet(Statement statement, String sql) {
		ResultSet resultSet = null;
		try {
			resultSet = statement.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return resultSet;
	}

	/**
	 * 关闭数据库连接
	 */
	public static void close(Connection connection) {
		try {
			if (connection != null) {
				connection.close();
				connection = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 关闭Statement
	 */
	public static void close(Statement statement) {
		try {
			if (statement != null) {
				statement.close();
				statement = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 关闭preparedStatement
	 */
	public static void close(PreparedStatement preparedStatement) {
		try {
			if (preparedStatement != null) {
				preparedStatement.close();
				preparedStatement = null;
		}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 关闭preparedStatement
	 */
	public static void close(ResultSet resultSet) {
		try {
			if (resultSet != null) {
				resultSet.close();
				resultSet = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		Connection connection = new DB().getConnection();
		System.out.println("connected");
		DB.close(connection);
	}
}
