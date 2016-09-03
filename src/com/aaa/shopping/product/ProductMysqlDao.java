package com.aaa.shopping.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

import com.aaa.shopping.util.DB;

public class ProductMysqlDao implements ProductDao{
	
	/**
	 * 添加产品
	 */
	public void addProduct(Product product) {
		Connection connection = DB.getConnection();
		String sql = "insert into product values (null, ?, ?, ?, ?, ?, ?)";
		PreparedStatement preparedStatement = DB.prepare(connection, sql);
		try {
			preparedStatement.setString(1, product.getName());
			preparedStatement.setString(2, product.getDescr());
			preparedStatement.setDouble(3, product.getNormalprice());
			preparedStatement.setDouble(4, product.getMemberprice());
			preparedStatement.setTimestamp(5, new Timestamp(product.getPdate().getTime()));
			preparedStatement.setInt(6, product.getCategoryid());
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(preparedStatement);
			DB.close(connection);
		}
	}
}
