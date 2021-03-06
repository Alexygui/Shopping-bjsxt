package com.aaa.shopping.product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.aaa.shopping.category.Category;
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
				Product product = this.getProductFromResultset(resultSet);
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
	private Product getProductFromResultset(ResultSet resultSet) {
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
	public Page getPageOfProduct(int currentPage) {
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

	/**
	 * 获得对应id号的product的数据
	 */
	@Override
	public Product getProductById(int id) {
		Product product = null;
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		ResultSet resultSet = DB.getResultSet(statement, "select * from product where id=" + id);
		try {
			resultSet.next();
			product = getProductFromResultset(resultSet);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(resultSet);
			DB.close(statement);
			DB.close(connection);
		}
		return product;
	}

	/**
	 * 更新product的数据
	 */
	@Override
	public void updateProduct(Product product) {
		Connection connection = DB.getConnection();
		String sql = "update product set name=?, descr=?, normalprice=?, memberprice=?, pdate=?, categoryid=? where id="
				+ product.getId();
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
	 * 简单搜索
	 */
	@Override
	public List<Product> simpleSearch(List<Product> products, Page page, String keywordWithLike) {
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		//product和category两张表连接起来查询
		String sql = "select p.id productid, p.name, p.descr, p.normalprice, p.memberprice, p.pdate, p.categoryid, c.id categoryid, c.pid, c.name, c.descr, c.cno, c.grade from product p join category c on (p.categoryid = c.id) "
				+ keywordWithLike + " order by p.pdate desc ";
		sql += "limit " + (page.getCurrentPage() - 1) * page.getPageSize() + ", " + page.getPageSize();
		System.out.println(sql);
		ResultSet resultSet = DB.getResultSet(statement, sql);
		
		//获得查询结果的数量
		Statement countStatement = DB.getStatement(connection);
		String countsql = "select count(*) from product " + keywordWithLike.replaceAll("p\\.", "");
		ResultSet countResultSet = DB.getResultSet(countStatement, countsql);
		try {
			countResultSet.next();
			//将查询的总数存入page对象中
			page.setTotalSize(countResultSet.getInt(1));
			
			while(resultSet.next()) {
				Product product = new Product();
				products.add(product);
				product.setId(resultSet.getInt("productid"));
				product.setName(resultSet.getString("name"));
				product.setDescr(resultSet.getString("descr"));
				product.setNormalprice(resultSet.getDouble("normalprice"));
				product.setMemberprice(resultSet.getDouble("memberprice"));
				product.setPdate(resultSet.getDate("pdate"));
				product.setCategoryid(resultSet.getInt("categoryid"));
				
				Category category = new Category();
				category.setId(resultSet.getInt("categoryid"));
				category.setPid(resultSet.getInt("pid"));
				category.setName(resultSet.getString("name"));
				category.setDescr(resultSet.getString("descr"));
				category.setCno(resultSet.getInt("cno"));
				category.setGrade(resultSet.getInt("grade"));
				product.setCategory(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(countResultSet);
			DB.close(countStatement);
			DB.close(resultSet);
			DB.close(statement);
			DB.close(connection);
		}
		return products;
	}

}
