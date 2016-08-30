package com.aaa.shopping.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

import com.aaa.shopping.util.DB;

/**
 * 保存用户数据的类
 */
public class User {
	private int id;
	private String username;//用户名
	private String password;//密码
	private String phone;//电话
	private String addr;//地址
	private Date rdate;//注册日期
	
	public User() {}
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
}
