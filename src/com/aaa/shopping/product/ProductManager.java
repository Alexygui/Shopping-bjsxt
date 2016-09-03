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
	public Page getPage(int currentPage) {
		return productDao.getPage(currentPage);
	}
}
