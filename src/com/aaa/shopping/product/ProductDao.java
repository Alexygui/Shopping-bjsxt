package com.aaa.shopping.product;

import java.util.List;

import com.aaa.shopping.util.Page;

public interface ProductDao {
	
	public void addProduct(Product product);
	public List<Product> getProducts();
	public Page getPageOfProduct(int currentPage);
	public Product getProductById(int id);
	public void updateProduct(Product product);
	public List<Product> simpleSearch(List<Product> products, Page page, String keywordWithLike);
}
