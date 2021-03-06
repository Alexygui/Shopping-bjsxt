package com.aaa.shopping.category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.taglibs.standard.extra.spath.Step;
import org.apache.tomcat.dbcp.dbcp.DbcpException;

import com.aaa.shopping.util.DB;

public class CategoryDao {

	/**
	 * 添加类别
	 */
	public void add(Category category) {
		Connection connection = DB.getConnection();
		try {
			connection.setAutoCommit(false);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		String sql = "insert into category values (null, ?, ?, ?, ?, ?)";
		PreparedStatement preparedStatement = DB.prepare(connection, sql);
		try {
			int cno = getNextCno(connection, category);

			preparedStatement.setInt(1, category.getPid());
			preparedStatement.setString(2, category.getName());
			preparedStatement.setString(3, category.getDescr());
			preparedStatement.setInt(4, cno);

			preparedStatement.setInt(5, category.getGrade());
			// 提交之前要执行这句，不然也无法将数据查到数据库中
			preparedStatement.executeUpdate();
			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(preparedStatement);
			DB.close(connection);
		}
	}

	/**
	 * 通过获取该类别的cno编码
	 */
	private int getNextCno(Connection connection, Category category) {
		int cno = -1;
		String sqlMax = "select max(cno) from category where pid=" + category.getPid();
		Statement stmtMax = DB.getStatement(connection);
		ResultSet rsMax = DB.getResultSet(stmtMax, sqlMax);
		try {
			rsMax.next();
			int cnoMax = rsMax.getInt(1);
			// 计算节点的基数，如果两位表示就是100，三位表示就是1000
			int baseNumber = (int) Math.pow(10, category.LEVEL_LENGTH);
			// 构建cno数字串要加上的基础数字，也就是每个类别开始的数字，一级是10000，二级是100，三级是1
			int numberToAdd = (int) Math.pow(baseNumber, category.MAX_GRADE - category.getGrade());

			// 计算cno编码
			if (cnoMax == 0) { // 当前类别没有数据的时候cnoMax返回值为0
				if (category.getPid() == 0) {
					cno = numberToAdd; // 第一级的类别直接用类别起始数字numberToAdd
				} else {
					int parentCno = getParentCno(connection, category);
					// 非第一类别的则用他的父类别的cno加上本级别的起始数字numberToAdd
					cno = parentCno + numberToAdd;
				}
			} else {
				// 如果本类别已经有数据了，则直接用最大值加上本类别的起始数字
				cno = cnoMax + numberToAdd;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rsMax);
			DB.close(stmtMax);
		}
		return cno;
	}

	/**
	 * 获取当前category的父类型
	 */
	private int getParentCno(Connection connection, Category category) {
		int cno = -1;
		Statement statement = DB.getStatement(connection);
		String sql = "select cno from category where id=" + category.getPid();
		ResultSet resultSet = DB.getResultSet(statement, sql);
		try {
			resultSet.next();
			cno = resultSet.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(resultSet);
			DB.close(statement);
		}
		return cno;
	}

	/**
	 * 取出所有的category，以cno升序排列
	 */
	public List<Category> getCategories() {
		List<Category> categories = new ArrayList<Category>();
		Connection connection = DB.getConnection();
		String sql = "select * from category order by cno";
		Statement statement = DB.getStatement(connection);
		ResultSet resultSet = DB.getResultSet(statement, sql);
		try {
			while (resultSet.next()) {
				Category category = this.getCategoryFromResultset(resultSet);
				categories.add(category);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(resultSet);
			DB.close(statement);
			DB.close(connection);
		}

		return categories;
	}

	/**
	 * 获得查询所得category的字段的值
	 */
	private Category getCategoryFromResultset(ResultSet resultSet) {
		Category category = new Category();
		try {
			category.setId(resultSet.getInt("id"));
			category.setPid(resultSet.getInt("pid"));
			category.setName(resultSet.getString("name"));
			category.setDescr(resultSet.getString("descr"));
			category.setCno(resultSet.getInt("cno"));
			category.setGrade(resultSet.getInt("grade"));
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return category;
	}

	/**
	 * 查询对应的id号的category
	 */
	public Category getCategoryById(int id) {
		Category category = null;
		Connection connection = DB.getConnection();
		String sql = "select * from category where id=" + id;
		Statement statement = DB.getStatement(connection);
		ResultSet resultSet = DB.getResultSet(statement, sql);
		try {
			resultSet.next();
			category = this.getCategoryFromResultset(resultSet);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(statement);
			DB.close(connection);
		}

		return category;
	}

	/**
	 * 更新对应的category的数据
	 */
	public void updateCategory(Category category) {
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		String sql = "update category set name='" + category.getName() + "', descr='" + category.getDescr()
				+ "' where id=" + category.getId();
		DB.executeUpdate(statement, sql);
		DB.close(statement);
		DB.close(connection);
	}

	/**
	 * 删除category
	 */
	public void deleteCategoryById(int id) {
		Connection connection = DB.getConnection();
		Statement statement = DB.getStatement(connection);
		String sql = "delete from category where id=" + id;
		DB.executeUpdate(statement, sql);
		DB.close(statement);
		DB.close(connection);
	}
}
