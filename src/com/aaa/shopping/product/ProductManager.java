package com.aaa.shopping.product;

import java.util.List;

import com.aaa.shopping.util.Page;

public class ProductManager {
	private static ProductDao productDao = new ProductMysqlDao();

	/**
	 * 获取product的数据
	 */
	public List<Product> getProducts() {
		return productDao.getProducts();
	}

	/**
	 * 获取page对象
	 */
	public Page getPageOfProduct(int currentPage) {
		return productDao.getPageOfProduct(currentPage);
	}
	
	/**
	 * 获得对应id号的product的数据
	 */
	public Product getProductById(int id) {
		return productDao.getProductById(id);
	}
	
/**
	 * 更新product的数据
	 */
	public void updateProduct(Product product) {
		productDao.updateProduct(product);
	}
	
	/**
	 * 简单搜索
	 */
	public List<Product> simpleSearch(List<Product> products, Page page, String keyword) {
		String keywordWithLike = "where p.name like '%"+ keyword +"%' or p.descr like '%"+ keyword + "%'";
		return productDao.simpleSearch(products, page, keywordWithLike);
	}
}
