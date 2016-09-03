package com.aaa.shopping.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.aaa.shopping.util.DB;
import com.aaa.shopping.util.Page;

public class ProductMysqlDao implements ProductDao {

	/**
	 * 添加产品
	 */
	@Override
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

	/**
	 * 获得所有的产品的
	 */
	@Override
	public List<Product> getProducts() {
		List<Product> products = new ArrayList<Product>();
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		String sql = "select * from product order by pdate desc";
		ResultSet resultSet = DB.getResultSet(statement, sql);
		try {
			while (resultSet.next()) {
				Product product = this.getProductsFromResultset(resultSet);
				products.add(product);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(resultSet);
			DB.close(statement);
			DB.close(connection);
		}

		return products;
	}

	/**
	 * 从Resultset中取出一个Product的对象
	 * 
	 * @param resultSet
	 */
	private Product getProductsFromResultset(ResultSet resultSet) {
		Product product = new Product();
		try {
			product.setId(resultSet.getInt("id"));
			product.setName(resultSet.getString("name"));
			product.setDescr(resultSet.getString("descr"));
			product.setNormalprice(resultSet.getDouble("normalprice"));
			product.setMemberprice(resultSet.getDouble("memberprice"));
			product.setPdate(resultSet.getDate("pdate"));
			product.setCategoryid(resultSet.getInt("categoryid"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return product;
	}

	/**
	 * 获取page对象
	 */
	@Override
	public Page getPage(int currentPage) {
		Page page = new Page();
		page.setCurrentPage(currentPage);
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		ResultSet resultSet = DB.getResultSet(statement, "select count(*) from product");
		try {
			resultSet.next();
			page.setTotalSize(resultSet.getInt(1));
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {

			DB.close(resultSet);
			DB.close(statement);
			DB.close(connection);
		}
		return page;
	}
}