package com.aaa.shopping.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;

import org.apache.tomcat.dbcp.dbcp.DbcpException;

import com.aaa.shopping.util.DB;

/**
 * 保存用户数据的类
 */
public class User {
	private int id;
	private String username;// 用户名
	private String password;// 密码
	private String phone;// 电话
	private String addr;// 地址
	private Date rdate;// 注册日期

	public User() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public Date getRdate() {
		return rdate;
	}

	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}

	/**
	 * 将User类的对象保存到数据库中
	 */
	public void save() {
		Connection connection = DB.getConnection();
		String sql = "insert into user values (null, ?, ?, ?, ?, ?) ";
		PreparedStatement preparedStatement = DB.prepare(connection, sql);
		try {
			preparedStatement.setString(1, username);
			preparedStatement.setString(2, password);
			preparedStatement.setString(3, phone);
			preparedStatement.setString(4, addr);
			preparedStatement.setTimestamp(5, new Timestamp(rdate.getTime()));
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(preparedStatement);
			DB.close(connection);
		}
	}

	/**
	 * 检查准备登录的用户是否存在
	 * @throws UserNotFoundException 
	 * @throws PasswordNotCorrectException 
	 */
	public static User checkUser(String username, String password) throws UserNotFoundException, PasswordNotCorrectException {
		User user = null;
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		String sql = "select * from user where username='" + username + "'";
		ResultSet resultSet = DB.getResultSet(statement, sql);
		try {
			if(!resultSet.next()) {
				throw new UserNotFoundException("用户名不存在：" + username);
			} else{
				if(!password.equals(resultSet.getString("password"))) {
					throw new PasswordNotCorrectException("密码不正确，请检查您的大小写输入键是否开启");
				}
				user = new User();
				user.setId(resultSet.getInt("id"));
				user.setUsername(resultSet.getString("username"));
				user.setPassword(resultSet.getString("password"));
				user.setPhone(resultSet.getString("phone"));
				user.setAddr(resultSet.getString("addr"));
				user.setRdate(resultSet.getDate("rdate"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
		DB.close(resultSet);
		DB.close(statement);
		DB.close(connection);
		}
		return user;
	}
}





















